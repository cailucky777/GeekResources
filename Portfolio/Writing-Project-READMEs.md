# Writing Project READMEs That Sell

A README is the landing page for your project. Most student READMEs are bad — which means yours has an easy path to stand out.

---

## The Template

```markdown
# Project Name

One-line description. What it is, who it's for.

![Screenshot](./docs/screenshot.png)

## Demo

- 🎥 [30-second demo video](link)
- 🚀 [Live demo / TestFlight](link)

## Features

- Feature 1 (one clear sentence)
- Feature 2
- Feature 3

## Tech Stack

Swift · SwiftUI · SwiftData · Claude API

## Running Locally

1. Clone the repo.
2. Open `ProjectName.xcodeproj` in Xcode 16+.
3. Add your API key as described in `Safety-First-API-Keys.md`.
4. `⌘R`.

## What I Learned

Short, honest section. What surprised you, what you'd do differently.

## Roadmap

- [ ] v0.2 — iCloud sync
- [ ] v0.3 — Widget

## License

MIT
```

---

## The Non-Negotiables

1. **A screenshot (or GIF) above the fold.** This alone puts you ahead of 90% of student projects.
2. **One-sentence description.** Before any details, answer "what is this?"
3. **How to run.** If someone can't open and run it in 5 minutes, they won't.
4. **Your name somewhere.** Pronouns optional, accountability non-optional.

---

## Screenshots and GIFs

- **Screenshots** → clean simulator captures, all same device size.
- **GIFs** → use [Kap](https://getkap.co) or macOS built-in screen recorder then convert with [ezgif](https://ezgif.com). Keep under 3 MB.
- Store media in a `docs/` or `assets/` folder to keep the root tidy.

---

## What "What I Learned" Should Look Like

**Generic and bad:**
> "I learned a lot about Swift."

**Specific and good:**
> "SwiftData's `@Query` macro made my view reactive with almost no code — but composing predicates across multiple models tripped me up for two days. Eventually I modeled a lookup table instead, which made queries simpler."

Specificity is the whole trick.

---

## Badges (Use Sparingly)

If you want them, a couple can add credibility:

```markdown
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![License: MIT](https://img.shields.io/badge/license-MIT-blue)
```

Don't stack six badges. It starts looking cargo-culted.

---

## Bonus: Link Everything

Every mention of a library, tool, or concept → link it. Readers love clickable context.

---

## Exercise

Pick your best current repo. Run this audit:

- [ ] Does the README have a screenshot?
- [ ] Is there a one-sentence description above the fold?
- [ ] Can I clone and run it in 5 minutes?
- [ ] Is "What I learned" specific?

Fix the first thing that fails. You just made yourself more hireable.
