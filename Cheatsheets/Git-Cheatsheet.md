# Git Cheatsheet

The 20 commands you'll actually run every week.

---

## Starting a Project

```bash
git init                          # new repo in current folder
git clone <url>                   # copy an existing repo
```

## Daily Flow

```bash
git status                        # what changed?
git diff                          # show my unstaged changes
git diff --staged                 # show my staged changes
git add file.swift                # stage a specific file
git add .                         # stage everything (careful!)
git commit -m "Fix crash on empty state"
git log --oneline -20             # last 20 commits
```

## Branches

```bash
git switch -c feature/login       # create + switch to new branch
git switch main                   # switch to existing
git branch                        # list branches
git branch -d old-branch          # delete a merged branch
```

## Remote

```bash
git push -u origin feature/login  # push first time + track
git push                          # subsequent pushes
git pull                          # fetch + merge from remote
git fetch                         # just fetch, don't merge
```

## Undo

```bash
git restore file.swift            # discard unstaged changes to file
git restore --staged file.swift   # unstage
git commit --amend                # fix last commit (before push only!)
git reset --soft HEAD~1           # undo last commit, keep changes staged
git revert <hash>                 # create a new commit that undoes <hash>
```

## Stash

```bash
git stash                         # save uncommitted work aside
git stash pop                     # bring it back
git stash list
```

## Inspection

```bash
git blame file.swift              # who wrote each line
git show <hash>                   # show a specific commit
git log -- path/to/file           # history of one file
```

## Merge vs Rebase

```bash
git merge main                    # bring main into this branch (creates merge commit)
git rebase main                   # replay my commits on top of main (cleaner history)
```

Rule: rebase your own branch before pushing; never rebase a shared branch others pulled.

## Writing Good Commit Messages

```
feat: add swipe-to-delete on notes list
fix: prevent crash when user has no email
refactor: extract NoteRow into its own file
docs: update README run instructions
```

Imperative mood, short, specific. The body (separate paragraph) explains **why** if it's not obvious.

## .gitignore Starter for Xcode

```
.DS_Store
**/xcuserdata/
DerivedData/
.build/
*.xcuserstate
Pods/
Secrets.xcconfig
.env
```

## Emergency

```bash
git reflog                        # undo anything — shows every HEAD move
```

If you've panicked and think you lost work, `git reflog` is usually the answer.
