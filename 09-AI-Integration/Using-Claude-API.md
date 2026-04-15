# Using the Claude API from Swift

Claude is made by Anthropic. Its API is a plain HTTP endpoint — you don't need a special SDK for Swift.

> ⚠️ Read [Safety-First-API-Keys.md](./Safety-First-API-Keys.md) before copying any code.

---

## 1. Get an API Key

1. Go to [console.anthropic.com](https://console.anthropic.com).
2. Sign up and add a small amount of credit.
3. **Create an API key.** Copy it (starts with `sk-ant-...`).

---

## 2. Modeling the Request

Claude's Messages API takes a JSON like:

```json
{
  "model": "claude-opus-4-6",
  "max_tokens": 1024,
  "messages": [
    { "role": "user", "content": "Explain recursion in one sentence." }
  ]
}
```

And returns:

```json
{
  "id": "msg_123",
  "content": [
    { "type": "text", "text": "A function calls itself with a smaller problem until a base case." }
  ]
}
```

---

## 3. Swift Models

```swift
import Foundation

struct ClaudeRequest: Codable {
    let model: String
    let max_tokens: Int
    let messages: [Message]

    struct Message: Codable {
        let role: String     // "user" or "assistant"
        let content: String
    }
}

struct ClaudeResponse: Codable {
    let content: [Block]
    struct Block: Codable {
        let type: String
        let text: String
    }
}
```

---

## 4. The API Call

```swift
enum ClaudeError: Error {
    case missingKey
    case badResponse(String)
}

func askClaude(_ prompt: String) async throws -> String {
    guard let key = ProcessInfo.processInfo.environment["CLAUDE_API_KEY"] else {
        throw ClaudeError.missingKey
    }

    let url = URL(string: "https://api.anthropic.com/v1/messages")!
    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    req.setValue(key, forHTTPHeaderField: "x-api-key")
    req.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")
    req.setValue("application/json", forHTTPHeaderField: "content-type")

    let body = ClaudeRequest(
        model: "claude-opus-4-6",
        max_tokens: 1024,
        messages: [.init(role: "user", content: prompt)]
    )
    req.httpBody = try JSONEncoder().encode(body)

    let (data, response) = try await URLSession.shared.data(for: req)

    guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
        throw ClaudeError.badResponse(String(data: data, encoding: .utf8) ?? "unknown")
    }

    let decoded = try JSONDecoder().decode(ClaudeResponse.self, from: data)
    return decoded.content.first?.text ?? ""
}
```

---

## 5. Using It From SwiftUI

```swift
struct AskView: View {
    @State private var prompt = ""
    @State private var answer = ""
    @State private var isLoading = false
    @State private var error: String?

    var body: some View {
        VStack(spacing: 16) {
            TextField("Ask Claude anything", text: $prompt)
                .textFieldStyle(.roundedBorder)

            Button("Ask") {
                Task { await submit() }
            }
            .disabled(prompt.isEmpty || isLoading)

            if isLoading { ProgressView() }
            if let error { Text(error).foregroundStyle(.red) }

            ScrollView { Text(answer).textSelection(.enabled) }
        }
        .padding()
    }

    func submit() async {
        isLoading = true
        defer { isLoading = false }
        do {
            answer = try await askClaude(prompt)
            error = nil
        } catch {
            self.error = "\(error)"
        }
    }
}
```

---

## 6. Adding Conversation History

Claude is stateless — each call is independent. To make a chat, **send the whole history every time**:

```swift
var history: [ClaudeRequest.Message] = []

func chat(_ userMessage: String) async throws -> String {
    history.append(.init(role: "user", content: userMessage))
    let body = ClaudeRequest(model: "claude-opus-4-6", max_tokens: 1024, messages: history)
    // ... send request as above ...
    let reply = /* parsed */ ""
    history.append(.init(role: "assistant", content: reply))
    return reply
}
```

History grows with every turn. For long chats, trim old messages or summarize them.

---

## 7. System Prompts

A "system prompt" shapes Claude's personality and rules. Add it to the request:

```swift
struct ClaudeRequest: Codable {
    let model: String
    let max_tokens: Int
    let system: String?          // new
    let messages: [Message]
    // ...
}

let body = ClaudeRequest(
    model: "claude-opus-4-6",
    max_tokens: 1024,
    system: "You are a patient tutor for middle-school students. Use simple words.",
    messages: history
)
```

---

## Exercise

Build a **"Explain Like I'm 10"** app:

1. TextField where the user pastes a technical paragraph.
2. Button calls Claude with a system prompt: *"Rewrite the following at a 5th-grade reading level."*
3. Display the simpler version.
4. Let the user tap "Even simpler" to iterate.
