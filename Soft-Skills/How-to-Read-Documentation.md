# How to Read Documentation

> "Read the docs" is the most common — and least helpful — advice in programming. Here's how to actually do it.

Good developers don't memorize APIs. They know **where to look** and **how to skim.**

---

## 1. Know the Landscape of Docs

Different docs exist for different purposes:

| Type | Good For | Example |
|---|---|---|
| **Reference** | Exact method signatures, parameters, return values | [developer.apple.com/documentation](https://developer.apple.com/documentation) |
| **Guides / Tutorials** | Walk-throughs of a concept | [Apple's SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui) |
| **Cookbook / How-tos** | "How do I do X?" recipes | [Hacking with Swift Examples](https://www.hackingwithswift.com/example-code) |
| **Spec / Proposals** | Deep reasoning behind a feature | [Swift Evolution](https://github.com/apple/swift-evolution) |
| **Release notes** | What changed | Xcode release notes |

Match the doc type to your question. Reference docs for "what are the arguments?", tutorials for "how does this whole thing fit together?"

---

## 2. Learn to Skim

Nobody reads documentation top to bottom. They:

1. **Scroll quickly** to get the shape of the page.
2. **Ctrl-F for the exact thing they need.**
3. **Look at code examples first**, prose second.
4. **Copy, paste, run, understand by editing.**

If you land on a page and panic at the length — breathe. You need one paragraph of it.

---

## 3. Apple Docs: Practical Tips

- **Each method has a `See Also` section.** Related APIs live one click away.
- **The symbol `->` means "returns."** `func foo() -> String` returns a `String`.
- **"Discussion" sections contain the good stuff** — nuance, caveats, gotchas.
- **Use the filter box in the sidebar.** It narrows by words.

---

## 4. Stack Overflow: How to Use It Well

Old but still useful. When you land on a SO answer:

- **Check the date.** Anything from before 2020 might be outdated for modern Swift.
- **Read the top 2–3 answers.** The accepted one isn't always the best.
- **Check comments** — they often correct the answer.
- **Look for answers with recent activity**, not just highest score.

---

## 5. GitHub: Reading Source Code

When docs are sparse, the code is the documentation.

- **Tests are the best docs.** `*Tests.swift` files show working examples of every feature.
- **Use GitHub's global search**: `yourlib filename:*.swift "your_function"`.
- **Press `t` on any repo** to open the file finder. Fuzzy search any file.

---

## 6. Hands-On Exercises

Each of these takes 5 minutes:

1. Look up `URLSession.shared.data(for:)` on Apple's site. Find the full return type. Find one `See Also` link.
2. Search Apple docs for `Predicate<Todo>`. Copy one example. Explain it in your own words.
3. On GitHub, find the source of `SwiftUI`'s `Text`. (Trick: it's not open-source — but notice which parts *are*.)
4. Search `site:hackingwithswift.com how to debounce a text field`. Read the first result.
5. Find the Swift Evolution proposal for **macros** (`SE-0382`). Read just the "Motivation" section.

---

## The Meta-Skill

When you hit an unknown API, ask yourself:

1. **Where would this be documented?** (Reference, tutorial, GitHub README?)
2. **What's the single paragraph I need?**
3. **What's the smallest runnable example?**

Answering those three questions quickly is ⅔ of senior engineering.
