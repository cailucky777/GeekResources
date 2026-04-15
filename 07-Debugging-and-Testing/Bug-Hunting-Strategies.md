# Bug Hunting Strategies

> Debugging is detective work. The evidence is in the code.

When something's broken and you don't know why, you don't need to be smarter — you need to be systematic.

---

## 1. Reproduce the Bug Reliably

If you can't reproduce it, you can't fix it. Write down exactly:

- What did you do?
- What did you expect?
- What actually happened?

If it only happens "sometimes," find the pattern first.

---

## 2. Form a Hypothesis

Don't just change code randomly. Ask: **"What would cause this?"** Make a small list:

> The button doesn't respond when tapped. Possible causes:
> 1. The button's `action` closure isn't wired up.
> 2. Something on top of it is intercepting taps.
> 3. The button is disabled.
> 4. `isLoading` is stuck on `true`.

Then check each one, cheapest first.

---

## 3. Binary Search Your Code

Bug appeared somewhere in 200 lines of code? Comment out half. Does the bug still happen?
- **Yes** → it's in the remaining half.
- **No** → it's in the half you commented out.

Repeat. You'll find the culprit in log₂(200) ≈ 8 steps.

---

## 4. Binary Search Your Git History

Bug worked yesterday, broken today? Use **`git bisect`**:

```bash
git bisect start
git bisect bad                 # current commit is broken
git bisect good abc123         # this old commit worked
# git checks out a commit in the middle
# test the app, then:
git bisect good   # or: git bisect bad
# repeat until git tells you the exact breaking commit
git bisect reset
```

In ~10 steps you'll find the single commit that introduced the bug.

---

## 5. Make a Minimal Reproduction

A "minimal repro" is the smallest piece of code that still shows the bug. Strip everything unrelated.

When you've made a 20-line repro, often **the bug becomes obvious in the process.** And if it isn't, now you have something clean to post on Stack Overflow.

---

## 6. Rubber Duck Debugging

Explain the code, line by line, out loud, to an inanimate object (a rubber duck works, so does your cat).

> "So this function takes a list of users, then filters where `isActive`, then — wait. Why am I filtering after I already filtered in the caller? That's the bug."

Half the time you'll solve it before finishing the explanation. Your brain just needed to slow down.

---

## 7. Check Your Assumptions

Bugs live where your assumptions are wrong. Common ones:

- "This value is never nil." → It is.
- "This runs on the main thread." → It doesn't.
- "This array is always sorted." → It isn't.
- "This API always returns a 200." → It doesn't.

Add a `print` or `assert` right at the assumption and verify.

---

## 8. Read the Code Backwards

Don't trace from the beginning — start from where the bug shows up and work backwards to find the bad input.

---

## 9. When Nothing Works

- **Sleep on it.** Seriously. Bugs solve themselves overnight surprisingly often.
- **Explain it in writing.** Open a GitHub issue on your own repo and describe the bug as if to a stranger.
- **Ask for help** — see [../Soft-Skills/How-to-Ask-Questions.md](../Soft-Skills/How-to-Ask-Questions.md) so you get a useful answer.

---

## Common Bug Categories

| Category | Example | Typical Fix |
|---|---|---|
| **Off-by-one** | Loop runs one too many times | Check `<` vs `<=`, indices start at 0 |
| **Nil / optional** | Crash on unwrap | Use `if let` / `guard let` / `??` |
| **State sync** | UI doesn't update | Make sure state is `@State` / `@Published` / `@Observable` |
| **Race condition** | Works sometimes, fails sometimes | Actors, `@MainActor`, or serial queues |
| **Wrong type** | Subtle math bugs | Check `Int` vs `Double`, widen appropriately |
| **Caching** | Changes don't appear | Clean build: `⇧⌘K`, delete derived data |

---

## Exercise

Next time a bug takes you more than 10 minutes to solve, write down:

1. What the symptom was.
2. What you thought the cause was.
3. What the cause actually was.
4. How you could have found it faster.

After 10 bugs you'll see a pattern in your own thinking — and debug twice as fast.
