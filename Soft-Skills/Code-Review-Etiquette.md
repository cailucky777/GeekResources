# Code Review Etiquette

Code reviews are how teams learn together. Done well, they make everyone better; done badly, they're the most demoralizing part of a team.

---

## As the Author

### Before Opening a PR

- [ ] The code **compiles**.
- [ ] The tests **pass**.
- [ ] You've done a self-review (read your own diff).
- [ ] Commented tricky parts.
- [ ] No debug prints or commented-out code.
- [ ] The PR description explains **why**, not just **what**.

### Good PR Descriptions

```markdown
## What
Adds swipe-to-delete to the notes list.

## Why
Users complained there's no way to remove notes once created.

## How
Uses SwiftUI's `.swipeActions`. Delete is animated and undoable via a `Toast`.

## Screenshots
(GIF of swipe)

## Testing
- Tested on iPhone 15 simulator.
- Added two unit tests in `NotesStoreTests`.
```

### When You Receive Feedback

- **Assume good intent.** A short "fix this" is usually just efficient, not rude.
- **Don't argue for the sake of it.** If the reviewer has a point, concede gracefully.
- **Explain your reasoning** once, cordially, if you disagree. Then let it go.
- Say **thanks** at the end. Reviewing code is real work.

---

## As the Reviewer

### Read First, Comment Later

Scan the whole diff before commenting. Drive-by comments on line 10 often miss that line 80 already handles it.

### Separate Observations From Demands

Different kinds of comments deserve different tones:

| Prefix | Meaning |
|---|---|
| **`nit:`** | Small style preference, author may ignore |
| **`Q:`** | Genuine question, not a criticism |
| **`Consider:`** | Suggestion for thought |
| **`Blocking:`** | Must be addressed before merge |
| **`+1`** or **`✨`** | Praise. Use these too! |

### Be Specific and Actionable

- ❌ "This is confusing."
- ✅ "I had to read `calculateFee` three times to understand the 0.3 multiplier. Could we pull `basePercentage` into a named constant?"

### Praise the Good

Don't only comment on problems. If something is clever or clean, say so.

> "Nice — this refactor removed 40 lines. 👏"

### Don't Nitpick an Overhaul

If the PR is big and fundamentally good, don't drown it in 30 style comments. Focus on what matters; file the small stuff as follow-ups.

---

## Reviewing as a Student

You can and should review your classmates' code. Even at your skill level, asking questions teaches both of you:

- "Why did you pick a `List` here instead of `ScrollView`?"
- "What happens if `items` is empty?"
- "I don't understand `guard let self` — could you explain?"

A humble, curious reviewer beats a "senior"-sounding one every time.

---

## Red Flags to Watch For

- **Huge diffs** with unrelated changes mixed in.
- **"Fixed"** as the entire commit message.
- **Changes to unrelated files** "while I was there."
- **No tests** for new logic.
- **Commented-out code** with no explanation.

These aren't reasons to reject — they're reasons to ask before merging.

---

## The Golden Rule

Leave every codebase a little better than you found it. Leave every teammate a little smarter than they were.
