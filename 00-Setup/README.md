# 00-Setup

Everything you need to get your development environment ready before writing code.

---

## Contents

| Guide | Description |
|---|---|
| [Xcode, Unity & Swift Playgrounds Setup](./Xcode-Unity-SwiftPlaygrounds-Setup.md) | Install Xcode, Unity Hub + Editor, and Swift Playgrounds on macOS/iPad |
| [Git & GitHub Setup](./Git-GitHub-Setup.md) | Install Git, create a GitHub account, SSH keys, basic commands |

---

## Quick Checklist

Before your first class, make sure you have:

- [ ] macOS updated to the latest version
- [ ] Xcode installed and opened at least once (to install components)
- [ ] Unity Hub + Unity Editor installed with iOS Build Support
- [ ] Swift Playgrounds installed
- [ ] Git installed (`git --version` works in Terminal)
- [ ] GitHub account created
- [ ] SSH key added to your GitHub account

---

## Git & GitHub Basics

If you are completely new to Git, here is a quick overview. For the full guide, see [Git-GitHub-Setup.md](./Git-GitHub-Setup.md).

### Installing Git

Git comes pre-installed on most Macs. Open Terminal and run:

```bash
git --version
```

If it is not installed, macOS will prompt you to install the Command Line Tools. Click **Install** and wait for it to finish.

### Creating a GitHub Account

1. Go to [github.com](https://github.com) and click **Sign up**.
2. Choose a professional username (this will be on your resume someday).
3. Verify your email address.
4. Optional: Set up a profile picture and bio.

### Essential Commands

| Command | What It Does |
|---|---|
| `git clone <url>` | Download a repo from GitHub to your computer |
| `git add <file>` | Stage a file for commit |
| `git add .` | Stage all changed files |
| `git commit -m "message"` | Save staged changes with a description |
| `git push` | Upload your commits to GitHub |
| `git pull` | Download the latest changes from GitHub |
| `git status` | See which files are changed, staged, or untracked |
| `git log --oneline` | View recent commit history |

### Creating a New Repository

1. Go to [github.com/new](https://github.com/new).
2. Enter a repository name (e.g., `my-first-app`).
3. Choose **Public** or **Private**.
4. Check **Add a README file**.
5. Click **Create repository**.
6. Clone it to your Mac:

```bash
git clone git@github.com:YOUR_USERNAME/my-first-app.git
cd my-first-app
```

Now you are ready to start coding in that folder.

---

## Recommended VS Code Extensions for Swift

If you use Visual Studio Code alongside Xcode, these extensions improve the experience:

| Extension | Purpose |
|---|---|
| **Swift** (Swift Server Work Group) | Swift language support, syntax highlighting, IntelliSense |
| **CodeLLDB** | Debugger for Swift (and C/C++) |
| **SwiftLint** | Linting and style enforcement for Swift code |
| **SwiftFormat** | Auto-format Swift files on save |
| **GitLens** | Enhanced Git integration (blame, history, diffs) |
| **GitHub Copilot** | AI-assisted code completion (free for students) |
| **Markdown Preview Enhanced** | Preview `.md` files as you write them |

### Installing Extensions

1. Open VS Code.
2. Press `Cmd + Shift + X` to open the Extensions panel.
3. Search for each extension by name and click **Install**.

> **Note:** For most Swift and SwiftUI development, Xcode is the primary IDE. VS Code is a good supplement for editing scripts, Markdown files, and working with Git.

---

## Apple Developer Account

To run apps on a physical iPhone or iPad, you need an Apple Developer account.

### Free Account (Apple ID)

- **What you get:** Run apps on your own devices via Xcode, access documentation, use Swift Playgrounds.
- **Limitations:** Cannot distribute apps on the App Store. Provisioning profiles expire after 7 days (you will need to re-deploy).
- **How to set up:** Just sign in with your Apple ID in Xcode > Settings > Accounts.

### Paid Account ($99/year)

- **What you get:** Everything in the free tier, plus App Store distribution, TestFlight beta testing, advanced app services (Push Notifications, iCloud, Sign in with Apple), and provisioning profiles that last 1 year.
- **Who needs it:** Students submitting apps to the App Store, teachers managing a classroom of devices, anyone entering WWDC Swift Student Challenge.
- **How to enroll:** Go to [developer.apple.com/programs/enroll](https://developer.apple.com/programs/enroll/).

### For Classrooms

If you are a teacher managing multiple student devices:

- Students can use the **free tier** for all coursework in this curriculum.
- Consider enrolling in the **Apple Developer Enterprise Program** or using Apple School Manager if your school distributes apps internally.
- For the WWDC Swift Student Challenge, a free Apple ID is sufficient to submit.

---

*Once your environment is set up, head to [01-Swift-Fundamentals](../01-Swift-Fundamentals/) to start coding.*
