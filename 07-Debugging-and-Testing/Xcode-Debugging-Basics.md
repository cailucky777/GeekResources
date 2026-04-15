# Xcode Debugging Basics

> "The debugger is not a last resort — it's a superpower you use every day."

When your app crashes, freezes, or just behaves weirdly, `print()` will only get you so far. Xcode's debugger lets you pause your program in time and look around.

---

## 1. Breakpoints

A **breakpoint** tells Xcode: "Stop the program right here so I can inspect it."

### How to Set One

Click the line number in the gutter next to any line of code. A blue arrow appears. That's it.

```swift
func calculateScore(answers: [Bool]) -> Int {
    var score = 0
    for answer in answers {    // ← click here to set a breakpoint
        if answer { score += 10 }
    }
    return score
}
```

When the program runs and reaches this line, it **pauses** before executing.

### Disable vs. Remove

- **Click the breakpoint once** → it turns pale (disabled, but still there).
- **Drag it out of the gutter** → removed.
- **Right-click → Delete Breakpoint** → removed.

---

## 2. The Debug Bar

Once paused, the bottom of Xcode shows controls:

| Button | Shortcut | What It Does |
|---|---|---|
| ▶️ Continue | `⌃⌘Y` | Keep running until the next breakpoint |
| ↷ Step Over | `F6` | Run this line, then pause on the next |
| ↓ Step Into | `F7` | If this line calls a function, go inside it |
| ↑ Step Out | `F8` | Finish the current function and pause when it returns |

**Rule of thumb:** Use **Step Over** 90% of the time. Use **Step Into** when you want to see what's happening inside a function you wrote.

---

## 3. The Variables View

The left panel at the bottom shows every variable in scope, with its current value.

- Expand structs/classes with the triangle.
- Right-click a variable → **Print Description** to see a full dump.
- Hover over a variable in your code to see its value inline.

---

## 4. The LLDB Console

The right panel is a real Swift REPL while paused.

```
(lldb) po score
10

(lldb) po answers.count
5

(lldb) po answers.filter { $0 }.count
3
```

`po` means "print object." You can run any Swift expression against your paused program.

---

## 5. Useful Print Techniques

When breakpoints feel like too much, these are quick wins:

```swift
print("🔴 reached checkout button")           // emoji = easy to find in the log
print("user = \(user)")                        // interpolate variables
print("items = \(items.count)")
debugPrint(user)                              // more detail than print
dump(user)                                    // pretty-prints nested structs
```

### Tip: use `#function` and `#line`

```swift
print("\(#function):\(#line) — value is \(value)")
// Output: calculateScore(answers:):34 — value is 42
```

---

## 6. Breakpoint Actions (No Code Changes!)

Right-click a breakpoint → **Edit Breakpoint...** to add:

- **Condition:** `score > 100` — only break when this is true.
- **Action → Log Message:** `score is @score@` — print without stopping.
- **Automatically continue:** turn a breakpoint into a logger without editing your code.

This is huge for hunting bugs that only appear in a loop's 500th iteration.

---

## 7. Exception Breakpoint

**Set this once in every project and leave it on.**

- Open the Breakpoint Navigator (`⌘8`).
- Click `+` at the bottom → **Exception Breakpoint**.

Now when your app crashes, Xcode pauses on the line that actually caused it — not 20 layers deep in system code.

---

## Exercises

1. Open any SwiftUI project. Set a breakpoint inside a button's action closure. Tap the button in the simulator and inspect the state variables.
2. Write a function that crashes (e.g., `array[100]` on a 3-element array). Add the Exception Breakpoint and find the crashing line.
3. Use a breakpoint action to log `self.count` every time a method runs, without changing your code.

---

## Next

- [Reading-Error-Messages.md](./Reading-Error-Messages.md)
- [Unit-Testing-Intro.md](./Unit-Testing-Intro.md)
