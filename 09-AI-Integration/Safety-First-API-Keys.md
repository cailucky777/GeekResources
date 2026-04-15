# Safety First: API Keys

> Read this before you write any code.

An API key is like a password attached to your credit card. If it leaks, someone else can spend your money. This has happened to thousands of beginners — don't be one of them.

---

## The Three Rules

### 1. Never paste an API key into source code.

```swift
// ❌ DANGEROUS — don't do this
let apiKey = "sk-ant-abc123..."
```

If you commit this to GitHub, **bots will find it within minutes** and drain your account.

### 2. Never commit `.env` or config files with secrets.

Always add to `.gitignore`:

```
# .gitignore
Config.swift
Secrets.xcconfig
.env
```

### 3. For production apps, route calls through your own backend.

The safest pattern is:

```
iPhone app  →  your server  →  Anthropic / OpenAI API
```

Your server holds the key. The iPhone never sees it. Even if someone tears apart your app binary, they can't extract what isn't there.

---

## For Student Projects (Local Development)

While you're learning, a lightweight-safe approach:

### Option A: Xcode `.xcconfig` File

1. `File → New → File from Template → Configuration Settings File`. Name it `Secrets.xcconfig`. **Don't** check "Add to target."
2. Add your key:
   ```
   CLAUDE_API_KEY = sk-ant-abc123...
   ```
3. In your target's **Build Settings → User-Defined**, add it from the xcconfig.
4. Add to `Info.plist`:
   ```
   CLAUDE_API_KEY  →  $(CLAUDE_API_KEY)
   ```
5. Read in Swift:
   ```swift
   let key = Bundle.main.object(forInfoDictionaryKey: "CLAUDE_API_KEY") as? String
   ```
6. Add `Secrets.xcconfig` to `.gitignore`.

### Option B: Environment Variable (Xcode Scheme)

1. **Product → Scheme → Edit Scheme... → Run → Arguments → Environment Variables**.
2. Add `CLAUDE_API_KEY = sk-ant-...`.
3. Read in Swift:
   ```swift
   let key = ProcessInfo.processInfo.environment["CLAUDE_API_KEY"]
   ```
4. This key only exists when *you* run from Xcode. It's never compiled in.

---

## What to Do If You Leak a Key

1. **Revoke it immediately** on the provider's dashboard.
2. Create a new key.
3. Check your billing page for unexpected usage.
4. If you committed it to GitHub, **deleting the commit isn't enough** — assume it was scraped.

---

## Quick Checks Before Every Commit

```bash
# Does the diff mention 'sk-' or 'api_key'?
git diff --cached | grep -Ei 'sk-|api_?key|secret'

# If anything shows up, remove it before committing.
```

You can also install a tool like **`git-secrets`** to block commits automatically.

---

## Summary

| Stage | Where the key lives |
|---|---|
| Learning on your own Mac | `.xcconfig` or scheme env var (not committed) |
| Shipping to real users | Your own backend server |
| Demo for class | Your teacher's key in a local config, or a free-tier proxy |

Be paranoid. Keys leak.
