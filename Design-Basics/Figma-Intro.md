# Figma Intro

Figma is a free, browser-based design tool. It's the industry standard — almost every professional app starts in Figma before any code is written.

---

## Get Started (5 minutes)

1. Go to [figma.com](https://figma.com) and sign up (free).
2. Click **New design file**.
3. Press **F** to create a Frame. Pick **iPhone 15 Pro** from the side panel.
4. Press **R** for a rectangle, **T** for text, **O** for an ellipse.
5. Pan with spacebar + drag. Zoom with ⌘+/−.

That's 80% of what you need for the first week.

---

## The 10 Shortcuts to Memorize

| Shortcut | Action |
|---|---|
| V | Move tool |
| R | Rectangle |
| O | Ellipse |
| L | Line |
| T | Text |
| F | Frame (artboard) |
| ⌘D | Duplicate |
| ⌘G | Group |
| ⌘⌥G | Ungroup |
| ⇧A | Auto layout (Figma's magic) |

---

## Auto Layout (The Most Important Feature)

Auto Layout is Figma's version of SwiftUI's `HStack`/`VStack`. It makes your designs **responsive** — add text, the button grows; remove an item, everything reflows.

1. Select two or more layers.
2. Press **⇧A**.
3. The right panel shows direction, spacing, padding.

Use Auto Layout for **every** list, button, and card. Don't fight it.

---

## Frames vs Groups

- **Frame** = like a SwiftUI `View`. Can have its own background, padding, auto layout.
- **Group** = just a bundle of layers. No styling. Use only for temporary organization.

**Always prefer Frames.**

---

## Components

Reusable UI pieces. Like a SwiftUI `View`, but for your design.

1. Design a button once.
2. Right-click → **Create Component.** (Or ⌥⌘K.)
3. Drag it anywhere from the Assets panel.
4. Edit the main component → all copies update.

Perfect for buttons, cards, navigation bars.

---

## Plugins Worth Installing

| Plugin | What It Does |
|---|---|
| **Iconify** | 100,000+ free icons in every style |
| **Unsplash** | Drop in royalty-free photos |
| **Content Reel** | Realistic names, avatars, emails for mockups |
| **Remove BG** | One-click background removal |

---

## From Figma to Swift

You don't "export" Figma to SwiftUI — you use it as a blueprint:

1. Open the Figma frame on one monitor.
2. Write SwiftUI on the other.
3. For each element, copy the **exact** hex color, font size, corner radius, and spacing from the inspector panel.
4. Screenshot the design and `PhotoPicker` it into your simulator for pixel-comparison.

---

## Exercise

- [ ] Pick any screen from the app you're building right now.
- [ ] Recreate it in Figma.
- [ ] Now redesign it — better colors, better spacing, one additional detail.
- [ ] Update your SwiftUI code to match the new design.

You'll learn more about design in 30 minutes of doing this than in 3 hours of reading.
