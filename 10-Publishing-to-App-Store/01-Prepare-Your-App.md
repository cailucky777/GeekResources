# Prepare Your App

Before any App Store submission, your project needs a real identity.

---

## 1. Pick a Bundle Identifier

A **Bundle ID** uniquely names your app to Apple. Format: reverse domain.

```
com.yourname.appname
com.jessieliu.flashcards
```

Change it in **Xcode → Target → Signing & Capabilities → Bundle Identifier**.

**Rules:**
- Must be globally unique.
- Cannot be changed once the app is on the App Store.
- Use something you control (even a personal domain or your name).

---

## 2. App Name and Display Name

- **Product Name** (in Build Settings) → the internal name.
- **Display Name** (in Info.plist or target settings → "Display Name") → what users see on the Home Screen.

If your app is "Flashcards by Jessie" on the App Store but you want "Flashcards" under the icon, set the display name separately.

---

## 3. App Icon

Every shipped app needs a full icon set.

1. In the Assets catalog, click **AppIcon**.
2. Drag a 1024×1024 PNG into the single-size slot (Xcode will generate the rest).
3. No transparency. No rounded corners — Apple adds them.
4. Export from Figma at 1024×1024 at 1x.

See [../Design-Basics/App-Icons.md](../Design-Basics/App-Icons.md) for design tips.

---

## 4. Launch Screen

Open **LaunchScreen** in the Xcode project. This is the first thing users see while your app boots. Keep it:

- **Static** (no animation — it's shown for a fraction of a second).
- **Simple** (logo on a background is fine).
- **Fast** — no network, no images over 500 KB.

---

## 5. Version and Build Numbers

| Field | Example | Meaning |
|---|---|---|
| **Version** | `1.0.0` | What users see. Bump for every release. |
| **Build** | `1`, `2`, `3`, ... | Internal counter. Bump for every upload to App Store Connect. |

Rules:

- Version must be `x.y.z` with no leading zeros.
- Build must be higher than any previous build **you've ever uploaded**.

---

## 6. Permissions (Info.plist Usage Strings)

If your app uses the camera, microphone, photos, location, notifications, etc., iOS requires a **usage description** — otherwise the app **crashes** the first time you try.

Open `Info.plist` and add (e.g.):

```
NSCameraUsageDescription
  → "We need the camera so you can take AR selfies."
NSPhotoLibraryUsageDescription
  → "Pick a photo to use as your profile picture."
```

Be honest and specific. Apple reads these during review.

---

## 7. Supported Devices & Orientations

In your target's **General** tab:

- **Deployment Info** → iPhone / iPad / Mac Catalyst, minimum iOS version.
- **Device Orientation** → uncheck ones your app doesn't support (e.g., disable landscape if it would look broken).

---

## Pre-Flight Checklist

Before moving on to TestFlight:

- [ ] Unique Bundle ID
- [ ] Proper app name + display name
- [ ] 1024×1024 icon in Assets
- [ ] Launch screen works on every device size
- [ ] Version = `1.0.0`, Build = `1`
- [ ] All permissions have usage strings
- [ ] `Release` build configuration runs without crashes
- [ ] No hardcoded API keys or secrets
