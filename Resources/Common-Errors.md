# Common Errors (and Quick Fixes)

A searchable collection of the most frequent errors students hit, with copy-pasteable fixes.

> Tip: use ⌘F / Ctrl+F to jump to the exact error message.

---

## Swift / Xcode

### `Cannot find 'X' in scope`

You used a name the compiler doesn't know.

- Did you misspell it? (Most common.)
- Did you forget an `import`? E.g., `import SwiftUI`, `import Foundation`.
- Is it in a different file with a `private` access level?

---

### `Value of type 'X' has no member 'Y'`

You called `.y` on a thing that doesn't have `y`.

- Option-click the value to see its real type.
- Check for typos: `count` vs `length`, `forEach` vs `each`.

---

### `Cannot convert value of type 'X' to expected argument type 'Y'`

Wrong type. Typical cases:

- `Int` ↔ `Double`: use `Double(x)`.
- `String` ↔ `Int`: use `Int("42")` (optional) or `"\(n)"`.
- `Binding<Bool>` ↔ `Bool`: pass `$isOn`, not `isOn`.

---

### `Unexpectedly found nil while unwrapping an Optional value`

Runtime crash on `!` or implicit unwrap.

```swift
// ❌
let email = user.email!

// ✅
guard let email = user.email else { return }
// or
let email = user.email ?? ""
```

---

### `Fatal error: Index out of range`

```swift
nums[100]   // boom if nums.count < 101
```

Use `nums.indices.contains(100)`, `first`, `last`, or clamp the index.

---

### `Expression was too complex to be solved in reasonable time`

SwiftUI's classic. Break long chains into named pieces:

```swift
// Instead of one gigantic expression:
let total = (cart.subtotal + cart.tax + cart.tip - cart.discount)
Text("Total: $\(total, specifier: "%.2f")")
```

---

### `Use of unresolved identifier`

Same family as "cannot find in scope." Check imports, typos, and access control.

---

### `Type 'X' does not conform to protocol 'Y'`

Xcode usually offers a **Fix** button that auto-inserts the missing stubs. If not, check which requirements you're missing in the protocol declaration.

---

### `Main actor-isolated property 'X' can not be referenced from a non-isolated context`

Swift 6 concurrency. Usually:

- Annotate the calling function with `@MainActor`, or
- Wrap the call in `Task { @MainActor in ... }`.

---

### `Argument passed to call that takes no arguments`

You declared a function with no parameters but called it with one. Check the signature.

---

### `Initializer 'init(_:)' requires that 'X' conform to 'StringProtocol'`

You're passing a non-string into a `String(...)` init that expects one. Use string interpolation:

```swift
let s = "\(number)"   // ✅
```

---

## Xcode Build Errors

### `Command CompileSwift failed with a nonzero exit code`

A big-sounding error, usually caused by a smaller error **elsewhere in the file or target**. Scroll the Issue Navigator (⌘5) for the real error in red.

---

### `Build input file cannot be found`

A file in the project references a file that no longer exists.

- In the Project Navigator, find the file shown in **red**.
- Remove the reference (don't delete your actual file).

---

### `No such module 'X'`

- You forgot to add the Swift Package / framework to the target.
- Or: Clean build folder (`⇧⌘K`) and try again.

---

### App runs but UI won't update

99% of the time: your state isn't observable.

- Use `@State` / `@Binding` / `@Observable` / `@ObservedObject` / `@Published`.
- Mutating a plain `var` inside a view won't trigger a re-render.

---

### Preview crashes but the simulator runs fine

- Add a `#Preview` with minimal sample data (not your real `ContentView`).
- Check that all `@State` defaults are valid.
- Restart the preview (`⌥⌘P`).

---

### Keyboard covers text field

Use the built-in:

```swift
.scrollDismissesKeyboard(.interactively)
// or a Form, or .safeAreaInset(edge: .bottom)
```

---

## Git

### `fatal: not a git repository`

You're in a folder that isn't a git repo. Either `cd` into one or run `git init`.

---

### `Your branch is up to date with 'origin/main'` yet changes exist

Those are unstaged changes. Run `git status` to see, `git add` + `git commit` to save.

---

### `Updates were rejected because the remote contains work that you do not have locally`

Someone pushed changes to the branch after you last pulled.

```bash
git pull --rebase
git push
```

---

### `Merge conflict in file.swift`

Open the file — you'll see `<<<<<<<`, `=======`, `>>>>>>>` markers. Edit to keep what you want, remove the markers, then:

```bash
git add file.swift
git rebase --continue     # or: git commit
```

---

### I committed something I shouldn't have

If you haven't pushed yet:

```bash
git reset --soft HEAD~1   # undo commit, keep changes staged
# fix, then re-commit
```

If you've pushed (and it's a secret like an API key):

1. Revoke the key immediately.
2. Don't rely on `git push --force` to hide it — it's already scraped.

---

## Networking

### App requests fail on device but work in simulator

- Check `NSAppTransportSecurity` in Info.plist (no `http://` URLs without exception).
- Phone might not be on the same Wi-Fi as your server.
- Check server logs for the request — is it arriving?

---

### `The resource could not be loaded because the App Transport Security policy requires the use of a secure connection`

You're calling `http://` (not `https://`). Either use HTTPS or add a local-network exception (see `../Web-and-Python/A-Tiny-Backend.md`).

---

### JSON decode fails with a weird `keyNotFound` error

The server's JSON has a different shape than your struct.

- Print the raw `String(data: data, encoding: .utf8)` to see what came back.
- Match your struct to the JSON exactly (or use `CodingKeys`).

---

## Simulator

### App runs but I can't type in a text field

Menu → **I/O → Keyboard → Connect Hardware Keyboard** → toggle off. Now the on-screen keyboard shows up.

---

### App launches but the screen is blank

- Preview a different device size.
- Check your `@main` struct returns the right root view.
- Look for a crash in the Console — silent crashes happen.

---

## When You're Really Stuck

1. Copy the full error message.
2. Make a minimal reproduction (see `../07-Debugging-and-Testing/Bug-Hunting-Strategies.md`).
3. Ask Claude or ChatGPT — paste error + reproduction + what you expected.
4. Ask on Stack Overflow if AI doesn't help — see `../Soft-Skills/How-to-Ask-Questions.md`.
