# WatchOS and visionOS Intro

Once you know SwiftUI, you can build for the Apple Watch and the Vision Pro with a fraction of the effort it took on iPhone. Most of the concepts carry over.

---

## watchOS

### Add a Watch Target to an Existing App

1. **File → New → Target... → Watch App.**
2. Choose **Embed in existing app?** for a companion watchOS app, or **Stand-alone** for an app that doesn't need the phone.
3. Xcode creates a `MyApp Watch App/` folder with its own `ContentView`.

### What's Different from iOS

- **Tiny screen.** Few words, big buttons. `NavigationSplitView` doesn't exist; use `NavigationStack` with short titles.
- **Digital Crown.** `.digitalCrownRotation(...)` for custom scrollable controls.
- **Complications.** Tiny glanceable views on the watch face. Use the `Widget` framework + `WKRelevantShortcut`.
- **Energy-constrained.** Don't poll the network every second. Use `URLSession.backgroundConfiguration` and workout sessions for long-running tasks.

### A Minimal Watch View

```swift
struct WatchHomeView: View {
    @State private var count = 0
    var body: some View {
        VStack(spacing: 8) {
            Text("\(count)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .focusable()
                .digitalCrownRotation($count.asDouble, from: 0, through: 100, sensitivity: .medium)
            Button("Reset") { count = 0 }
        }
    }
}
```

### When to Build a Watch App

- Your iOS app has a use case that's glanceable (timers, lists, quick logs).
- Avoid if you really need complex interaction or media.

---

## visionOS

The Vision Pro runs **visionOS**, Apple's spatial OS. SwiftUI works, plus new APIs for 3D content.

### Adding visionOS Support

Already using SwiftUI? Often you can just check **Vision** as a destination in your target. Many iPad/SwiftUI apps "just work" in a window on visionOS.

To go beyond a floating window:

### New APIs

- **`ImmersiveSpace`** — fill the room with content.
- **`RealityView`** — place 3D objects in space (uses RealityKit).
- **Ornaments** — UI attached to windows in space.
- **Hover effects** — visuals that respond to where the user is looking.

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup { ContentView() }

        ImmersiveSpace(id: "galaxy") {
            RealityView { content in
                let earth = try! await Entity(named: "Earth")
                content.add(earth)
            }
        }
    }
}
```

Then from a view:

```swift
@Environment(\.openImmersiveSpace) private var openImmersiveSpace

Button("Enter Space") {
    Task { await openImmersiveSpace(id: "galaxy") }
}
```

### Testing Without a Headset

Xcode's visionOS simulator is capable — you navigate by trackpad + keyboard. It's enough to prototype.

---

## Cross-Platform Considerations

If your SwiftUI app targets iOS + watchOS + visionOS:

- Use `#if os(iOS)` / `#if os(watchOS)` / `#if os(visionOS)` only for platform-specific differences.
- Keep business logic in a shared module.
- Design the UI **tablet-first**, then condense for watch and expand for vision.

---

## Project Ideas

- Timer app for all three platforms with shared state via CloudKit.
- A flashcard app where watch shows the next card and Vision shows 3D models.
- A daily-mood tracker that lives natively on the watch with a phone companion.

---

## Further Reading

- [developer.apple.com/watchos](https://developer.apple.com/watchos/)
- [developer.apple.com/visionos](https://developer.apple.com/visionos/)
- Apple's WWDC videos tagged *visionOS* and *watchOS*.
