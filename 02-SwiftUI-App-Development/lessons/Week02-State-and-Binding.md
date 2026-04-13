# Week 2: State and Binding

## Lesson Overview

This lesson introduces **state management** in SwiftUI. Students will learn how `@State` makes views reactive, how `@Binding` shares state between views, and how user interactions (buttons, text fields) trigger UI updates. By the end, they will build a counter app and a simple form.

**Duration:** Two 50-minute sessions (or one 100-minute block)

---

## Learning Objectives

- Explain why SwiftUI views need `@State` to hold mutable data.
- Use `@State` to store and update values within a view.
- Use `@Binding` to pass mutable state from a parent to a child view.
- Handle user interactions with `Button` and `TextField`.
- Build a counter app and a simple input form.

---

## Part 1: The Problem -- Views Are Structs

SwiftUI views are **structs**, and structs are value types. That means their properties are immutable by default. Try this and notice the error:

```swift
struct CounterView: View {
    var count = 0 // This will NOT work for mutation

    var body: some View {
        VStack {
            Text("Count: \(count)")
            Button("Add 1") {
                count += 1 // ERROR: Cannot assign to property
            }
        }
    }
}
```

SwiftUI solves this with the `@State` property wrapper.

---

## Part 2: @State

`@State` tells SwiftUI: "This property can change, and when it does, redraw the view."

```swift
struct CounterView: View {
    @State private var count = 0  // Now SwiftUI manages this value

    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(count)")
                .font(.largeTitle)

            Button("Add 1") {
                count += 1  // This works now!
            }
            .font(.title2)
            .buttonStyle(.borderedProminent)
        }
    }
}
```

### Key Rules for @State

1. Always mark `@State` properties as `private` -- they belong to this view only.
2. Give them a default value.
3. SwiftUI **automatically re-renders** the view whenever a `@State` value changes.

> **Instructor Note:** Demonstrate the counter live. Show students how the entire `body` is re-evaluated each time `count` changes, but SwiftUI is efficient and only redraws what actually changed.

---

## Part 3: Buttons

`Button` takes a label and an action closure:

```swift
// Simple text button
Button("Tap Me") {
    print("Button tapped!")
}

// Custom-styled button
Button(action: {
    count += 1
}) {
    HStack {
        Image(systemName: "plus.circle.fill")
        Text("Increment")
    }
    .padding()
    .background(.blue)
    .foregroundStyle(.white)
    .cornerRadius(10)
}
```

### Button Styles

```swift
Button("Bordered") { }
    .buttonStyle(.bordered)

Button("Prominent") { }
    .buttonStyle(.borderedProminent)

Button("Delete", role: .destructive) { }
    .buttonStyle(.borderedProminent)
```

---

## Part 4: TextField

`TextField` lets users type text. It requires a **binding** to a `@State` string:

```swift
struct GreetingView: View {
    @State private var name = ""

    var body: some View {
        VStack(spacing: 16) {
            TextField("Enter your name", text: $name)  // Note the $ prefix
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Text("Hello, \(name.isEmpty ? "stranger" : name)!")
                .font(.title)
        }
    }
}
```

### The $ Prefix

- `name` gives you the **current value** (a `String`).
- `$name` gives you a **binding** -- a two-way connection so the text field can both read and write the value.

> **Class activity:** Have students build a view with a TextField and a Text that mirrors what they type in real time.

---

## Part 5: @Binding

When a **child view** needs to read and modify a **parent's** state, use `@Binding`:

```swift
// Parent view owns the state
struct ParentView: View {
    @State private var isOn = false

    var body: some View {
        VStack {
            Text(isOn ? "ON" : "OFF")
                .font(.largeTitle)

            ToggleButton(isOn: $isOn)  // Pass a binding with $
        }
    }
}

// Child view receives a binding
struct ToggleButton: View {
    @Binding var isOn: Bool  // No default value -- parent provides it

    var body: some View {
        Button(isOn ? "Turn Off" : "Turn On") {
            isOn.toggle()  // Modifies the parent's state
        }
        .buttonStyle(.borderedProminent)
    }
}
```

### @State vs @Binding

| | @State | @Binding |
|---|--------|---------|
| Who owns the data? | This view | Another view (parent) |
| Default value? | Yes | No (provided by parent) |
| Prefix to pass down? | `$property` | Already a binding |
| Use `private`? | Yes | No |

---

## Exercise 1: Enhanced Counter App

Build a counter app with these features:

1. A display showing the current count.
2. A "+" button and a "-" button.
3. A "Reset" button that sets the count back to 0.
4. The count text changes color: green for positive, red for negative, black for zero.

### Starter Template

```swift
struct EnhancedCounterView: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 24) {
            Text("\(count)")
                .font(.system(size: 72, weight: .bold))
                // TODO: Change color based on count value

            HStack(spacing: 20) {
                // TODO: Minus button

                // TODO: Reset button

                // TODO: Plus button
            }
        }
    }
}
```

**Hint:** Use a computed property or a ternary expression to pick the color:

```swift
.foregroundStyle(count > 0 ? .green : count < 0 ? .red : .primary)
```

---

## Exercise 2: Simple Sign-Up Form

Build a form with:

1. `TextField` for name.
2. `TextField` for email.
3. `SecureField` for password (like TextField but hides input).
4. A "Sign Up" `Button` that is **disabled** unless all three fields are filled in.
5. When tapped, show a greeting: "Welcome, [name]!"

### Starter Template

```swift
struct SignUpFormView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedUp = false

    var body: some View {
        VStack(spacing: 16) {
            // TODO: Name TextField
            // TODO: Email TextField
            // TODO: Password SecureField

            // TODO: Sign Up Button (disabled if fields are empty)

            // TODO: Show welcome message if signed up
        }
        .padding()
    }
}
```

**Hint:** Disable a button with:

```swift
.disabled(name.isEmpty || email.isEmpty || password.isEmpty)
```

---

## Vocabulary

| Term | Definition |
|------|-----------|
| **@State** | A property wrapper that stores mutable state within a view |
| **@Binding** | A property wrapper that creates a two-way connection to state owned by another view |
| **Binding ($)** | The `$` prefix creates a binding reference to a @State property |
| **Button** | A view that performs an action when tapped |
| **TextField** | A view that accepts text input from the user |
| **SecureField** | Like TextField but hides the typed characters |

---

## Homework

1. Add a **stepper** feature to the counter: let the user choose the increment amount (1, 5, or 10) using a `Picker` or segmented control.
2. Extend the sign-up form with a "confirm password" field that checks if both passwords match before enabling the button.
3. Extract the sign-up button into its own child view using `@Binding`.
