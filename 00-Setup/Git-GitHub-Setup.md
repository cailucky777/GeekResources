# Git & GitHub Setup Guide

A step-by-step guide for students to install Git, set up GitHub, and learn the basic workflow for managing code.

---

## Table of Contents

1. [Installing Git on macOS](#installing-git-on-macos)
2. [Configuring Git](#configuring-git)
3. [Creating a GitHub Account](#creating-a-github-account)
4. [SSH Key Setup](#ssh-key-setup)
5. [Basic Git Workflow](#basic-git-workflow)
6. [Common Commands Cheat Sheet](#common-commands-cheat-sheet)
7. [Creating Your First Repository](#creating-your-first-repository)
8. [.gitignore for Swift / Xcode Projects](#gitignore-for-swift--xcode-projects)
9. [.gitignore for Unity Projects](#gitignore-for-unity-projects)

---

## Installing Git on macOS

### Option A: Via Xcode Command Line Tools (Recommended)

If you already installed Xcode, Git is included. Verify by opening **Terminal** and running:

```bash
git --version
```

Expected output:

```
git version 2.x.x
```

If Git is not found, macOS will prompt you to install the Command Line Tools. Click **Install** and wait a few minutes.

You can also trigger the installation manually:

```bash
xcode-select --install
```

### Option B: Via Homebrew

If you use Homebrew (a package manager for macOS):

```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Git
brew install git
```

### Verify Installation

```bash
git --version
which git
```

You should see the version number and the path (usually `/usr/bin/git` or `/opt/homebrew/bin/git`).

---

## Configuring Git

After installing Git, tell it who you are. This information is attached to every commit you make.

```bash
# Set your name (use your real name)
git config --global user.name "Your Full Name"

# Set your email (use the same email as your GitHub account)
git config --global user.email "your.email@example.com"
```

### Verify Configuration

```bash
git config --global --list
```

You should see:

```
user.name=Your Full Name
user.email=your.email@example.com
```

### Recommended Settings

```bash
# Set the default branch name to 'main'
git config --global init.defaultBranch main

# Enable colored output in Terminal
git config --global color.ui auto

# Set VS Code as the default editor for Git (optional)
git config --global core.editor "code --wait"
```

---

## Creating a GitHub Account

1. Go to [github.com](https://github.com).
2. Click **Sign up** in the top-right corner.
3. Enter your email, create a password, and choose a username.
   - **Username tip:** Pick something professional. Avoid random numbers or joke names. This will appear on your profile, projects, and potentially future job applications.
4. Complete the verification puzzle.
5. Check your email and click the verification link.

### After Creating Your Account

- **Add a profile picture** -- it makes your account look real and professional.
- **Write a short bio** -- e.g., "K12 student learning Swift and iOS development."
- **Star this repository** so you can find it easily later.

### GitHub Student Developer Pack (Free)

GitHub offers free access to many developer tools for students:

1. Go to [education.github.com/pack](https://education.github.com/pack).
2. Click **Get your pack**.
3. Verify your student status with a school email or student ID.
4. You get free access to GitHub Copilot, various cloud platforms, domain names, and more.

---

## SSH Key Setup

SSH keys let you connect to GitHub without typing your password every time.

### Step 1: Check for Existing Keys

```bash
ls -al ~/.ssh
```

If you see files like `id_ed25519` and `id_ed25519.pub`, you already have a key pair. Skip to Step 3.

### Step 2: Generate a New SSH Key

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

When prompted:

- **File location:** Press Enter to accept the default (`~/.ssh/id_ed25519`).
- **Passphrase:** You can press Enter for no passphrase (simpler) or type a passphrase for extra security.

### Step 3: Add the Key to the SSH Agent

```bash
# Start the SSH agent
eval "$(ssh-agent -s)"

# Add your key
ssh-add ~/.ssh/id_ed25519
```

If you are on macOS Monterey or later, create or edit the SSH config file to automatically load keys:

```bash
touch ~/.ssh/config
open ~/.ssh/config
```

Add these lines:

```
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
```

### Step 4: Add the Public Key to GitHub

Copy your public key to the clipboard:

```bash
pbcopy < ~/.ssh/id_ed25519.pub
```

Then:

1. Go to [github.com/settings/keys](https://github.com/settings/keys).
2. Click **New SSH key**.
3. Give it a title (e.g., "My MacBook").
4. Paste the key into the **Key** field.
5. Click **Add SSH key**.

### Step 5: Test the Connection

```bash
ssh -T git@github.com
```

Expected output:

```
Hi YOUR_USERNAME! You've successfully authenticated, but GitHub does not provide shell access.
```

If you see this message, SSH is set up correctly.

---

## Basic Git Workflow

Here is the typical cycle you will follow for every project:

```
  +-------------------+
  |  Working Directory |   <-- You edit files here
  +-------------------+
           |
       git add
           |
           v
  +-------------------+
  |   Staging Area     |   <-- Files ready to be committed
  +-------------------+
           |
      git commit
           |
           v
  +-------------------+
  |  Local Repository  |   <-- Saved on your computer
  +-------------------+
           |
       git push
           |
           v
  +-------------------+
  |  Remote (GitHub)   |   <-- Saved in the cloud
  +-------------------+
```

### The Daily Workflow

```
  Start of session                End of session
       |                               |
       v                               v
   git pull                        git add .
   (get latest                     git commit -m "describe what you did"
    changes)                       git push
       |                           (upload to GitHub)
       v
   Write code,
   test, debug
```

### Step-by-Step Example

```bash
# 1. Clone a repo (first time only)
git clone git@github.com:YOUR_USERNAME/my-project.git
cd my-project

# 2. Pull the latest changes (do this every time you start working)
git pull

# 3. Make changes to your files (write code, add files, etc.)
#    ... edit files in Xcode or VS Code ...

# 4. Check what changed
git status

# 5. Stage your changes
git add .                    # Stage all changes
# or
git add MyFile.swift         # Stage a specific file

# 6. Commit with a descriptive message
git commit -m "Add login screen with email and password fields"

# 7. Push to GitHub
git push

# 8. Verify on GitHub
#    Go to your repo on github.com and confirm your changes are there.
```

### Branching (Intermediate)

Branches let you work on features without affecting the main code:

```
  main --------o--------o--------o--------o  (stable code)
                \                        /
  feature        o----o----o----o-------   (your new feature)
                  create   work  work  merge
```

```bash
# Create and switch to a new branch
git checkout -b my-new-feature

# Work on your feature, add, commit as usual
git add .
git commit -m "Add new feature"

# Push the branch to GitHub
git push -u origin my-new-feature

# When done, merge back into main
git checkout main
git pull
git merge my-new-feature
git push
```

---

## Common Commands Cheat Sheet

### Setup

| Command | Description |
|---|---|
| `git config --global user.name "Name"` | Set your name |
| `git config --global user.email "email"` | Set your email |
| `git config --global --list` | View all settings |

### Getting Started

| Command | Description |
|---|---|
| `git init` | Initialize a new Git repo in the current folder |
| `git clone <url>` | Download a repo from GitHub |

### Daily Workflow

| Command | Description |
|---|---|
| `git status` | Show changed, staged, and untracked files |
| `git add <file>` | Stage a specific file |
| `git add .` | Stage all changes in the current directory |
| `git commit -m "message"` | Commit staged changes with a message |
| `git push` | Upload commits to GitHub |
| `git pull` | Download and merge latest changes from GitHub |

### Viewing History

| Command | Description |
|---|---|
| `git log` | Show full commit history |
| `git log --oneline` | Show compact commit history |
| `git log --oneline --graph` | Show history with branch visualization |
| `git diff` | Show unstaged changes |
| `git diff --staged` | Show staged changes |

### Branching

| Command | Description |
|---|---|
| `git branch` | List all local branches |
| `git branch <name>` | Create a new branch |
| `git checkout <name>` | Switch to a branch |
| `git checkout -b <name>` | Create and switch to a new branch |
| `git merge <branch>` | Merge a branch into the current branch |
| `git branch -d <name>` | Delete a branch (after merging) |

### Undoing Things

| Command | Description |
|---|---|
| `git restore <file>` | Discard changes in a file (back to last commit) |
| `git restore --staged <file>` | Unstage a file (keep the changes) |
| `git commit --amend -m "new message"` | Fix the last commit message |

---

## Creating Your First Repository

Let's walk through creating a project from scratch.

### On GitHub

1. Go to [github.com/new](https://github.com/new).
2. **Repository name:** `hello-swift`
3. **Description:** "My first Swift project"
4. **Visibility:** Public (or Private if you prefer)
5. Check **Add a README file**.
6. Under **Add .gitignore**, select **Swift**.
7. Under **Choose a license**, select **MIT License**.
8. Click **Create repository**.

### On Your Mac

```bash
# Clone the repo
git clone git@github.com:YOUR_USERNAME/hello-swift.git

# Navigate into the folder
cd hello-swift

# See what's already there
ls -la
# You should see: README.md, .gitignore, LICENSE

# Create a Swift file
cat > main.swift << 'EOF'
print("Hello, Swift!")
print("This is my first project.")
EOF

# Check the status
git status
# Output: main.swift is listed as an untracked file

# Stage, commit, and push
git add main.swift
git commit -m "Add main.swift with hello world program"
git push

# Done! Check github.com to see your file.
```

---

## .gitignore for Swift / Xcode Projects

When you work in Xcode, it generates many files that should not be tracked by Git (build artifacts, user settings, etc.). Create a `.gitignore` file in your project root with the following content:

```gitignore
# Xcode
build/
DerivedData/
*.xcuserstate
*.xccheckout
*.moved-aside
*.hmap
*.ipa
*.dSYM.zip
*.dSYM

# Xcode user-specific files
xcuserdata/
*.xcscmblueprint

# Swift Package Manager
.build/
Packages/
Package.resolved

# CocoaPods
Pods/
*.xcworkspace

# Carthage
Carthage/Build/
Carthage/Checkouts/

# OS files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
Thumbs.db

# Swift Playgrounds
timeline.xctimeline
playground.xcworkspace

# Fastlane
fastlane/report.xml
fastlane/Preview.html
fastlane/screenshots/**/*.png
fastlane/test_output

# Environment / secrets
.env
*.pem
```

### How to Use

If you selected **Swift** as the `.gitignore` template when creating the repo on GitHub, most of this is already included. If not:

```bash
# Create the file in your project root
touch .gitignore

# Open it in your editor and paste the content above
open .gitignore

# Stage and commit it
git add .gitignore
git commit -m "Add .gitignore for Xcode/Swift project"
git push
```

> **Important:** Add the `.gitignore` before your first commit so that build files are never tracked. If you already committed unwanted files, you will need to remove them from tracking:
>
> ```bash
> git rm -r --cached DerivedData/
> git commit -m "Remove DerivedData from tracking"
> ```

---

## .gitignore for Unity Projects

Unity projects generate large binary files and local settings that should not be in Git.

```gitignore
# Unity generated
[Ll]ibrary/
[Tt]emp/
[Oo]bj/
[Bb]uild/
[Bb]uilds/
[Ll]ogs/
[Uu]ser[Ss]ettings/
[Mm]emoryCaptures/
[Rr]ecordings/

# Asset meta files (KEEP .meta files -- they are important!)
# Do NOT add *.meta to gitignore

# Unity3D generated
*.pidb.meta
*.pdb.meta
*.mdb.meta

# IDE
.vs/
.vscode/
*.csproj
*.unityproj
*.sln
*.suo
*.tmp
*.user
*.userprefs
*.pidb
*.booproj
*.svd
*.pdb
*.mdb
*.opendb
*.VC.db

# Rider
.idea/

# OS files
.DS_Store
.DS_Store?
._*
Thumbs.db

# Builds
*.apk
*.aab
*.ipa
*.unitypackage

# Crashlytics
crashlytics-build.properties
sysinfo.txt

# Plastic SCM
*.ignore
```

### Important Notes for Unity Projects

1. **Keep `.meta` files.** Unity uses `.meta` files to track references between assets. If you delete them, Unity will regenerate them with new GUIDs and all references will break.

2. **Use Unity's Version Control settings.** In Unity, go to **Edit > Project Settings > Version Control** and set the Mode to **Visible Meta Files**. Then go to **Edit > Project Settings > Editor** and set **Asset Serialization** to **Force Text**. This ensures Git can properly diff your scene and prefab files.

3. **Consider Git LFS for large files.** If your project has large textures, audio, or 3D models:

```bash
# Install Git LFS
brew install git-lfs
git lfs install

# Track large file types
git lfs track "*.psd"
git lfs track "*.png"
git lfs track "*.wav"
git lfs track "*.mp3"
git lfs track "*.fbx"
git lfs track "*.obj"

# Commit the .gitattributes file that Git LFS creates
git add .gitattributes
git commit -m "Configure Git LFS for large assets"
```

---

## What's Next?

Once Git and GitHub are set up:

- Clone this repository: `git clone git@github.com:YOUR_ORG/GeekResources.git`
- Set up your development tools: [Xcode, Unity & Swift Playgrounds Setup](./Xcode-Unity-SwiftPlaygrounds-Setup.md)
- Start learning Swift: [01-Swift-Fundamentals](../01-Swift-Fundamentals/)

---

*If you run into issues with Git setup, ask your teacher or check the [GitHub Docs](https://docs.github.com/en/get-started).*
