# How to Ask Questions (and Get Great Answers)

> The quality of help you receive is proportional to the quality of the question you ask.

This is an actual technical skill. Mastering it will save you thousands of hours over your career.

---

## Before You Ask Anyone

Check these in order:

1. **Re-read the error message.** Really read it.
2. **Google the exact error message in quotes.**
3. **Search the docs.**
4. **Try to explain the problem to yourself in writing.** (Often enough.)
5. **Make a minimal reproduction** (see `../07-Debugging-and-Testing/Bug-Hunting-Strategies.md`).

Doing these shows you respect the time of whoever you're asking. Skipping them is why people roll their eyes at beginner questions.

---

## The Anatomy of a Great Question

```
1. Context — what I'm trying to do, what stack, what version.
2. What I tried — specific steps and what happened.
3. The actual error/output — pasted exactly.
4. What I expected — so the reader knows the gap.
5. My best guess — shows you thought about it.
```

### Example: Bad Question

> "My app crashes help"

### Example: Good Question

> I'm building a SwiftUI app on Xcode 16 / iOS 17.
> When I tap my "Save" button, the app crashes with:
>
> `Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value`
>
> The crashing line is `user.email!` in `SaveButton.swift:42`.
>
> I've verified `user` is set when the view loads, but I suspect `email` may be nil if the user hasn't entered one yet.
>
> Expected: a validation alert, not a crash.
>
> Is the right fix to use `guard let email = user.email else { return }`, or is there a more idiomatic SwiftUI pattern?

The second one gets a fix in 60 seconds. The first gets ignored.

---

## Where to Ask

Different questions suit different venues:

| Venue | Good For | Etiquette |
|---|---|---|
| **Stack Overflow** | Specific, reproducible technical questions | Must be unique, answerable, well-tagged |
| **GitHub Issues** | Bugs / features in a specific library | Include version numbers and a minimal repro |
| **Swift Forums** | Language-level questions | Patient, thoughtful audience |
| **Discord / Slack servers** | Conversational, exploratory help | Be polite, don't DM strangers |
| **Your teacher / TA** | Conceptual, project-specific | Ask early, not the night before |
| **AI (Claude, ChatGPT)** | Fast, judgment-free, but sometimes wrong | Verify before believing |

---

## The 15-Minute Rule

If you're stuck for **15 minutes**, ask.

- Less than 15 minutes → you're probably about to figure it out.
- More than 60 minutes stuck on the same thing → you're suffering for no reason.

---

## When Someone Answers

- **Try the answer**, even if it's different from what you expected.
- **Report back** — "that worked, thanks!" or "I tried it but now I see X instead."
- **Accept the answer** on Stack Overflow if it helped.
- **Pay it forward** — answer a question at your skill level for someone else.

---

## What NOT to Do

- Don't say "urgent" or "ASAP." Nobody owes you their time.
- Don't cross-post the same question on 5 platforms.
- Don't paste 500 lines of code when 10 is enough.
- Don't edit out the actual error message.
- Don't say "nothing works" — nothing *specific* doesn't work.

---

## Exercise

Next time you get stuck, write your question in full **before** asking anyone. Often you'll solve it by the time you're done writing. If not, you now have a high-quality question ready to send.
