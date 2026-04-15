# Using the OpenAI API from Swift

The OpenAI Chat Completions API is structured very similarly to Claude's — if you've done the Claude tutorial, this will feel familiar.

> ⚠️ Read [Safety-First-API-Keys.md](./Safety-First-API-Keys.md) before writing any code.

---

## 1. Get an API Key

1. Go to [platform.openai.com](https://platform.openai.com).
2. Sign up, add billing.
3. Create a secret key (starts with `sk-...`).

---

## 2. Swift Models

```swift
struct OpenAIRequest: Codable {
    let model: String
    let messages: [Message]

    struct Message: Codable {
        let role: String          // "system" | "user" | "assistant"
        let content: String
    }
}

struct OpenAIResponse: Codable {
    let choices: [Choice]
    struct Choice: Codable {
        let message: OpenAIRequest.Message
    }
}
```

---

## 3. The Call

```swift
func askOpenAI(_ prompt: String) async throws -> String {
    guard let key = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] else {
        throw URLError(.userAuthenticationRequired)
    }

    var req = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
    req.httpMethod = "POST"
    req.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
    req.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let body = OpenAIRequest(
        model: "gpt-4o-mini",
        messages: [
            .init(role: "system", content: "You are a helpful assistant."),
            .init(role: "user", content: prompt)
        ]
    )
    req.httpBody = try JSONEncoder().encode(body)

    let (data, _) = try await URLSession.shared.data(for: req)
    let decoded = try JSONDecoder().decode(OpenAIResponse.self, from: data)
    return decoded.choices.first?.message.content ?? ""
}
```

---

## 4. Differences vs. Claude

| | Claude | OpenAI |
|---|---|---|
| Auth header | `x-api-key: <key>` | `Authorization: Bearer <key>` |
| Version header | `anthropic-version: 2023-06-01` | — |
| System prompt | top-level `system` field | first message with `role: "system"` |
| Response path | `content[0].text` | `choices[0].message.content` |
| `max_tokens` | required | optional |

---

## 5. When to Choose Which

Both are fantastic. Rule-of-thumb for students:

- **Claude** shines on long-form reasoning, careful rewriting, coding help, honest "I don't know" answers.
- **OpenAI** has the biggest ecosystem and cheapest tier (`gpt-4o-mini`).

Try both on your actual prompts. Pick the one that gives better answers for your use case.

---

## Exercise

Pick one app idea (story generator, translator, tutor). Build it twice — once with Claude, once with OpenAI. Compare:

1. Answer quality.
2. Latency.
3. Cost per call (check the dashboard).
4. How strictly each follows your system prompt.

Write a 1-paragraph reflection on what you learned.
