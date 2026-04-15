# Run Your App on a Real iPhone

The simulator is fine for most work, but some things only work on a real device:
camera, gyroscope, AR, push notifications, Bluetooth, accurate performance.

---

## Free Apple ID (No Paid Account)

You can sideload your own apps with a plain Apple ID.

### One-time setup

1. **Xcode → Settings → Accounts → +** → Apple ID. Sign in.
2. In your target's **Signing & Capabilities**:
   - **Team:** your personal team.
   - **Bundle Identifier:** make it unique (e.g., `com.yourname.app`).
   - **Automatically manage signing:** ✅

### Every time you want to run

1. Plug your iPhone in (or connect via Wi-Fi debugging).
2. Select it as the run destination.
3. `⌘R`.
4. First time only: the iPhone will say **"Untrusted Developer."** Go to **Settings → General → VPN & Device Management → Developer App → Trust.**

### Caveats

- App expires in **7 days** — rebuild from Xcode to re-sign.
- **3 apps max** on one device.
- **No push notifications, no CloudKit, no Sign in with Apple.**

---

## Apple Developer Program ($99/year)

What you get:
- Apps valid for a full year.
- TestFlight for up to 10,000 testers.
- App Store submission.
- Push notifications, CloudKit, iCloud, Family Sharing.

For classrooms, the **Apple Developer Program for Education** gets this free for qualifying institutions.

---

## Running Wirelessly

1. Plug iPhone in via USB.
2. **Window → Devices and Simulators → Devices → check "Connect via network."**
3. Unplug. Your device shows up as long as it's on the same Wi-Fi.

---

## Common First-Run Issues

| Symptom | Fix |
|---|---|
| "Could not launch app" | Trust the developer in Settings (see above) |
| "Provisioning profile doesn't match" | Turn off & back on "Automatically manage signing" |
| "No paired devices" | Unlock phone, tap "Trust this computer" |
| "Deployment target iOS X" | Lower deployment target in project settings to match phone's iOS version |
| Device greyed out | Phone needs unlocking, or iOS too old |

---

## Exercise

Put your current favorite project on your own phone today. Even if it's just `Hello, World!` — the confidence of seeing your own code on your own device is worth the setup time.
