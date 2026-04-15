# Security and Privacy for Student Apps

Even a school project handles data. Being careful is a habit worth building early.

---

## The Rules That Prevent 95% of Problems

1. **Never commit secrets.** API keys, passwords, OAuth tokens belong in env vars or Keychain — never in source.
2. **Use HTTPS for every network call.** iOS already enforces this by default — don't disable App Transport Security.
3. **Validate everything from the user or the internet.** Assume input is malicious until proven otherwise.
4. **Collect the minimum data you need.** Don't log full JSON bodies if you only need a user ID.
5. **Delete data you no longer need.** Yesterday's debug log is today's leak.

---

## iOS-Specific Best Practices

### Store Sensitive Data in Keychain

```swift
// Tokens, passwords, OAuth
// Use a wrapper like KeychainAccess (Swift Package).
import KeychainAccess

let keychain = Keychain(service: "com.yourname.app")
keychain["authToken"] = token
let t = keychain["authToken"]
```

Never store these in `UserDefaults` or plain files.

### Request the Fewest Permissions

Only ask for camera, contacts, location, etc. when the user tries to do something that needs them. Apple's **Provisional Notifications** and **one-time photo picker** let you get a lot done without a blanket permission.

### Usage Descriptions Should Be Honest

> ✅ "Used to scan QR codes in the Pay Friends feature."
>
> ❌ "App needs camera."

Apple reviewers (and users) can tell.

### Log Smartly

```swift
import OSLog
let log = Logger(subsystem: "com.you.app", category: "network")

log.debug("Request \(url, privacy: .public)")
log.debug("Token \(token, privacy: .private)")
```

`privacy: .private` hides data in production logs. Apple's Logger does this right.

---

## Common Student Mistakes

- **Hardcoding API keys** into Swift code. Anyone with a decompiler sees them.
- **Trusting a server's response blindly.** Your JSON decoder won't prevent XSS if you feed HTML into a WebView.
- **Logging personal info to the console.** Crash reports catch it.
- **Sharing test accounts** that happen to have real data.
- **Committing `.env` files.** Add `.env` to `.gitignore` on day one.

---

## When Your App Collects Personal Data

Even if your app is free and student-made, if it collects personal data you should:

- Tell users **what you collect, why, and for how long.**
- Provide a **privacy policy URL** (a one-page GitHub Pages site is fine).
- Let users **delete their data** on request (and from the app).
- Encrypt anything sensitive **at rest and in transit.**

Apple requires a privacy policy URL to ship to the App Store. Write one even before then — it clarifies your own thinking.

---

## If You Handle Other Students' Data

A little extra care:

- Get written permission (a teacher's OK) before collecting classmate data.
- Anonymize where possible — use random IDs instead of names.
- Don't use production Firebase/Airtable/Google Sheets for school projects without security rules.
- Wipe all data when the class ends.

---

## Red-Team Your Own App

Spend 15 minutes asking "how would I abuse this?":

- What if the user enters 10 MB of text in a name field?
- What if the server sends a bad JSON?
- What if someone opens DevTools on the web side and tampers with the request?
- What if the user is offline? On a flaky connection?

Fix what you find. These are free bug reports from the person who knows your app best.

---

## Further Reading

- **OWASP Mobile Top 10** — common mobile vulnerabilities.
- **Apple's [Security Overview](https://developer.apple.com/documentation/security)**.
- **Frank Abagnale rule:** if it's too good/convenient to be true (skipping auth, free unlimited API), something's wrong.
