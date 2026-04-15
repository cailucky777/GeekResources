# When to Use What: A Persistence Decision Guide

Stop guessing. Answer four questions.

---

## The Decision Tree

```
1. Is it sensitive (passwords, API tokens)?
   → Use the KEYCHAIN (not covered here — look up KeychainAccess or SwiftKeychainWrapper).

2. Is it one or two small values (bool, number, short string)?
   → Use @AppStorage / UserDefaults.

3. Is it a bunch of structured records you'll search, sort, or relate?
   → Use SwiftData.

4. Is it a single blob — a file, image, or exported document?
   → Use FileManager + Documents/.
```

---

## Worked Examples

| Scenario | Right Tool | Why |
|---|---|---|
| User toggled Dark Mode | `@AppStorage` | One boolean |
| Logged-in user's ID | `@AppStorage` | One string |
| List of journal entries | SwiftData | Searchable, growing |
| 1000 quiz questions shipped with the app | Bundled JSON (read-only) | Doesn't change |
| Photos the user imported | `FileManager` (Documents) | Big binary blobs |
| High-score leaderboard shared across devices | Server / CloudKit | Needs sync |
| Login token | Keychain | Sensitive |
| Draft of a post the user is writing | `@AppStorage` (small) or SwiftData | Depends on size |

---

## Anti-patterns to Avoid

- ❌ **JSON files for 100 small settings.** Use `@AppStorage`.
- ❌ **`@AppStorage` for a list of 200 recipes.** Slow, ugly. Use SwiftData.
- ❌ **Plaintext storage of tokens.** Use Keychain.
- ❌ **Storing user photos in `UserDefaults` as base64.** Please don't. Use the file system.

---

## Performance Rule of Thumb

| Data Size | Good Options |
|---|---|
| < 1 KB | `@AppStorage` |
| 1 KB – 1 MB | JSON file or SwiftData |
| 1 MB – 100 MB | FileManager (Documents) |
| > 100 MB | Server, streamed downloads |

---

## Security Quick Note

- Files in `Documents/` are **not encrypted by default** (though the whole device is once a passcode is set).
- For anything truly secret, use the **Keychain**, not files.
- Never commit API keys or tokens to Git. See `../Soft-Skills/AI-Pair-Programming.md` — the same "don't commit secrets" rule applies everywhere.
