# 08 — Data Persistence

> Every real app has to answer one question: **"How do I not lose the user's data when they close me?"**

This unit walks through the four ways iOS apps save data, from simplest to most powerful.

---

## The Persistence Ladder

| Tool | Good For | Don't Use For |
|---|---|---|
| **`@AppStorage` / `UserDefaults`** | Small preferences: dark mode, user name, last-seen tab | Large data, arrays of objects |
| **File system (`FileManager`)** | JSON/text/images on disk | Searching across records |
| **SwiftData** | Structured, searchable app data (todo items, notes, scores) | Sharing across devices out of the box |
| **Server / CloudKit** | Sharing data across devices or users | Offline-first simple apps |

**Pick the simplest tool that does the job.** Starting with SwiftData for a "dark mode toggle" is overkill.

---

## Contents

| File | Topic |
|---|---|
| [UserDefaults.md](./UserDefaults.md) | The easiest way to save small values |
| [FileManager-Basics.md](./FileManager-Basics.md) | Read and write JSON files |
| [SwiftData-Intro.md](./SwiftData-Intro.md) | Modern on-device database for SwiftUI |
| [When-to-Use-What.md](./When-to-Use-What.md) | Decision guide with examples |

---

## Prerequisites

- `01-Swift-Fundamentals` (`Codable`, structs, optionals)
- `02-SwiftUI-App-Development` (`@State`, `@Binding`)

---

## Recommended Duration

**2 weeks.**
