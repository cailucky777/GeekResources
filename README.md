# GeekResources

### A curated collection of teaching materials for K12 programming education

`Swift` | `SwiftUI` | `iOS Development` | `Unity` | `AR/VR` | `API Integration` | `Competitive Programming` | `AI` | `Web & Python`

---

## What's Inside

```
GeekResources/
|
|-- 00-Setup/                          # Environment setup guides
|-- 01-Swift-Fundamentals/             # Core Swift language
|-- 02-SwiftUI-App-Development/        # Building iOS apps with SwiftUI
|-- 03-Unity-Beginner/                 # Unity game development
|-- 04-AR-Development/                 # Augmented Reality (ARKit, RealityKit, Unity AR)
|-- 05-API-and-Networking/             # REST APIs, JSON, networking
|-- 06-Competitive-Programming/        # Algorithms and contest prep
|-- 07-Debugging-and-Testing/          # Debugger, tests, bug hunting
|-- 08-Data-Persistence/               # UserDefaults, FileManager, SwiftData
|-- 09-AI-Integration/                 # Claude/OpenAI APIs, chatbot tutorial
|-- 10-Publishing-to-App-Store/        # TestFlight & App Store submission
|
|-- Design-Basics/                     # Figma, color, typography, HIG
|-- Portfolio/                         # GitHub profile, personal site, demos
|-- Soft-Skills/                       # Reading docs, asking questions, AI pairing
|-- Cheatsheets/                       # Quick-reference pages for Swift, SwiftUI, Git, Xcode
|-- Extras/                            # watchOS/visionOS, hardware, open source, ML
|-- Web-and-Python/                    # A second language, landing pages, tiny backends
|
|-- Resources/                         # Shared reference materials (books, courses, glossary)
+-- Templates/                         # Starter project templates
```

---

## Quick Navigation

### Core Curriculum

| Section | Description | Key Files |
|---|---|---|
| [00-Setup](./00-Setup/) | Install Xcode, Unity, Swift Playgrounds, Git | [Setup Guide](./00-Setup/Xcode-Unity-SwiftPlaygrounds-Setup.md), [Git & GitHub](./00-Setup/Git-GitHub-Setup.md) |
| [01-Swift-Fundamentals](./01-Swift-Fundamentals/) | Variables, control flow, functions, OOP, protocols | [Learning Path](./01-Swift-Fundamentals/Swift-Learning-Path.md) |
| [02-SwiftUI-App-Development](./02-SwiftUI-App-Development/) | Build real iOS apps with SwiftUI, navigation, data flow | Lessons, demos, projects |
| [03-Unity-Beginner](./03-Unity-Beginner/) | Unity editor, C# scripting, 2D/3D game basics | Lessons, demos |
| [04-AR-Development](./04-AR-Development/) | ARKit, RealityKit, Unity AR Foundation, visionOS | [AR Tutorial](./04-AR-Development/AR-iOS-Tutorial.md) |
| [05-API-and-Networking](./05-API-and-Networking/) | REST APIs, JSON parsing, URLSession, async/await | [API Tutorial](./05-API-and-Networking/API-Integration-Tutorial.md) |
| [06-Competitive-Programming](./06-Competitive-Programming/) | Algorithms, data structures, contest problems | Problems collection |
| [07-Debugging-and-Testing](./07-Debugging-and-Testing/) | Xcode debugger, reading errors, unit tests | Breakpoints, XCTest, Swift Testing |
| [08-Data-Persistence](./08-Data-Persistence/) | UserDefaults, FileManager, SwiftData | When to use what |
| [09-AI-Integration](./09-AI-Integration/) | Claude & OpenAI APIs, chatbot project, prompt basics | Full chatbot tutorial |
| [10-Publishing-to-App-Store](./10-Publishing-to-App-Store/) | TestFlight, App Store submission, rejection reasons | Start-to-finish shipping guide |

### Companion Resources

| Section | Description |
|---|---|
| [Design-Basics](./Design-Basics/) | Figma, color, typography, app icons, Apple HIG |
| [Portfolio](./Portfolio/) | GitHub profile, personal site, demo videos, READMEs |
| [Soft-Skills](./Soft-Skills/) | Reading docs, asking questions, AI pair programming, time management |
| [Cheatsheets](./Cheatsheets/) | Swift, SwiftUI, Git, Xcode, Terminal — one-page references |
| [Extras](./Extras/) | watchOS, visionOS, Arduino/Raspberry Pi, open source, ML, security |
| [Web-and-Python](./Web-and-Python/) | HTML/CSS/JS, Python, a tiny backend for your iOS app |
| [Resources](./Resources/) | Books, courses, glossary, common errors lookup |
| [Templates](./Templates/) | Starter project templates |

---

## Getting Started (For Students)

### 1. Set Up Your Environment

Before writing any code, make sure the following tools are installed on your Mac:

| Tool | What It's For | Guide |
|---|---|---|
| **Xcode** | Writing Swift and SwiftUI apps | [Setup Guide](./00-Setup/Xcode-Unity-SwiftPlaygrounds-Setup.md#part-1-installing-xcode) |
| **Swift Playgrounds** | Interactive Swift learning (Mac/iPad) | [Setup Guide](./00-Setup/Xcode-Unity-SwiftPlaygrounds-Setup.md#part-3-installing-swift-playgrounds) |
| **Unity Hub + Unity** | Game development and AR projects | [Setup Guide](./00-Setup/Xcode-Unity-SwiftPlaygrounds-Setup.md#part-2-installing-unity) |
| **Git** | Version control for all your projects | [Git & GitHub Guide](./00-Setup/Git-GitHub-Setup.md) |
| **GitHub account** | Store and share your code online | [Git & GitHub Guide](./00-Setup/Git-GitHub-Setup.md#creating-a-github-account) |

### 2. Where to Begin

- **Never programmed before?** Start with [01-Swift-Fundamentals](./01-Swift-Fundamentals/) and open Swift Playgrounds on your Mac or iPad.
- **Know some Swift already?** Jump into [02-SwiftUI-App-Development](./02-SwiftUI-App-Development/) to build your first app.
- **Interested in games?** Head to [03-Unity-Beginner](./03-Unity-Beginner/) after you have Swift basics down.
- **Want to build AR experiences?** Work through [04-AR-Development](./04-AR-Development/) once you are comfortable with SwiftUI or Unity.
- **Ready to ship something?** Combine [09-AI-Integration](./09-AI-Integration/) + [10-Publishing-to-App-Store](./10-Publishing-to-App-Store/) for a real capstone project.

### 3. Tips for Success

- Code every day, even if just for 15 minutes.
- Read error messages carefully -- they usually tell you exactly what is wrong. See [Common Errors](./Resources/Common-Errors.md).
- Commit your work to GitHub frequently. Small, frequent commits are better than one giant commit.
- Ask questions early. Do not wait until you are stuck for hours. See [How to Ask Questions](./Soft-Skills/How-to-Ask-Questions.md).
- Keep a [portfolio](./Portfolio/) from day one.

---

## For Teachers

### How to Use This Repo in Class

1. **Clone the repo** to your machine and have students clone it as well (see the [Git setup guide](./00-Setup/Git-GitHub-Setup.md)).
2. **Follow the numbered folders** in order. Each folder corresponds to a unit in the curriculum.
3. Within each unit, the typical structure is:
   - `lessons/` -- Instructional content and explanations
   - `demos/` -- Live-coding examples to walk through in class
   - `exercises/` -- Practice problems for students
   - `projects/` -- Larger assignments and capstone projects
4. **Adapt the pace** to your students. Some groups may spend more time on Swift Fundamentals; others may move quickly to SwiftUI.
5. **Mix in companion resources** — a 15-minute Design-Basics talk or a Soft-Skills discussion every couple of weeks keeps the curriculum well-rounded.

### Lesson Plan Structure

Each unit is designed to support approximately 2-4 weeks of instruction:

| Unit | Recommended Duration | Prerequisites |
|---|---|---|
| 00-Setup | 1 class session | None |
| 01-Swift Fundamentals | 3-4 weeks | 00-Setup |
| 02-SwiftUI App Development | 3-4 weeks | 01-Swift |
| 03-Unity Beginner | 3-4 weeks | Basic programming concepts |
| 04-AR Development | 2-3 weeks | 02-SwiftUI or 03-Unity |
| 05-API and Networking | 2 weeks | 02-SwiftUI |
| 06-Competitive Programming | Ongoing / elective | 01-Swift |
| 07-Debugging and Testing | 2 weeks | 01-Swift |
| 08-Data Persistence | 2 weeks | 02-SwiftUI |
| 09-AI Integration | 2-3 weeks | 05-API |
| 10-Publishing to App Store | 1-2 weeks | Any finished project |

### Assessment Ideas

- **Swift Fundamentals:** Coding exercises with automated tests, short quizzes.
- **SwiftUI / Unity:** Project-based assessment -- students build and present an app or game.
- **AR:** Demo day where students showcase their AR creations on physical devices.
- **Competitive Programming:** Timed problem sets, participation in online contests.
- **Capstone:** A SwiftUI app with data persistence, an API call, and a TestFlight build. Rubric in [Templates](./Templates/Project-Rubric-Template.md).

---

## Recommended Learning Path

The curriculum is designed to follow this progression:

```
 START
   |
   v
[Swift Fundamentals]  ----  Learn the language: variables, functions, OOP, protocols
   |
   v
[SwiftUI]  ---------------  Build real iOS apps: UI, navigation, state management
   |
   |-----> [Unity]  ------  Game development: C# scripting, physics, 2D/3D
   |          |
   v          v
[AR Development]  --------  ARKit + RealityKit (from SwiftUI) or AR Foundation (from Unity)
   |
   v
[API & Networking]  ------  Connect apps to the internet: REST, JSON, async/await
   |
   |----> [Debugging]  ---  Xcode debugger, tests, bug-hunting strategies
   |
   |----> [Persistence]  -  UserDefaults, SwiftData, files
   |
   v
[AI Integration]  --------  Call Claude / OpenAI, build a chatbot, prompt engineering
   |
   v
[Publishing]  ------------  TestFlight + App Store submission
   |
   v
[Competitive Programming]   Algorithms, data structures, problem-solving (ongoing)
```

Students can enter the Unity track in parallel with SwiftUI if they prefer game development. The AR unit accepts students from either path.

---

## Contributing

Contributions are welcome from teachers, TAs, and students.

### How to Contribute

1. **Fork** this repository.
2. **Create a branch** for your changes: `git checkout -b add-new-lesson`.
3. **Make your changes** -- add lessons, fix typos, improve explanations, add exercises.
4. **Commit** with a clear message: `git commit -m "Add lesson on closures in Swift"`.
5. **Push** your branch: `git push origin add-new-lesson`.
6. **Open a Pull Request** with a description of what you changed and why.

### Contribution Guidelines

- Keep explanations clear and beginner-friendly.
- Include code comments in all demo files.
- Test all code samples before submitting.
- Follow the existing folder and naming conventions.
- Add exercises with expected output or solution hints where appropriate.

---

## Key External Resources

| Resource | Topic | Link |
|---|---|---|
| **Hacking with Swift** | Swift & SwiftUI tutorials | [hackingwithswift.com](https://www.hackingwithswift.com) |
| **Swift by Sundell** | Swift articles and tips | [swiftbysundell.com](https://www.swiftbysundell.com) |
| **Codecademy** | Interactive coding courses | [codecademy.com](https://www.codecademy.com) |
| **Unity Learn** | Official Unity tutorials | [learn.unity.com](https://learn.unity.com) |
| **Apple Developer** | Documentation, WWDC videos, sample code | [developer.apple.com](https://developer.apple.com) |
| **Swift.org** | Language reference, evolution proposals | [swift.org](https://www.swift.org) |
| **Ray Wenderlich (Kodeco)** | iOS and game dev tutorials | [kodeco.com](https://www.kodeco.com) |
| **Anthropic Docs** | Claude API reference | [docs.anthropic.com](https://docs.anthropic.com) |
| **OpenAI Docs** | OpenAI API reference | [platform.openai.com/docs](https://platform.openai.com/docs) |

---

## License

This project is licensed under the **MIT License**. See [LICENSE](./LICENSE) for details.

You are free to use, modify, and distribute these materials for educational purposes.

---

*Built with care for the next generation of developers.*
