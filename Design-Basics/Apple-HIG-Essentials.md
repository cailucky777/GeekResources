# Apple HIG Essentials

Apple's **Human Interface Guidelines** (HIG) are a 1000-page book. You don't need to read it all. Here's the subset every student iOS developer should know.

> Full reference: [developer.apple.com/design/human-interface-guidelines](https://developer.apple.com/design/human-interface-guidelines)

---

## 1. Respect the Platform

An iOS app should feel like an iOS app. That means:

- Use system fonts (San Francisco) unless you have a strong reason not to.
- Use **SF Symbols** for icons — they're free, consistent, and scale perfectly.
  ```swift
  Image(systemName: "heart.fill")
  ```
- Use standard navigation patterns — `NavigationStack`, `TabView`, `.sheet`, etc.

---

## 2. Controls Should Look Tappable

- Buttons should look like buttons (filled, bordered, or text with an obvious affordance).
- Plain text that does something on tap is often missed.
- Use `.buttonStyle(.borderedProminent)` for primary actions.

---

## 3. Follow the Navigation Patterns

| Pattern | Use For |
|---|---|
| **Tab bar** | 2–5 top-level sections that are equally important |
| **Navigation stack** | Drilling into details |
| **Sheet (modal)** | Self-contained task ("Compose message", "Add item") |
| **Full-screen cover** | Onboarding, media-heavy experiences |

Don't use a sheet to replace navigation, or vice versa.

---

## 4. Haptics Matter

Subtle haptics make an app feel alive.

```swift
import UIKit

let haptic = UIImpactFeedbackGenerator(style: .light)
haptic.impactOccurred()
```

Or better: `.sensoryFeedback(.success, trigger: someValue)` in SwiftUI.

Use sparingly. Haptics on every tap are annoying.

---

## 5. Motion and Animation

- Animate state changes, not decorations.
- Default to `.easeInOut`, not `.linear`.
- Duration: 0.2–0.35s for most UI transitions.

```swift
.animation(.easeInOut(duration: 0.25), value: isExpanded)
```

---

## 6. Handle Dark Mode

Use **system colors** or define both light and dark variants in Assets.

```swift
// Good — system-adaptive
.background(Color(.systemBackground))
.foregroundStyle(.primary)

// Avoid hardcoding
.background(.white)
```

Test your app in both modes — **`⌘+Shift+A`** in the simulator toggles appearance.

---

## 7. Support Dynamic Type

Text that doesn't scale with the user's preferred size is an accessibility fail.

```swift
Text("Hello").font(.body)   // ✅ scales
Text("Hello").font(.system(size: 17))   // ⚠️ fixed size
```

---

## 8. Don't Fight iOS

- Don't hide the status bar without reason.
- Don't disable the swipe-back gesture.
- Don't build your own keyboard, scroll behavior, or navigation bar.
- Your custom version will always be worse than the system's.

---

## 9. Safe Areas

Use `.safeAreaInset`, `.safeAreaPadding`, or rely on default container behavior. Don't put interactive content under the Dynamic Island, home indicator, or keyboard.

---

## 10. Accessibility

Every UI element that does something should have a label.

```swift
Button { delete() } label: { Image(systemName: "trash") }
    .accessibilityLabel("Delete item")
```

Turn on VoiceOver (Settings → Accessibility → VoiceOver) and use your app eyes-closed. Can you still navigate? Can you still complete the primary task? If not, fix it.

---

## Further Reading

- [HIG: Foundations](https://developer.apple.com/design/human-interface-guidelines/foundations) — motion, color, typography
- [HIG: Patterns](https://developer.apple.com/design/human-interface-guidelines/patterns) — onboarding, launching, settings
- [SF Symbols app](https://developer.apple.com/sf-symbols/) — the icon library
