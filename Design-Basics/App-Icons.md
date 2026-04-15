# App Icons

Your icon is the first and most frequent impression of your app. Nail it.

---

## Design Principles

1. **One concept.** A single shape or letter. Not a whole scene.
2. **Readable at 60×60.** If it's noise at small sizes, simplify.
3. **Bold silhouette.** Your icon should be recognizable even in silhouette (black on white, one color).
4. **No text.** Except maybe a single letter. Never a word, never your app's name.
5. **Centered subject** with breathing room (Apple adds rounded corners — keep the important parts inside the safe zone).

---

## Technical Requirements

- Size: **1024 × 1024** pixels.
- Format: PNG (no transparency).
- Color space: sRGB or P3.
- **No alpha channel.** Save with a flat background color.
- **No Apple's rounded corners in your file** — iOS adds them automatically.

In Xcode: open `AppIcon` in the Assets catalog and drag your 1024×1024 into the single "All Sizes" slot.

---

## Quick Icon Workflow

Don't have an artist? No problem.

### Option A: Figma

1. Create a **1024×1024 frame.**
2. Background: a solid color or a 2-color gradient.
3. Center: one bold shape, letter, or SF Symbol scaled up.
4. Export → PNG → 1x.

### Option B: Bakery / Icon Composer / Icon Pro apps

Dedicated icon-making apps do the boilerplate for you. Search the Mac App Store for "icon maker."

### Option C: SF Symbols as a Base

1. In Figma, install the **SF Symbols** plugin or export from Apple's SF Symbols app.
2. Put it on a gradient background.
3. Done.

---

## Icons That Look "Homemade" (Avoid These)

- Drop shadows on flat icons.
- Multiple clashing gradients.
- Outline + fill + glow + emoji all at once.
- Emoji as your icon (yes, really, some people do this).
- 3D render that's too busy to read at 60×60.

---

## Icons That Look Pro

- Single letter on a gradient (Revolut, Notion).
- One mascot shape (Duolingo, Slack's old logo).
- Abstract geometric mark (Linear, Arc Browser).
- Flat illustration with 3–4 colors max (Bear, Airbnb).

Study icons on your home screen. What makes them readable?

---

## Dark Mode & Tinted Icons (iOS 18+)

iOS 18 added **Dark** and **Tinted** variants of the app icon. Xcode's AppIcon asset now has three slots.

- **Dark** — design for a dark background.
- **Tinted** — provide a grayscale version; iOS colorizes it.

Not required, but adds polish.

---

## Exercise

- [ ] Design three icon directions for your project in Figma.
- [ ] Print them at postage-stamp size and look from 3 feet away.
- [ ] Pick the one that reads best.
- [ ] Drop it into Xcode and install on your device.
- [ ] Live with it for 2 days. If it still looks good, ship it.
