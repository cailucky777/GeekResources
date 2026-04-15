# Your First Open-Source Contribution

Shipping a PR that gets merged into a real library is one of the most **validating** experiences in programming. It's also great for your portfolio — anyone can clone a tutorial; few can say "I'm a contributor to X."

---

## Why Contribute

- **Learn from real code** written by professionals.
- **Feedback from senior engineers** you'd never otherwise meet.
- **Public record of your work.**
- **Pay it back** to libraries you use for free.

---

## Finding a Good First Issue

Start where you already work. Look at the libraries your projects already depend on:

1. Go to the GitHub repo.
2. Check the **Issues** tab → filter by label `good first issue` or `help wanted`.
3. Filter by "open" and "no assignee."

Good targets:

- A typo or broken link in the README.
- A missing test case.
- A small clarification in documentation.
- A tiny bug with clear reproduction steps.

**Bad targets for a first PR:**

- "Rewrite this whole subsystem."
- Issues older than 2 years.
- Issues with 50 comments of debate.

---

## The Workflow

### 1. Say You're Working On It

Comment on the issue: *"I'd like to try this — may I pick it up?"* Wait for a maintainer to say yes. This avoids two people doing the same work.

### 2. Read the Contributing Guide

Most repos have a `CONTRIBUTING.md` or `CONTRIBUTE.md`. Read it end to end. It tells you:

- Commit message format.
- Branch name conventions.
- How to run tests locally.
- Whether to open an issue before a PR.

### 3. Fork and Branch

```bash
# On the repo's GitHub page, click "Fork."
git clone https://github.com/YOUR-USERNAME/the-repo.git
cd the-repo
git switch -c fix-typo-in-readme
```

### 4. Make the Smallest Possible Change

Resist scope creep. If you notice 10 other things — note them, don't fix them in this PR. One focused PR is 10x more likely to merge than a sprawling one.

### 5. Run Tests

```bash
# Usually one of:
swift test
npm test
python -m pytest
```

Never open a PR where tests fail locally.

### 6. Commit + Push

```bash
git add -A
git commit -m "Fix typo in README installation steps"
git push -u origin fix-typo-in-readme
```

### 7. Open the PR

On GitHub, you'll see a banner offering to open a PR. Use it. Fill in:

- **Title** — imperative and specific.
- **Body** — what & why. Reference the issue: `Closes #123`.
- **Checklist** — follow the repo's template if there is one.

### 8. Respond to Review

- Don't take feedback personally.
- Reply to each comment ("done" or "here's why I think...").
- Push new commits to the same branch — the PR updates automatically.
- When asked to "squash" your commits, follow their instructions.

### 9. Celebrate

When the maintainer merges your PR, **you're now a contributor.** Note it on your resume. Put the merged-PR link in your portfolio.

---

## Unwritten Rules

- **Be patient.** Maintainers are often unpaid. Don't bump an issue more than once a week.
- **Be grateful.** Even if they reject your PR, say thanks for the time spent reviewing.
- **Be humble.** You don't know the history of the codebase.
- **Read closed PRs** for clues about style and expectations.

---

## Good Repos for Student First-PRs

- **Hacktoberfest-labeled repos** (every October).
- **Beginner-friendly lists** on sites like [goodfirstissue.dev](https://goodfirstissue.dev), [up-for-grabs.net](https://up-for-grabs.net).
- **Tiny Swift libraries** you use — often a single-maintainer project welcomes help.
- **Documentation sites** for libraries — fixing a docs typo is a real contribution.

---

## Exercise

This week:

1. Pick one library your projects actually depend on.
2. Read its `CONTRIBUTING.md`.
3. Skim the open issues.
4. Find one you could finish in ≤2 hours.
5. Ship it.
