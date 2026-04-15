# Tutorial: Build a Chatbot App

End-to-end SwiftUI project. At the end you'll have a working chat UI talking to Claude with full conversation memory.

---

## What You'll Build

A single screen with:

- A scrollable list of messages (user + AI).
- A text field and Send button.
- A loading indicator while Claude thinks.

---

## Step 1 — Project Setup

1. Create a new SwiftUI iOS app. Call it **ClaudeChat**.
2. Follow [Safety-First-API-Keys.md](./Safety-First-API-Keys.md) to set `CLAUDE_API_KEY` as a scheme environment variable.

---

## Step 2 — The Message Model

```swift
// Message.swift
import Foundation

struct ChatMessage: Identifiable, Equatable {
    enum Role { case user, assistant }
    let id = UUID()
    let role: Role
    let text: String
}
```

---

## Step 3 — The View Model

```swift
// ChatViewModel.swift
import Foundation

@Observable
final class ChatViewModel {
    var messages: [ChatMessage] = []
    var input: String = ""
    var isLoading = false
    var errorMessage: String?

    private let systemPrompt =
        "You are a friendly tutor for teenagers learning to code. " +
        "Keep answers concise and encouraging."

    func send() async {
        let userText = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userText.isEmpty else { return }
        input = ""
        messages.append(.init(role: .user, text: userText))
        isLoading = true
        defer { isLoading = false }

        do {
            let reply = try await callClaude()
            messages.append(.init(role: .assistant, text: reply))
        } catch {
            errorMessage = "\(error)"
        }
    }

    private func callClaude() async throws -> String {
        guard let key = ProcessInfo.processInfo.environment["CLAUDE_API_KEY"] else {
            throw NSError(domain: "Chat", code: 1,
                          userInfo: [NSLocalizedDescriptionKey: "Missing CLAUDE_API_KEY"])
        }

        struct Req: Encodable {
            struct Msg: Encodable { let role: String; let content: String }
            let model: String
            let max_tokens: Int
            let system: String
            let messages: [Msg]
        }
        struct Resp: Decodable {
            struct Block: Decodable { let text: String }
            let content: [Block]
        }

        let body = Req(
            model: "claude-opus-4-6",
            max_tokens: 1024,
            system: systemPrompt,
            messages: messages.map {
                .init(role: $0.role == .user ? "user" : "assistant", content: $0.text)
            }
        )

        var req = URLRequest(url: URL(string: "https://api.anthropic.com/v1/messages")!)
        req.httpMethod = "POST"
        req.setValue(key, forHTTPHeaderField: "x-api-key")
        req.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
        req.setValue("application/json", forHTTPHeaderField: "content-type")
        req.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: req)
        let decoded = try JSONDecoder().decode(Resp.self, from: data)
        return decoded.content.first?.text ?? ""
    }
}
```

---

## Step 4 — The View

```swift
// ChatView.swift
import SwiftUI

struct ChatView: View {
    @State private var vm = ChatViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(vm.messages) { msg in
                                Bubble(message: msg).id(msg.id)
                            }
                            if vm.isLoading {
                                ProgressView().frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: vm.messages.count) { _, _ in
                        if let id = vm.messages.last?.id {
                            withAnimation { proxy.scrollTo(id, anchor: .bottom) }
                        }
                    }
                }
                Divider()
                inputBar
            }
            .navigationTitle("Claude Chat")
            .alert("Error", isPresented: .init(
                get: { vm.errorMessage != nil },
                set: { if !$0 { vm.errorMessage = nil } })) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(vm.errorMessage ?? "")
            }
        }
    }

    var inputBar: some View {
        HStack {
            TextField("Ask anything…", text: $vm.input, axis: .vertical)
                .lineLimit(1...5)
                .textFieldStyle(.roundedBorder)
            Button {
                Task { await vm.send() }
            } label: {
                Image(systemName: "paperplane.fill")
            }
            .disabled(vm.isLoading || vm.input.trimmingCharacters(in: .whitespaces).isEmpty)
        }
        .padding()
    }
}

struct Bubble: View {
    let message: ChatMessage
    var body: some View {
        HStack {
            if message.role == .assistant { Spacer(minLength: 0).frame(width: 0) }
            Text(message.text)
                .padding(12)
                .background(message.role == .user ? .blue : .gray.opacity(0.15))
                .foregroundStyle(message.role == .user ? .white : .primary)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(maxWidth: 280, alignment: message.role == .user ? .trailing : .leading)
            if message.role == .user { Spacer(minLength: 0).frame(width: 0) }
        }
        .frame(maxWidth: .infinity, alignment: message.role == .user ? .trailing : .leading)
    }
}
```

---

## Step 5 — Wire It Up

```swift
// ClaudeChatApp.swift
@main
struct ClaudeChatApp: App {
    var body: some Scene {
        WindowGroup { ChatView() }
    }
}
```

Run it. Type "hi". You should see your message, a spinner, then Claude's reply.

---

## Extensions

Once it works, try:

1. **Persistence** — save `messages` to disk (see `../08-Data-Persistence/FileManager-Basics.md`) so chats survive relaunch.
2. **Multiple conversations** — a sidebar of past chats.
3. **Streaming responses** — tokens appear one-at-a-time (look up `AsyncSequence` + Anthropic's `stream` parameter).
4. **Prompt presets** — buttons like "Explain", "Translate", "Summarize" that pre-fill the input.
5. **Voice input** — use `SFSpeechRecognizer` to dictate messages.

---

## Troubleshooting

| Symptom | Likely Fix |
|---|---|
| "Missing CLAUDE_API_KEY" | Set the scheme env var and re-run |
| 401 Unauthorized | Key typo or revoked |
| 400 Invalid request | Check `max_tokens`, model name, and message shape |
| Silent hang | Add `print` on response `data` as a string to see the raw reply |
