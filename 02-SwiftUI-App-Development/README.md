# Module 02: SwiftUI App Development

## Curriculum Overview

This 8-week module teaches students how to build native iOS apps using SwiftUI, Apple's modern declarative UI framework. Students will progress from basic views and layouts to fully functional, data-driven applications, culminating in a self-directed final project.

---

## Prerequisites

- Completed **Module 01: Swift Fundamentals** (or equivalent)
- Comfortable with Swift syntax: variables, constants, functions, closures, structs, enums, optionals
- Xcode installed (version 15 or later recommended)
- A Mac running macOS Sonoma or later
- No prior SwiftUI experience required

---

## Learning Objectives

By the end of this module, students will be able to:

1. Build user interfaces declaratively using SwiftUI views and modifiers.
2. Manage app state with `@State`, `@Binding`, and `@Observable`.
3. Implement navigation patterns using `NavigationStack` and `NavigationLink`.
4. Design data models with Swift structs and connect them to views.
5. Work with lists, forms, and user input controls.
6. Apply animations, gradients, and SF Symbols for polished UI design.
7. Persist simple data using `UserDefaults` or JSON files.
8. Plan, build, and present a complete SwiftUI application independently.

---

## 8-Week Lesson Plan

| Week | Topic | Key Concepts |
|------|-------|--------------|
| 1 | [SwiftUI Basics](lessons/Week01-SwiftUI-Basics.md) | Views, Text, Image, VStack/HStack/ZStack, modifiers |
| 2 | [State and Binding](lessons/Week02-State-and-Binding.md) | @State, @Binding, Button, TextField |
| 3 | [Lists and Navigation](lessons/Week03-Lists-and-Navigation.md) | List, NavigationStack, NavigationLink, detail views |
| 4 | [Data and Models](lessons/Week04-Data-and-Models.md) | Structs as models, @Observable, data flow |
| 5 | Forms, Pickers, and User Input | Form, Picker, Toggle, Slider, DatePicker |
| 6 | Animations and Polish | withAnimation, transitions, gradients, SF Symbols |
| 7 | Persistence and App Architecture | UserDefaults, JSON encoding/decoding, app structure |
| 8 | Final Project Presentations | Demo day, peer feedback, reflection |

---

## Final Project

### Build Your Own App

In the final two weeks of the module, each student (or pair) will design and build an original SwiftUI application. The project must demonstrate:

- **At least 3 screens** with navigation between them
- **A data model** using structs and `@Observable`
- **User input** via forms, text fields, or other controls
- **A list view** that displays dynamic data
- **At least one animation or visual polish element**

Students will present their apps on the last day, including a short walkthrough and a brief explanation of one technical challenge they solved.

See [Project Ideas](projects/Project-Ideas.md) for inspiration.

---

## Folder Structure

```
02-SwiftUI-App-Development/
├── README.md              ← You are here
├── lessons/               ← Weekly lesson plans and teaching notes
│   ├── Week01-SwiftUI-Basics.md
│   ├── Week02-State-and-Binding.md
│   ├── Week03-Lists-and-Navigation.md
│   └── Week04-Data-and-Models.md
├── demos/                 ← Runnable demo projects for classroom use
│   ├── Demo01-ProfileCard.swift
│   ├── Demo02-TodoApp.swift
│   └── Demo03-WeatherUI.swift
└── projects/              ← Final project guidelines and ideas
    └── Project-Ideas.md
```

---

## Resources

- [Apple SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [SF Symbols App](https://developer.apple.com/sf-symbols/)
- [Hacking with Swift - 100 Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui)
