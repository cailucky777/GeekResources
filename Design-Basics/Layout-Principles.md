# Layout Principles

A few rules that make any layout look intentional.

---

## 1. Alignment

Everything should line up with **something**. Left edges, centers, baselines — pick one and stick with it.

Bad:
```
Title
   Some subtitle text
      Button
```

Good:
```
Title
Some subtitle text
Button
```

In SwiftUI, `VStack(alignment: .leading)` is your friend.

---

## 2. Spacing

Use a **scale**, not random numbers.

A common one: `4, 8, 12, 16, 24, 32, 48`.

Every gap in your app should be one of those. No `.padding(.horizontal, 13)` — make it 12 or 16.

```swift
extension CGFloat {
    static let xs: CGFloat = 4
    static let s:  CGFloat = 8
    static let m:  CGFloat = 16
    static let l:  CGFloat = 24
    static let xl: CGFloat = 32
}
```

---

## 3. Hierarchy

Your eye should know where to look first.

Create hierarchy with:

- **Size** — bigger = more important.
- **Weight** — bold > regular.
- **Color contrast** — dark on light pops; gray fades back.
- **Space** — a thing with more whitespace around it feels important.

Apply **one or two** of these to each element. Not all four.

---

## 4. Density

Too tight → cluttered. Too loose → empty. The fix:

- Between **related** elements (label + its value): small spacing (8–12pt).
- Between **groups** of elements: big spacing (24–32pt).
- Section breaks: visible dividers or even more space.

---

## 5. The Grid

Align things to an invisible grid. In iOS, a good default:

- Horizontal padding: **16 pt** from screen edge.
- Vertical rhythm: multiples of 8.

SwiftUI handles much of this if you use `List`, `Form`, and `.padding()` consistently.

---

## 6. Touch Targets

Anything tappable should be **at least 44×44 pt.** Smaller = frustrating to tap.

Use `.frame(minWidth: 44, minHeight: 44)` or wrap icons in larger buttons.

---

## 7. Empty States

The empty screen is often the most-seen screen. Don't leave it blank.

```swift
if notes.isEmpty {
    ContentUnavailableView(
        "No Notes Yet",
        systemImage: "note.text",
        description: Text("Tap + to create your first note.")
    )
}
```

---

## 8. Loading, Error, Success

Design all three states, not just the success one:

| State | Show |
|---|---|
| Loading | `ProgressView` + what's loading ("Fetching recipes…") |
| Error | Friendly message + retry button |
| Empty | Helpful hint + primary action |
| Success | The normal view |

---

## Exercise

Open a screen you've built. For each element, ask:

1. Is it aligned to something?
2. Is its spacing on the scale?
3. Is there a clear "first thing my eye lands on?"
4. Does the empty state exist?

Fix the first thing that answers **no**.
