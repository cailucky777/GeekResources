# API & Networking Module

## Overview

This module teaches students how to work with web APIs and network requests in Swift. Students will learn to fetch data from the internet, parse JSON, handle asynchronous operations, and build apps that connect to real-world data sources.

---

## Prerequisites

Before starting this module, students should be comfortable with:

- **Swift fundamentals** -- variables, data types, control flow, functions, optionals
- **Structs and classes** -- defining custom types, properties, and methods
- **SwiftUI basics** -- building simple views, using state, and displaying lists
- **Closures** -- basic understanding of closure syntax and callbacks
- **Xcode** -- creating projects, running in the simulator, using the debugger

---

## Key Concepts Covered

- What is an API? (REST, endpoints, HTTP methods)
- JSON format and structure
- Swift's `Codable` protocol for JSON parsing
- `URLSession` for making network requests
- Swift concurrency: `async` / `await`
- Error handling for network operations
- Displaying fetched data in SwiftUI
- API keys and basic authentication
- Rate limiting and responsible API usage

---

## 3-Week Lesson Outline

### Week 1: Understanding APIs and JSON

| Day | Topic | Activities |
|-----|-------|------------|
| 1 | What is an API? | Lecture: REST APIs, HTTP methods (GET, POST). Demo: Explore a public API in the browser. |
| 2 | JSON format | Hands-on: Read and write JSON by hand. Parse JSON mentally. Introduce `Codable`. |
| 3 | Swift `Codable` | Code-along: Define structs conforming to `Codable`. Decode sample JSON strings in a Playground. |
| 4 | Exploring public APIs | Lab: Students pick a free public API (weather, jokes, trivia) and examine its documentation and response format. |
| 5 | Review and mini-quiz | Quiz on HTTP methods, JSON structure, and `Codable`. Introduce the week 2 project. |

### Week 2: Making Network Requests

| Day | Topic | Activities |
|-----|-------|------------|
| 1 | `URLSession` basics | Code-along: Make a simple GET request, print the response. Discuss asynchronous execution. |
| 2 | `async` / `await` | Lecture: Swift concurrency model. Refactor the URLSession call to use async/await. |
| 3 | Error handling | Code-along: Handle network errors, invalid URLs, bad status codes, and decoding failures gracefully. |
| 4 | Displaying data in SwiftUI | Lab: Fetch data from a public API and display it in a SwiftUI `List`. Use `@State` and `.task`. |
| 5 | Images and caching | Code-along: Load remote images with `AsyncImage`. Discuss caching strategies. |

### Week 3: Building a Complete App

| Day | Topic | Activities |
|-----|-------|------------|
| 1 | Project kickoff | Students choose an API and plan their app (wireframes, data model, feature list). |
| 2 | API integration | Work session: Students implement API calls and data models for their chosen API. |
| 3 | UI implementation | Work session: Build the SwiftUI interface, connect it to live data. |
| 4 | Polish and edge cases | Handle loading states, empty states, and errors. Add search or filtering if time allows. |
| 5 | Presentations | Students demo their apps to the class. Peer feedback and discussion. |

---

## Suggested Public APIs for Student Projects

| API | Description | Auth Required? | Link |
|-----|-------------|----------------|------|
| OpenWeather | Current weather and forecasts | Free API key | [openweathermap.org](https://openweathermap.org/api) |
| PokéAPI | Pokemon data (species, abilities, etc.) | No | [pokeapi.co](https://pokeapi.co/) |
| Open Trivia DB | Trivia questions by category and difficulty | No | [opentdb.com](https://opentdb.com/) |
| NASA APOD | Astronomy Picture of the Day | Free API key | [api.nasa.gov](https://api.nasa.gov/) |
| The Dog API | Random dog images and breed info | No | [thedogapi.com](https://thedogapi.com/) |
| REST Countries | Country data (population, flags, languages) | No | [restcountries.com](https://restcountries.com/) |

---

## Resources

- [Apple Documentation: URLSession](https://developer.apple.com/documentation/foundation/urlsession)
- [Swift Concurrency](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)
- [Hacking with Swift: Networking](https://www.hackingwithswift.com/read/7/overview)
- See also the existing API tutorial in this repo for step-by-step guidance.

---

## Assessment

- **Week 1 Quiz** (10%) -- JSON and Codable concepts
- **Week 2 Lab** (30%) -- Working API fetch displayed in SwiftUI
- **Week 3 Project** (60%) -- Complete app using a public API, graded on functionality, code quality, UI, and presentation

See [Project Rubric Template](../Templates/Project-Rubric-Template.md) for grading criteria.
