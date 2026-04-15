# Reading Error Messages

> Error messages are not punishment. They're the compiler's best attempt to help you.

Most beginners panic at red text. The trick is: **Swift errors follow predictable patterns.** Once you recognize them, you can fix them in seconds.

---

## The Two Kinds of Errors

| Kind | When It Happens | What You See |
|---|---|---|
| **Compile-time** | Before the app runs | Red dots in Xcode, build fails |
| **Runtime** | While the app is running | Crash, or wrong behavior |

Compile-time errors are your **friend** — the compiler caught the bug for free. Runtime crashes are harder because the program only broke because of specific data.

---

## Top 10 Swift Errors (and What They Actually Mean)

### 1. `Cannot find 'X' in scope`

**Meaning:** You're using a name the compiler has never seen.

**Causes:**
- Typo (`prinnt` instead of `print`).
- Forgot to `import` something (e.g., `import SwiftUI`).
- Variable declared inside a different function or `if` block.

---

### 2. `Value of type 'X' has no member 'Y'`

**Meaning:** You called `.y` on something that doesn't have a `y`.

```swift
let name = "Alice"
name.count       // ✅
name.length      // ❌ — String has 'count', not 'length'
```

**Fix:** Option-click the value to see its actual type and methods.

---

### 3. `Cannot convert value of type 'X' to expected argument type 'Y'`

**Meaning:** You're passing the wrong type.

```swift
let age: Int = "17"   // ❌
let age: Int = Int("17") ?? 0  // ✅
```

---

### 4. `Missing argument for parameter 'X'`

**Meaning:** The function expects more arguments than you gave it.

```swift
func greet(name: String, age: Int) { }
greet(name: "Bob")   // ❌ — missing 'age'
```

---

### 5. `Unexpectedly found nil while unwrapping an Optional value`

**Runtime crash.** You used `!` on something that turned out to be nil.

```swift
let user = users.first!   // crashes if users is empty
```

**Fix:** Use `if let`, `guard let`, or `??`:

```swift
if let user = users.first {
    print(user.name)
}
```

---

### 6. `Fatal error: Index out of range`

You asked for an element that doesn't exist.

```swift
let nums = [1, 2, 3]
nums[5]   // 💥
```

**Fix:** Check `indices.contains`, use `first`/`last`, or clamp.

---

### 7. `Escaping closure captures mutating 'self' parameter`

You're inside a `struct` and trying to modify `self` from inside an async closure. Use a `class` or a different architecture (e.g., move logic into a `@Observable`/`ObservableObject`).

---

### 8. `Type 'X' does not conform to protocol 'Y'`

**Meaning:** You said `struct Foo: Codable` but forgot a required property or method.

**Fix:** Xcode often offers a **Fix** button that auto-adds the required stubs.

---

### 9. `Expression was too complex to be solved in reasonable time`

SwiftUI's famous "confusing" error. Really means: the type-checker gave up.

**Fix:** Break a long chain into smaller `let` bindings:

```swift
// Instead of one giant expression:
let labelText = "Hello, \(user.firstName) \(user.lastName)!"
Text(labelText)
```

---

### 10. `Main actor-isolated` / concurrency warnings

Swift 6 is stricter about threads. Usually:
- Mark the calling function `@MainActor`, or
- Use `Task { @MainActor in ... }`.

---

## Reading a Stack Trace

When you crash, the debug console shows a **stack trace**:

```
Thread 1: Fatal error: Index out of range
0   libswiftCore.dylib
1   MyApp         ContentView.swift:42
2   MyApp         ContentView.swift:15
```

**Read bottom-up**, and look for the **first line from your own code** (`MyApp` here, not system frameworks). That line is where the bug lives: `ContentView.swift:42`.

---

## A Calming Workflow

When you see red:

1. **Read the full message.** Don't just scan the first line.
2. **Find the file and line number.** Click the error — Xcode jumps there.
3. **Look at the variable types nearby.** Option-click names to reveal types.
4. **Try one fix at a time.** Don't shotgun changes.
5. **Google the exact error.** Put it in quotes: `"Cannot convert value of type"`.

---

## Exercise

Deliberately break your code in 5 different ways, one at a time:

1. Misspell a variable.
2. Pass a `String` where `Int` is expected.
3. Force-unwrap an optional that's nil.
4. Access `array[100]` on a small array.
5. Omit a required argument.

Write down the exact error message you see each time. Next time you see it for real, you'll know exactly what to do.
