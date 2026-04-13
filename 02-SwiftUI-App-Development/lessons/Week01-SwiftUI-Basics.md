# Week 1: Introduction to SwiftUI Basics

## Lesson Overview

This lesson introduces SwiftUI's declarative approach to building user interfaces. Students will learn the fundamental building blocks -- views, text, images, layout stacks, and modifiers -- and apply them by creating a profile card.

**Duration:** Two 50-minute sessions (or one 100-minute block)

---

## Learning Objectives

- Understand the difference between imperative (UIKit) and declarative (SwiftUI) UI.
- Create and customize `Text`, `Image`, and `Shape` views.
- Use `VStack`, `HStack`, and `ZStack` to arrange views.
- Apply modifiers to change fonts, colors, padding, corners, and shadows.
- Preview layouts in Xcode's canvas.

---

## Part 1: What Is SwiftUI?

SwiftUI is a **declarative** framework. Instead of writing step-by-step instructions ("create a label, set its text, set its font, add it to the view"), you **describe** what the UI should look like and let SwiftUI figure out how to render it.

### Your First View

Every SwiftUI screen starts with a struct that conforms to the `View` protocol:

```swift
struct HelloView: View {
    var body: some View {
        Text("Hello, SwiftUI!")
    }
}
```

> **Instructor Note:** Open Xcode, create a new SwiftUI project, and show the live preview updating in real time as you type.

---

## Part 2: Text and Modifiers

`Text` displays a string. You customize it by chaining **modifiers**:

```swift
Text("Welcome to GeekDocs")
    .font(.largeTitle)          // Sets the font size/style
    .fontWeight(.bold)          // Makes it bold
    .foregroundStyle(.blue)     // Sets the text color
    .padding()                  // Adds space around the text
```

### Common Text Modifiers

| Modifier | What It Does |
|----------|-------------|
| `.font(.title)` | Changes font size |
| `.fontWeight(.bold)` | Changes weight |
| `.foregroundStyle(.red)` | Changes color |
| `.italic()` | Italicizes text |
| `.underline()` | Adds underline |
| `.padding()` | Adds space around the view |
| `.background(.yellow)` | Adds background color |
| `.cornerRadius(8)` | Rounds corners of background |

> **Key concept:** Modifiers return a **new view**. Order matters! `.padding().background(.yellow)` looks different from `.background(.yellow).padding()`. Demonstrate both in class.

---

## Part 3: Images

SwiftUI can display images from your asset catalog or SF Symbols (Apple's built-in icon library):

```swift
// SF Symbol (built-in icon)
Image(systemName: "star.fill")
    .font(.system(size: 40))
    .foregroundStyle(.yellow)

// Asset catalog image
Image("student-photo")
    .resizable()                    // Allows the image to resize
    .scaledToFill()                 // Fills the frame, may crop
    .frame(width: 120, height: 120) // Sets exact size
    .clipShape(Circle())            // Clips to a circle
```

> **Class activity:** Have students open the SF Symbols app and find 5 icons they like. Display them in a row using `HStack`.

---

## Part 4: Layout Stacks

SwiftUI provides three stack types for arranging views:

### VStack -- Vertical Stack (top to bottom)

```swift
VStack {
    Text("Line 1")
    Text("Line 2")
    Text("Line 3")
}
```

### HStack -- Horizontal Stack (left to right)

```swift
HStack {
    Image(systemName: "person.fill")
    Text("Jane Doe")
}
```

### ZStack -- Depth Stack (back to front, layered)

```swift
ZStack {
    Color.blue                      // Background layer
    Text("On top!")                 // Foreground layer
        .foregroundStyle(.white)
}
```

### Stack Parameters

```swift
VStack(alignment: .leading, spacing: 12) {
    Text("Title")
        .font(.headline)
    Text("Subtitle")
        .font(.subheadline)
}
```

- `alignment` controls horizontal alignment within a VStack (`.leading`, `.center`, `.trailing`).
- `spacing` controls the gap between child views.

---

## Part 5: Combining Everything

Here is a small example that combines text, images, stacks, and modifiers:

```swift
struct GreetingCard: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "sun.max.fill")
                .font(.system(size: 60))
                .foregroundStyle(.orange)

            Text("Good Morning!")
                .font(.title)
                .fontWeight(.semibold)

            Text("It's going to be a great day.")
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .background(.yellow.opacity(0.2))
        .cornerRadius(16)
    }
}
```

---

## Exercise: Build a Profile Card

Create a `ProfileCardView` that displays:

1. A circular image placeholder (use an SF Symbol like `person.crop.circle.fill`).
2. A name in large, bold text.
3. A short bio in smaller, gray text.
4. A horizontal row of 3 "social" icons (use SF Symbols such as `envelope.fill`, `phone.fill`, `globe`).

### Requirements

- Use `VStack` for the overall layout.
- Use `HStack` for the icon row.
- Apply at least 5 different modifiers.
- Add a rounded-rectangle background with padding and a shadow.

### Starter Template

```swift
struct ProfileCardView: View {
    var body: some View {
        VStack(spacing: 12) {
            // TODO: Add circular image placeholder

            // TODO: Add name text

            // TODO: Add bio text

            // TODO: Add social icons row (HStack)
        }
        .padding()
        // TODO: Add background, corner radius, and shadow
    }
}
```

### Sample Solution

See [Demo01-ProfileCard.swift](../demos/Demo01-ProfileCard.swift) for a complete, commented solution.

---

## Vocabulary

| Term | Definition |
|------|-----------|
| **View** | A struct that describes part of the user interface |
| **Modifier** | A method that returns a new, customized version of a view |
| **VStack** | Arranges child views vertically |
| **HStack** | Arranges child views horizontally |
| **ZStack** | Layers child views on top of each other |
| **SF Symbols** | Apple's library of thousands of built-in icons |

---

## Homework

1. Customize your profile card with your own name and bio.
2. Experiment with at least 3 modifiers you did not use in class.
3. Create a second card layout of your own design (e.g., a recipe card, a game score card, or a book card).
