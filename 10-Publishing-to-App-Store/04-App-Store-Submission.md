# App Store Submission

Once your app works on real devices and TestFlight feedback is good, the last step is App Review.

---

## What Apple Looks At

- Your app actually works and doesn't crash.
- It does what the description says.
- Screenshots match reality.
- It doesn't abuse user data.
- It doesn't copy someone else's app.
- Anything involving accounts allows sign-out and account deletion.

**Reviewers are humans.** Be clear and cooperative.

---

## The Listing (App Store Connect → App Store Tab)

### Required

| Field | Notes |
|---|---|
| **Name** (30 chars) | Your app's public name |
| **Subtitle** (30 chars) | One-line elevator pitch |
| **Description** (4000 chars) | What it does, key features. Avoid marketing hype. |
| **Keywords** (100 chars total) | Comma-separated, for search |
| **Primary Category** | E.g., Education, Games, Productivity |
| **Support URL** | Any web page where users can reach you |
| **Privacy Policy URL** | Required even for "doesn't collect data" apps |
| **Screenshots** | At least one set per device size (see below) |

### Screenshots

Sizes Apple currently requires:

- **6.9-inch** (iPhone 16 Pro Max) — 1320×2868
- **6.7-inch** (iPhone 15 Pro Max) — 1290×2796
- **6.5-inch** (iPhone 11 Pro Max) — 1242×2688 *(optional if 6.7 provided)*
- **iPad Pro 12.9-inch (3rd gen and later)** — 2048×2732 (if you support iPad)

Check [developer.apple.com](https://developer.apple.com/help/app-store-connect/reference/screenshot-specifications) for the current list.

**Tips:**
- Use the simulator's "Save Screen" command to capture clean shots.
- Or use Figma/Sketch to make designed promo screenshots.
- First screenshot is the most important — it shows up in search.

---

## App Privacy

Apple asks you to declare what data you collect, even if you collect none.

Under **App Privacy**, answer honestly:
- Does the app collect data? → Yes/No
- If yes, which types, for what purpose, linked to user?
- Third parties (analytics, ads) count too.

A student "offline notes" app is "No data collected." That's fine — just say so.

---

## Age Rating

Answer the short questionnaire (violence, adult content, gambling, etc.). Be honest. Most student apps end up **4+**.

---

## Pricing & Availability

- Free or pick a price tier.
- Pick countries to launch in (default: all).
- Schedule release: *Manual* is safest the first time — it lets you push the button after approval.

---

## Export Compliance

If your app uses HTTPS only (which is almost certain), you usually qualify for an exemption. Answer:

- Uses encryption? **Yes**
- Qualifies for exemption (standard HTTPS/TLS, no proprietary crypto)? **Yes**

Attach an encryption declaration if asked.

---

## Submit for Review

1. Pick a build from **TestFlight**.
2. Fill out **App Review Information** (contact email, phone, demo account credentials if your app requires login).
3. Add **Review Notes** explaining anything unusual ("The AR feature requires a device with LiDAR").
4. Click **Submit for Review**.

---

## Timeline

- **In Review** typically 24–48 hours.
- If approved → **Pending Developer Release** (you decide when to launch) or auto-release.
- If rejected → Apple tells you why; fix and resubmit.

---

## After Launch

- Monitor crash reports in **Xcode Organizer → Crashes.**
- Respond to user reviews.
- Plan your 1.0.1 based on real feedback.
- Never stop caring about the details — small polish beats big features.
