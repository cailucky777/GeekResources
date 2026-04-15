# AI Pair Programming

> "The AI didn't do my homework. It taught me how to do it faster next time." — how you should feel after every session.

AI is here. Pretending otherwise doesn't help anyone. But **using it to skip learning** hurts you more than anyone else. Here's how to use Claude, ChatGPT, Cursor, Copilot, and friends to become a **better** programmer, not a replaceable one.

---

## The North Star

You should be able to, on a plane with no internet, **still write code.**

Whatever tools you use while online, make sure your skills keep growing. AI is a bicycle for your mind, not a wheelchair.

---

## Good Uses of AI (Do More of These)

1. **Explain this code to me.** Paste unfamiliar code, ask for a breakdown.
2. **What's a better way to do this?** Ask for critique on your own code.
3. **What could go wrong with this?** Ask for edge cases you missed.
4. **Draft a first pass** — then you edit, refine, and understand.
5. **Unstick you on concepts.** "I don't understand closures" → get 3 explanations in different styles.
6. **Generate test cases** so you're forced to write the code yourself.
7. **Summarize docs** when you're swimming in Apple's 1000-page book.

---

## Risky Uses of AI (Don't Do These)

1. **Copy-paste into your homework without reading.** This is both cheating and counterproductive.
2. **Accept code you don't understand.** If you can't explain it line by line, don't ship it.
3. **Trust it for factual claims.** LLMs hallucinate — library versions, API methods, historical facts.
4. **Skip debugging.** Pasting the error and applying the first suggestion is a shortcut to fragile code.
5. **Let it write tests for code it also wrote.** Closed loop, won't catch bugs.

---

## The "Teach Me" Prompt Pattern

Instead of:

> "Write me a binary search tree in Swift."

Try:

> "I want to implement a binary search tree in Swift. I know the concept but haven't coded one before. Ask me step-by-step questions to guide me to the implementation. Don't give me the answer — give me hints."

You end up with the same code *and* the knowledge.

---

## The "Review My Work" Pattern

> "Here's my implementation of [feature]. Before saying anything nice, point out:
> - any bugs or crashes,
> - any places that won't scale,
> - any naming choices you'd change,
> - anything you'd test before shipping.
> Be blunt."

This is how senior engineers get AI to work for them.

---

## Academic Honesty

Every school has different rules. In general:

- **OK, usually:** Using AI to explain concepts, debug, suggest refactors.
- **OK, usually:** AI-assisted autocomplete (Copilot, Cursor) as you write your own code.
- **Usually not OK:** Submitting AI-generated code as "your own work" without disclosure.
- **Usually not OK:** Asking AI to do your homework verbatim.

**When in doubt, ask your teacher.** They'd rather you check than assume.

---

## Commit Hygiene

If AI contributed meaningfully to a commit, you can mention it in the commit body — some teams ask for it. And **you** are still responsible for every line — it's your name on the commit.

---

## The Test: Could You Rebuild It?

After any AI-assisted session, ask yourself:

> "If my AI was gone tomorrow, could I rebuild this feature on my own in an afternoon?"

If **yes**, you've learned.
If **no**, you've borrowed. Borrow less next time.

---

## Exercise

For your next feature:

1. Write 15 minutes of code **without any AI**.
2. Then open your AI tool and ask: *"Here's what I have. What's wrong or could be better?"*
3. Apply only the changes you understand.
4. Commit with a note on what you changed and why.

Repeat that rhythm. You'll ship faster **and** learn more than your peers using AI without intent.
