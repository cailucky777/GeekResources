# TestFlight Guide

TestFlight lets you hand your app to real testers before the App Store. It's the step every serious project should go through.

---

## Overview

1. Upload a build from Xcode.
2. It appears in **App Store Connect**.
3. Invite testers via email or a public link.
4. They install the **TestFlight** app, tap a link, and get your app.

---

## Step 1 — App Store Connect

1. Go to [appstoreconnect.apple.com](https://appstoreconnect.apple.com).
2. **My Apps → +** → **New App**.
3. Fill in:
   - Platform: iOS
   - Name (can change later)
   - Language
   - Bundle ID (pick the one from your Xcode project)
   - SKU (any string, e.g., `flashcards001`)
4. **Create.**

---

## Step 2 — Archive & Upload from Xcode

1. Select **Any iOS Device** as the run destination.
2. **Product → Archive**.
3. Organizer opens. Click **Distribute App → App Store Connect → Upload.**
4. Wait for the ☁️ upload to finish (5–15 minutes).

If it fails:
- Missing signing — re-check team and bundle ID.
- Missing required icon sizes — use a 1024×1024 icon in Assets.
- Duplicate build number — bump the build number.

---

## Step 3 — Back in App Store Connect

1. Under your app, click **TestFlight**.
2. Your build appears with "Processing" for 5–30 minutes.
3. Once processed, click it and fill in the required fields:
   - **What to Test** — one paragraph of notes for testers.
   - **Test Information → Beta App Description / Contact Info / Feedback Email.**
   - **Export Compliance** — if you only use standard HTTPS, answer "Yes, uses encryption" and "Yes, exempt."

---

## Step 4 — Invite Testers

### Internal Testers (25 max, instant)

Must be users in your App Store Connect team.

1. **TestFlight → Internal Testing → + → Create Group.**
2. Add builds. Add users by email.
3. They get an email → install TestFlight → app installs.

### External Testers (up to 10,000, requires Beta App Review)

1. **External Testing → + → Add a Group.**
2. Add builds, testers (email or public link).
3. The build goes through a lightweight Apple review (usually 24–48 hours the first time).
4. Once approved, invites go out.

**Public Link** is easiest for a classroom — one URL that anyone can tap to join.

---

## What Testers See

1. Email or link → **"Open in TestFlight."**
2. They install **TestFlight** from the App Store if they don't have it.
3. They tap **Install** on your app.
4. Each build is valid for **90 days.** Upload a new build before then.

---

## Typical Classroom Workflow

1. Each student uploads their own build as version `1.0.0 (1)`.
2. Share public link with classmates.
3. Classmates install and leave feedback through TestFlight's built-in screenshot + comments.
4. Student iterates; uploads `1.0.0 (2)`, `1.0.0 (3)`, ...
5. For the final demo, bump to `1.0.0 (final)`.

---

## Exercise

- [ ] Archive and upload your current project.
- [ ] Complete the TestFlight metadata.
- [ ] Invite 3 friends (internal) or generate a public link.
- [ ] Collect at least one piece of feedback and address it in a `1.0.0 (2)` build.
