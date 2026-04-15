# 09 — AI Integration

> The most exciting and natural extension of the API unit: connect your app to a real LLM.

This unit teaches how to call the **Claude API** (Anthropic) and the **OpenAI API** from Swift, build a simple chat interface, and — most importantly — **handle API keys safely**.

---

## Contents

| File | Topic |
|---|---|
| [Safety-First-API-Keys.md](./Safety-First-API-Keys.md) | How to never leak a key (read this first!) |
| [Using-Claude-API.md](./Using-Claude-API.md) | Call Claude from Swift using URLSession |
| [Using-OpenAI-API.md](./Using-OpenAI-API.md) | Same thing for OpenAI |
| [Build-A-Chatbot-App.md](./Build-A-Chatbot-App.md) | End-to-end tutorial: SwiftUI chat with message history |
| [Prompt-Engineering-Basics.md](./Prompt-Engineering-Basics.md) | How to write prompts that actually work |

---

## Project Ideas

- 🧑‍🏫 **Homework helper** — explain any paragraph at a simpler reading level.
- 🌍 **Translator** — input any sentence, output in 10 languages.
- 🍳 **Recipe generator** — given ingredients, suggest dinner.
- 🎨 **Story builder** — co-write a short story with an AI collaborator.
- 🧠 **Flashcard quizzer** — AI generates quiz questions from notes.

---

## Prerequisites

- `05-API-and-Networking` (URLSession, JSON, async/await).
- An API key from either [console.anthropic.com](https://console.anthropic.com) or [platform.openai.com](https://platform.openai.com).

---

## Ethics & Etiquette

- **Disclose AI use** — if your app generates text, say so.
- **Don't pretend to be a human.** It's dishonest and against most providers' terms.
- **Be mindful of cost** — each API call costs money. Add rate limits and caching.
- **Never ship a hardcoded API key** — users can extract it from your app.

---

## Recommended Duration

**2–3 weeks.**
