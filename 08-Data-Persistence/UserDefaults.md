# UserDefaults and @AppStorage

> The easiest place to save a small amount of data — think "sticky notes for your app."

`UserDefaults` is a key-value store built into iOS. It's perfect for things like:

- "Has the user seen the onboarding screen?"
- "What's the user's preferred theme?"
- "What was the last tab they opened?"

It is **not** for:

- Long lists of items → use SwiftData.
- Sensitive data (passwords, tokens) → use **Keychain**.
- Large files (images, JSON blobs over 1 MB) → use the file system.

---

## The Easy Way: `@AppStorage` in SwiftUI

`@AppStorage` is a property wrapper that reads and writes `UserDefaults` automatically.

```swift
import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("username")  private var username = ""

    var body: some View {
        Form {
            Toggle("Dark Mode", isOn: $isDarkMode)
            TextField("Name", text: $username)
        }
    }
}
```

When the user toggles the switch, the value is saved instantly — no code needed. Next launch, it reads back. That's it.

### Supported Types

`@AppStorage` supports: `Bool`, `Int`, `Double`, `String`, `URL`, `Data`, and `RawRepresentable` enums.

For **custom types**, encode to `Data` or use a separate persistence layer.

---

## The Raw Way: `UserDefaults.standard`

Outside SwiftUI, you can still use it directly:

```swift
UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
let seen = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
```

Every supported type has its own getter:

```swift
UserDefaults.standard.string(forKey: "username")        // String?
UserDefaults.standard.integer(forKey: "highScore")      // Int (0 if missing)
UserDefaults.standard.bool(forKey: "muted")             // Bool (false if missing)
UserDefaults.standard.array(forKey: "recentSearches")   // Any?
```

---

## Storing a Custom Type

Encode to JSON, store as `Data`, decode on load:

```swift
struct Settings: Codable {
    var theme: String
    var fontSize: Int
}

// Save
let s = Settings(theme: "dark", fontSize: 16)
if let data = try? JSONEncoder().encode(s) {
    UserDefaults.standard.set(data, forKey: "settings")
}

// Load
if let data = UserDefaults.standard.data(forKey: "settings"),
   let s = try? JSONDecoder().decode(Settings.self, from: data) {
    print(s.theme)
}
```

For SwiftUI, you can wrap this with `@AppStorage` using a custom `RawRepresentable`, but at that point prefer SwiftData.

---

## Enums with `@AppStorage`

```swift
enum Theme: String {
    case light, dark, system
}

struct ContentView: View {
    @AppStorage("theme") private var theme: Theme = .system

    var body: some View {
        Picker("Theme", selection: $theme) {
            Text("Light").tag(Theme.light)
            Text("Dark").tag(Theme.dark)
            Text("System").tag(Theme.system)
        }
    }
}
```

Enums must be `String` or `Int` raw values.

---

## Gotchas

1. **Don't use `UserDefaults` for large data.** It all loads into memory at launch. Anything over ~1 MB hurts your launch time.
2. **Keys are strings — typos silently fail.** Put them in an `enum`:
   ```swift
   enum Keys {
       static let darkMode = "isDarkMode"
       static let username = "username"
   }
   ```
3. **Resetting for testing:** delete the app from the simulator, or:
   ```swift
   UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
   ```

---

## Exercise

Build a **"Visit Counter"** app:

1. Show a number on screen ("You've opened this app 0 times").
2. Each launch, increment it using `@AppStorage`.
3. Add a **Reset** button.

Run it 5 times. The number should persist. Delete the app. It should reset.
