# What Gets Rejected (and How to Avoid It)

Most rejections are fixable in hours, not weeks. The common ones:

---

## 1. Crashes or Major Bugs

**Apple's #1 reason.** They tap around for a few minutes; if your app crashes, rejected.

**Prevent:**
- Test on a real device, not just the simulator.
- Test on the oldest supported iOS version.
- Handle empty states (empty list, no network, denied permissions).
- Never force-unwrap data from the network.

---

## 2. Missing "Account Deletion"

If your app lets users **sign up**, you must also let them **delete their account** from inside the app.

**Prevent:** Add a Settings → Delete Account button that wipes the server record.

---

## 3. Placeholder Content

"Lorem ipsum," "TODO," or obvious sample data will get rejected.

**Prevent:** Ship with real content or clear empty states.

---

## 4. Uses APIs Without a Usage String

Trying to use camera/mic/photos/location without `NSCameraUsageDescription` (etc.) in `Info.plist` causes a crash — instant rejection.

**Prevent:** Every permission needs a one-sentence reason in `Info.plist`. See [01-Prepare-Your-App.md](./01-Prepare-Your-App.md).

---

## 5. Mentioning Other Platforms

Don't say "Also available on Android!" in your description. Apple doesn't like it.

**Prevent:** Describe only the iOS app.

---

## 6. Inappropriate Content

Sexual content, gratuitous violence, hate speech, illegal activities. Also — **user-generated content must be moderatable** (report button, block button, terms of service).

**Prevent:** If users can post content visible to other users, add:
- A way to report content.
- A way to block users.
- A mechanism for you to remove content.

---

## 7. Broken Links

Every URL in your listing (support, privacy policy) must return a real page. Apple checks.

**Prevent:** Put up a simple Notion or GitHub Pages page. Free and fine.

---

## 8. Safety Net Issues

- **Web view pretending to be a native app** → rejected.
- **Pointless "empty" apps** (e.g., "Hello World" as your first submission) → rejected.
- **Apps that just show your resume/portfolio** → rejected. Build a real website for that.

---

## 9. Login Requirement Without a Demo Account

If your app requires login, you MUST give Apple a demo account in **App Review Information.**

**Prevent:** Create a test user, put the credentials in review notes.

---

## 10. Sign in with Apple (Sometimes Required)

If you offer third-party sign-in (Google, Facebook, etc.) you **must also** offer Sign in with Apple.

**Prevent:** Either offer no third-party sign-in, or add Sign in with Apple.

---

## If You Get Rejected

- Read the reviewer's note carefully. It tells you exactly what to fix.
- Reply in **Resolution Center** if something is unclear or you think they misunderstood.
- Fix the issue, upload a new build, resubmit. Most apps are approved on their second or third try.

Rejection is normal. Don't take it personally.
