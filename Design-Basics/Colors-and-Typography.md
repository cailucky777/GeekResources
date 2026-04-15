# Colors and Typography

Two rules that cover 90% of beginner mistakes.

---

## Rule 1: Use Few Colors

Beginners put 8 colors on a screen. Pros use **3**.

A good palette:

- **1 neutral** (white / off-white / near-black for text)
- **1 primary** (brand color — one bold color your app is "about")
- **1 accent** (for highlights, warnings, or calls to action)

That's it. Gray and system colors don't count against this budget.

### Where to find palettes

- [coolors.co](https://coolors.co) — press spacebar, generate 5 colors, keep the ones you like.
- [paletton.com](https://paletton.com) — explore color theory (complementary, triadic).
- [Apple system colors](https://developer.apple.com/design/human-interface-guidelines/color) — already tuned for iOS. Just use `.accentColor`, `.red`, `.green`, etc., for dynamic dark-mode support.

### In SwiftUI

Prefer `Color("BrandPrimary")` (defined in Assets) over hex literals. Then you can tweak it once and it updates everywhere.

```swift
// Assets.xcassets → New Color Set → "BrandPrimary"
Text("Hello")
    .foregroundStyle(Color("BrandPrimary"))
```

Even better: support dark mode by setting different "Any Appearance" and "Dark" colors in the asset.

---

## Rule 2: Use Fewer Fonts

One font for most things. At most **two**: one for headlines, one for body.

For iOS projects, the safest bet is **San Francisco** (the system font). It's free, legible, perfectly kerned. In SwiftUI:

```swift
Text("Headline").font(.largeTitle.bold())
Text("Subtitle").font(.title3)
Text("Body").font(.body)
Text("Caption").font(.caption)
```

Use Apple's type scale. It's been tested on billions of screens.

### Size Hierarchy

Avoid five different font sizes. A solid hierarchy:

| Purpose | SwiftUI |
|---|---|
| Screen title | `.largeTitle` |
| Section title | `.title2` |
| Body text | `.body` |
| Meta / label | `.caption` |

### Weight

Weight communicates importance more than color or size.

- `.bold` or `.semibold` for things you want the eye to find.
- `.regular` for body text.
- Rarely use `.heavy` or `.black` — they shout.

### Third-Party Fonts

If you do use a custom font (e.g., for a game or themed app):

1. Drop the `.ttf` or `.otf` into Xcode.
2. Add to `Info.plist`:
   ```
   Fonts provided by application → item → YourFont.ttf
   ```
3. Use:
   ```swift
   Text("Hello").font(.custom("YourFont", size: 28))
   ```

Stick to 1 custom font. Two is the legal limit.

---

## Accessibility Checks

- Minimum text size: **11 pt**. Usually go bigger.
- Use **Dynamic Type** so users with vision needs can scale text:
  ```swift
  Text("Hi").font(.body)   // automatically respects user's preferred size
  ```
- Contrast: dark text on light background (or vice versa), **not gray on gray.**
- Test with iOS's **Accessibility Inspector** — catches contrast & label issues in seconds.

---

## Exercise

Open an app you built. Count the distinct colors and fonts (ignoring system defaults).

- If more than 3 colors → consolidate.
- If more than 2 fonts → pick one and stick with it.

Your app just got better by deletion.
