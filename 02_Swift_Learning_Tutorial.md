# Swift Learning Tutorial: From Beginner to Advanced

A comprehensive, structured guide to learning Swift programming, organized from easy to hard with curated resources updated for 2024 and beyond.

---

## Table of Contents

1. [Learning Roadmap Overview](#learning-roadmap-overview)
2. [Phase 1: Getting Started — Swift Fundamentals](#phase-1-getting-started--swift-fundamentals)
3. [Phase 2: Intermediate Swift — Building Real Skills](#phase-2-intermediate-swift--building-real-skills)
4. [Phase 3: SwiftUI — Modern App Development](#phase-3-swiftui--modern-app-development)
5. [Phase 4: Advanced Swift — Deep Mastery](#phase-4-advanced-swift--deep-mastery)
6. [Phase 5: Competitive Programming with Swift](#phase-5-competitive-programming-with-swift)
7. [Recommended Learning Schedule](#recommended-learning-schedule)
8. [Complete Resource Directory](#complete-resource-directory)

---

## Learning Roadmap Overview

```
Phase 1: Fundamentals (Weeks 1–3)
  ├── Variables, Constants, Types
  ├── Control Flow (if/else, switch, loops)
  ├── Functions and Closures
  ├── Optionals
  └── Collections (Arrays, Dictionaries, Sets)

Phase 2: Intermediate (Weeks 4–6)
  ├── Structs, Classes, Enums
  ├── Protocols and Extensions
  ├── Error Handling
  ├── Generics
  └── Memory Management (ARC)

Phase 3: SwiftUI (Weeks 7–10)
  ├── Views and Modifiers
  ├── State Management
  ├── Navigation
  ├── Data Flow
  └── Animations and Custom Components

Phase 4: Advanced (Weeks 11–14)
  ├── Concurrency (async/await, actors)
  ├── Swift Macros
  ├── Performance Optimization
  ├── Design Patterns
  └── Testing

Phase 5: Competitive Programming (Ongoing)
  ├── Algorithm Design in Swift
  ├── Data Structures
  └── Contest Practice
```

---

## Phase 1: Getting Started — Swift Fundamentals

### 1.1 Setting Up Your Environment

Before writing any Swift code, set up your development environment:

- **Mac Users:** Install Xcode (see the Installation Guide) or use Swift Playgrounds.
- **Online Practice:** Use [swiftfiddle.com](https://swiftfiddle.com) for quick experiments.

### 1.2 Your First Swift Program

```swift
// Hello, World!
print("Hello, World!")
```

Open Swift Playgrounds or create a new Xcode Playground (`File > New > Playground`) and type the code above. Press the play button to see the output.

### 1.3 Variables and Constants

```swift
// Variables (can change)
var greeting = "Hello"
greeting = "Hi there"

// Constants (cannot change)
let name = "Swift"
// name = "Other"  // ERROR: Cannot assign to 'let' constant

// Type Annotations
var age: Int = 25
var temperature: Double = 36.6
var isStudent: Bool = true
var initial: Character = "S"
```

**Key Concepts:**
- Use `let` whenever possible (immutability is preferred in Swift).
- Swift uses **type inference** — you don't always need to specify types.
- Swift is **type-safe** — you cannot mix types without explicit conversion.

### 1.4 Basic Data Types

| Type | Description | Example |
|---|---|---|
| `Int` | Whole numbers | `42`, `-7` |
| `Double` | Decimal numbers (64-bit) | `3.14159` |
| `Float` | Decimal numbers (32-bit) | `3.14` |
| `String` | Text | `"Hello"` |
| `Bool` | True/False | `true`, `false` |
| `Character` | Single character | `"A"` |

### 1.5 String Interpolation

```swift
let name = "Alice"
let age = 28
let message = "My name is \(name) and I am \(age) years old."
print(message)  // "My name is Alice and I am 28 years old."

// Multi-line strings
let poem = """
Roses are red,
Violets are blue,
Swift is amazing,
And so are you.
"""
```

### 1.6 Control Flow

```swift
// If-Else
let score = 85
if score >= 90 {
    print("A")
} else if score >= 80 {
    print("B")
} else {
    print("C")
}

// Switch (powerful in Swift!)
let day = "Monday"
switch day {
case "Monday", "Tuesday", "Wednesday", "Thursday", "Friday":
    print("Weekday")
case "Saturday", "Sunday":
    print("Weekend")
default:
    print("Unknown day")
}

// For loops
for i in 1...5 {
    print(i)  // 1, 2, 3, 4, 5
}

for i in 1..<5 {
    print(i)  // 1, 2, 3, 4
}

// While loops
var count = 3
while count > 0 {
    print(count)
    count -= 1
}
```

### 1.7 Collections

```swift
// Arrays
var fruits = ["Apple", "Banana", "Cherry"]
fruits.append("Date")
print(fruits[0])  // "Apple"
print(fruits.count)  // 4

// Dictionaries
var ages: [String: Int] = ["Alice": 28, "Bob": 32]
ages["Charlie"] = 25
print(ages["Alice"] ?? 0)  // 28

// Sets
var colors: Set<String> = ["Red", "Green", "Blue"]
colors.insert("Yellow")
print(colors.contains("Red"))  // true
```

### 1.8 Functions

```swift
// Basic function
func greet(name: String) -> String {
    return "Hello, \(name)!"
}
print(greet(name: "World"))

// Multiple parameters with argument labels
func divide(_ dividend: Double, by divisor: Double) -> Double {
    return dividend / divisor
}
print(divide(10, by: 3))  // 3.333...

// Default parameter values
func power(base: Int, exponent: Int = 2) -> Int {
    var result = 1
    for _ in 0..<exponent {
        result *= base
    }
    return result
}
print(power(base: 5))         // 25 (default exponent = 2)
print(power(base: 2, exponent: 10))  // 1024
```

### 1.9 Optionals

Optionals are one of Swift's most important features — they represent values that might be absent.

```swift
// Declaring optionals
var middleName: String? = nil
middleName = "James"

// Optional binding (safe unwrapping)
if let name = middleName {
    print("Middle name is \(name)")
} else {
    print("No middle name")
}

// Guard statement (early exit)
func processName(_ name: String?) {
    guard let unwrapped = name else {
        print("Name is nil, exiting")
        return
    }
    print("Processing: \(unwrapped)")
}

// Nil coalescing operator
let displayName = middleName ?? "Unknown"

// Optional chaining
let uppercased = middleName?.uppercased()  // Optional("JAMES")
```

### 1.10 Closures

```swift
// Basic closure
let add = { (a: Int, b: Int) -> Int in
    return a + b
}
print(add(3, 5))  // 8

// Closures with collection methods
let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// Filter: keep only even numbers
let evens = numbers.filter { $0 % 2 == 0 }
print(evens)  // [2, 4, 6, 8, 10]

// Map: transform each element
let doubled = numbers.map { $0 * 2 }
print(doubled)  // [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

// Reduce: combine all elements
let sum = numbers.reduce(0) { $0 + $1 }
print(sum)  // 55

// Sorted
let sorted = numbers.sorted { $0 > $1 }
print(sorted)  // [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
```

### Phase 1 Resources

| Resource | Type | Difficulty | Link |
|---|---|---|---|
| **Codecademy: Learn Swift** | Interactive Course | Beginner | [codecademy.com/learn/learn-swift](https://www.codecademy.com/learn/learn-swift) |
| **Swift by Sundell: Basics** | Articles + Examples | Beginner | [swiftbysundell.com/basics/#filter](https://www.swiftbysundell.com/basics/#filter) |
| **100 Days of SwiftUI (Days 1–14)** | Daily Tutorial | Beginner | [hackingwithswift.com/100/swiftui/2](https://www.hackingwithswift.com/100/swiftui/2) |
| **Apple: A Swift Tour** | Official Guide | Beginner | [docs.swift.org/swift-book/documentation/the-swift-programming-language/guidedtour](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/guidedtour) |
| **Swift Playgrounds App** | Interactive App | Beginner | Built into macOS / iPadOS |

### Phase 1 Exercises

1. Create a temperature converter (Fahrenheit to Celsius and back).
2. Build a simple calculator that handles +, -, *, / using a switch statement.
3. Write a function that checks if a string is a palindrome.
4. Create an array of student names and use `filter`, `map`, and `sorted` to process them.
5. Write a function that safely unwraps nested optionals (e.g., a dictionary of arrays).

---

## Phase 2: Intermediate Swift — Building Real Skills

### 2.1 Structs and Classes

```swift
// Struct (value type — preferred in Swift)
struct Point {
    var x: Double
    var y: Double

    func distanceTo(_ other: Point) -> Double {
        let dx = x - other.x
        let dy = y - other.y
        return (dx * dx + dy * dy).squareRoot()
    }

    mutating func moveBy(dx: Double, dy: Double) {
        x += dx
        y += dy
    }
}

var p1 = Point(x: 0, y: 0)
let p2 = Point(x: 3, y: 4)
print(p1.distanceTo(p2))  // 5.0

// Class (reference type — use when identity matters)
class Vehicle {
    var make: String
    var model: String
    var year: Int

    init(make: String, model: String, year: Int) {
        self.make = make
        self.model = model
        self.year = year
    }

    func description() -> String {
        return "\(year) \(make) \(model)"
    }
}

let car = Vehicle(make: "Tesla", model: "Model 3", year: 2024)
print(car.description())
```

**When to use Struct vs Class:**
- **Structs:** Default choice. Value semantics, thread-safe, no inheritance needed.
- **Classes:** When you need reference semantics, inheritance, or identity (`===`).

### 2.2 Enumerations

```swift
// Basic enum
enum Direction {
    case north, south, east, west
}

// Enum with associated values
enum NetworkResult {
    case success(data: Data, statusCode: Int)
    case failure(error: String)
}

let result = NetworkResult.success(data: Data(), statusCode: 200)

switch result {
case .success(let data, let statusCode):
    print("Success with code \(statusCode), data size: \(data.count)")
case .failure(let error):
    print("Failed: \(error)")
}

// Enum with raw values
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

print(Planet.earth.rawValue)  // 3
```

### 2.3 Protocols

```swift
// Define a protocol
protocol Drawable {
    var color: String { get set }
    func draw()
}

protocol Resizable {
    func resize(by factor: Double)
}

// Conform to protocols
struct Circle: Drawable, Resizable {
    var color: String
    var radius: Double

    func draw() {
        print("Drawing a \(color) circle with radius \(radius)")
    }

    func resize(by factor: Double) -> Void {
        // Note: Would need 'mutating' to actually change self
        print("Resizing by factor \(factor)")
    }
}

// Protocol extensions (default implementations)
extension Drawable {
    func erase() {
        print("Erasing the \(color) shape")
    }
}

let circle = Circle(color: "red", radius: 5.0)
circle.draw()
circle.erase()  // Uses default implementation
```

### 2.4 Extensions

```swift
// Add functionality to existing types
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }

    func times(_ action: () -> Void) {
        for _ in 0..<self {
            action()
        }
    }
}

print(42.isEven)  // true

3.times {
    print("Hello!")  // Prints "Hello!" three times
}

// Extend String
extension String {
    var wordCount: Int {
        return self.split(separator: " ").count
    }

    func truncated(to length: Int) -> String {
        if self.count <= length { return self }
        return String(self.prefix(length)) + "..."
    }
}

print("Hello World".wordCount)  // 2
print("This is a long sentence".truncated(to: 10))  // "This is a ..."
```

### 2.5 Error Handling

```swift
// Define errors
enum ValidationError: Error {
    case tooShort(minimum: Int)
    case tooLong(maximum: Int)
    case invalidCharacters(found: String)
}

// Throwing function
func validateUsername(_ username: String) throws -> String {
    guard username.count >= 3 else {
        throw ValidationError.tooShort(minimum: 3)
    }
    guard username.count <= 20 else {
        throw ValidationError.tooLong(maximum: 20)
    }
    let invalidChars = username.filter { !$0.isLetter && !$0.isNumber }
    guard invalidChars.isEmpty else {
        throw ValidationError.invalidCharacters(found: String(invalidChars))
    }
    return username
}

// Handling errors
do {
    let valid = try validateUsername("ab")
    print("Valid username: \(valid)")
} catch ValidationError.tooShort(let min) {
    print("Username must be at least \(min) characters")
} catch ValidationError.invalidCharacters(let chars) {
    print("Invalid characters found: \(chars)")
} catch {
    print("Unknown error: \(error)")
}

// try? — returns nil on error
let result = try? validateUsername("Alice123")  // Optional("Alice123")

// try! — crashes on error (use only when you're certain it won't fail)
// let result = try! validateUsername("valid")
```

### 2.6 Generics

```swift
// Generic function
func swapValues<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

var x = 5, y = 10
swapValues(&x, &y)
print(x, y)  // 10, 5

// Generic type
struct Stack<Element> {
    private var items: [Element] = []

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element? {
        return items.isEmpty ? nil : items.removeLast()
    }

    var top: Element? {
        return items.last
    }

    var isEmpty: Bool {
        return items.isEmpty
    }

    var count: Int {
        return items.count
    }
}

var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
print(stack.pop()!)  // 3

// Generic constraints
func findIndex<T: Equatable>(of target: T, in array: [T]) -> Int? {
    for (index, element) in array.enumerated() {
        if element == target {
            return index
        }
    }
    return nil
}

print(findIndex(of: "b", in: ["a", "b", "c"])!)  // 1
```

### 2.7 Memory Management (ARC)

```swift
// ARC (Automatic Reference Counting) manages memory for classes

class Person {
    let name: String
    var apartment: Apartment?

    init(name: String) {
        self.name = name
        print("\(name) is initialized")
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    weak var tenant: Person?  // 'weak' prevents retain cycle

    init(unit: String) {
        self.unit = unit
    }

    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

// Without 'weak', this would create a retain cycle (memory leak)
var john: Person? = Person(name: "John")
var apt: Apartment? = Apartment(unit: "4A")
john?.apartment = apt
apt?.tenant = john
john = nil  // John is deinitialized (because 'tenant' is weak)
apt = nil   // Apartment 4A is deinitialized
```

### Phase 2 Resources

| Resource | Type | Difficulty | Link |
|---|---|---|---|
| **Swift by Sundell** | Articles & Tutorials | Intermediate | [swiftbysundell.com/basics/](https://www.swiftbysundell.com/basics/#filter) |
| **100 Days of SwiftUI (Days 15–30)** | Daily Tutorial | Intermediate | [hackingwithswift.com/100/swiftui](https://www.hackingwithswift.com/100/swiftui/2) |
| **The Swift Programming Language (Book)** | Official Reference | Intermediate | [docs.swift.org/swift-book](https://docs.swift.org/swift-book/) |
| **Codecademy: Learn Swift** | Interactive Course | Beginner–Intermediate | [codecademy.com/learn/learn-swift](https://www.codecademy.com/learn/learn-swift) |

### Phase 2 Exercises

1. Create a `LinkedList` generic struct with insert, delete, and search operations.
2. Build a simple contact book using structs, protocols, and error handling.
3. Implement a `Result` type from scratch using enums with associated values.
4. Write a protocol-oriented shape hierarchy (Shape > Polygon > Rectangle, Triangle).
5. Build a mini JSON parser that uses enums and generics.

---

## Phase 3: SwiftUI — Modern App Development

### 3.1 Introduction to SwiftUI

SwiftUI is Apple's modern declarative UI framework. Instead of describing *how* to build the UI step by step, you describe *what* the UI should look like.

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, SwiftUI!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.blue)

            Image(systemName: "star.fill")
                .font(.system(size: 50))
                .foregroundStyle(.yellow)

            Button("Tap Me") {
                print("Button tapped!")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
```

### 3.2 State Management

```swift
struct CounterView: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(count)")
                .font(.title)

            HStack(spacing: 20) {
                Button("Decrease") { count -= 1 }
                    .buttonStyle(.bordered)
                Button("Increase") { count += 1 }
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}
```

**Property Wrappers for State:**
- `@State` — Local state for a single view.
- `@Binding` — Two-way connection to a parent view's state.
- `@ObservedObject` / `@StateObject` — For reference-type model objects.
- `@EnvironmentObject` — Shared data across the view hierarchy.
- `@Environment` — Access system-provided values (color scheme, locale, etc.).

### 3.3 Lists and Navigation

```swift
struct Contact: Identifiable {
    let id = UUID()
    let name: String
    let email: String
}

struct ContactListView: View {
    let contacts = [
        Contact(name: "Alice", email: "alice@example.com"),
        Contact(name: "Bob", email: "bob@example.com"),
        Contact(name: "Charlie", email: "charlie@example.com"),
    ]

    var body: some View {
        NavigationStack {
            List(contacts) { contact in
                NavigationLink(destination: ContactDetailView(contact: contact)) {
                    VStack(alignment: .leading) {
                        Text(contact.name)
                            .font(.headline)
                        Text(contact.email)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Contacts")
        }
    }
}

struct ContactDetailView: View {
    let contact: Contact

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 100))
                .foregroundStyle(.blue)
            Text(contact.name)
                .font(.largeTitle)
            Text(contact.email)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .navigationTitle(contact.name)
    }
}
```

### 3.4 Data Flow with Observable

```swift
import SwiftUI

// Using @Observable (Swift 5.9+, preferred modern approach)
@Observable
class TodoStore {
    var items: [TodoItem] = []

    func add(_ title: String) {
        items.append(TodoItem(title: title))
    }

    func toggle(_ item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }
}

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
}

struct TodoListView: View {
    @State private var store = TodoStore()
    @State private var newItemTitle = ""

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("New item", text: $newItemTitle)
                        .textFieldStyle(.roundedBorder)
                    Button("Add") {
                        guard !newItemTitle.isEmpty else { return }
                        store.add(newItemTitle)
                        newItemTitle = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()

                List(store.items) { item in
                    HStack {
                        Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundStyle(item.isCompleted ? .green : .gray)
                        Text(item.title)
                            .strikethrough(item.isCompleted)
                    }
                    .onTapGesture {
                        store.toggle(item)
                    }
                }
            }
            .navigationTitle("Todo List")
        }
    }
}
```

### 3.5 Animations

```swift
struct AnimationDemoView: View {
    @State private var isExpanded = false
    @State private var rotation: Double = 0

    var body: some View {
        VStack(spacing: 40) {
            // Implicit animation
            RoundedRectangle(cornerRadius: isExpanded ? 20 : 50)
                .fill(.blue.gradient)
                .frame(width: isExpanded ? 300 : 100,
                       height: isExpanded ? 300 : 100)
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: isExpanded)
                .onTapGesture {
                    isExpanded.toggle()
                }

            // Rotation animation
            Image(systemName: "gear")
                .font(.system(size: 50))
                .rotationEffect(.degrees(rotation))
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 1)) {
                        rotation += 360
                    }
                }

            Text("Tap the shapes!")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}
```

### Phase 3 Resources

| Resource | Type | Difficulty | Link |
|---|---|---|---|
| **Hacking with Swift: SwiftUI Quick Start** | Comprehensive Tutorial | Beginner–Intermediate | [hackingwithswift.com/quick-start/swiftui](https://www.hackingwithswift.com/quick-start/swiftui) |
| **100 Days of SwiftUI** | 100-Day Course | Beginner–Advanced | [hackingwithswift.com/100/swiftui/2](https://www.hackingwithswift.com/100/swiftui/2) |
| **Swift by Sundell** | Articles & Tutorials | Intermediate | [swiftbysundell.com/basics/](https://www.swiftbysundell.com/basics/#filter) |
| **Apple: SwiftUI Tutorials** | Official Tutorials | Beginner–Intermediate | [developer.apple.com/tutorials/swiftui](https://developer.apple.com/tutorials/swiftui) |

### Phase 3 Exercises

1. Build a weather app with a list of cities and detail views.
2. Create an animated onboarding flow with page transitions.
3. Build a note-taking app with CRUD operations using `@Observable`.
4. Implement a custom tab bar with animations.
5. Create a settings screen with toggles, sliders, and pickers that persist using `@AppStorage`.

---

## Phase 4: Advanced Swift — Deep Mastery

### 4.1 Concurrency (async/await)

```swift
// Modern Swift concurrency

// Async function
func fetchUser(id: Int) async throws -> User {
    let url = URL(string: "https://api.example.com/users/\(id)")!
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        throw NetworkError.invalidResponse
    }

    return try JSONDecoder().decode(User.self, from: data)
}

// Calling async functions
Task {
    do {
        let user = try await fetchUser(id: 1)
        print(user.name)
    } catch {
        print("Error: \(error)")
    }
}

// Concurrent execution with async let
func fetchDashboard() async throws -> Dashboard {
    async let user = fetchUser(id: 1)
    async let posts = fetchPosts(userId: 1)
    async let notifications = fetchNotifications()

    // All three run concurrently
    return try await Dashboard(
        user: user,
        posts: posts,
        notifications: notifications
    )
}

// TaskGroup for dynamic concurrency
func fetchAllUsers(ids: [Int]) async throws -> [User] {
    try await withThrowingTaskGroup(of: User.self) { group in
        for id in ids {
            group.addTask {
                try await fetchUser(id: id)
            }
        }

        var users: [User] = []
        for try await user in group {
            users.append(user)
        }
        return users
    }
}
```

### 4.2 Actors

```swift
// Actors protect mutable state from data races
actor BankAccount {
    let owner: String
    private(set) var balance: Double

    init(owner: String, balance: Double) {
        self.owner = owner
        self.balance = balance
    }

    func deposit(_ amount: Double) {
        balance += amount
    }

    func withdraw(_ amount: Double) throws {
        guard balance >= amount else {
            throw BankError.insufficientFunds
        }
        balance -= amount
    }
}

// Using actors
let account = BankAccount(owner: "Alice", balance: 1000)

Task {
    await account.deposit(500)
    let balance = await account.balance
    print("Balance: \(balance)")  // 1500
}
```

### 4.3 Swift Macros (Swift 5.9+)

```swift
// Using built-in macros
import Observation

@Observable
class UserSettings {
    var theme: String = "light"
    var fontSize: Int = 14
    var notificationsEnabled: Bool = true
}

// #Preview macro for SwiftUI
#Preview {
    ContentView()
}

#Preview("Dark Mode") {
    ContentView()
        .preferredColorScheme(.dark)
}
```

### 4.4 Advanced Protocols

```swift
// Protocol with associated types
protocol Repository {
    associatedtype Entity: Identifiable
    func findAll() async throws -> [Entity]
    func find(by id: Entity.ID) async throws -> Entity?
    func save(_ entity: Entity) async throws
    func delete(_ entity: Entity) async throws
}

// Type-erased wrapper using 'any' keyword (Swift 5.7+)
func printAll(_ repo: any Repository) async throws {
    let entities = try await repo.findAll()
    for entity in entities {
        print(entity)
    }
}

// Opaque return types with 'some'
func makeCollection() -> some Collection<Int> {
    return [1, 2, 3, 4, 5]
}
```

### 4.5 Property Wrappers

```swift
// Custom property wrapper
@propertyWrapper
struct Clamped<Value: Comparable> {
    private var value: Value
    let range: ClosedRange<Value>

    var wrappedValue: Value {
        get { value }
        set { value = min(max(newValue, range.lowerBound), range.upperBound) }
    }

    init(wrappedValue: Value, _ range: ClosedRange<Value>) {
        self.range = range
        self.value = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
}

struct PlayerStats {
    @Clamped(0...100) var health: Int = 100
    @Clamped(0...999) var score: Int = 0
}

var stats = PlayerStats()
stats.health = 150   // Clamped to 100
stats.health = -10   // Clamped to 0
print(stats.health)  // 0
```

### Phase 4 Resources

| Resource | Type | Difficulty | Link |
|---|---|---|---|
| **Swift by Sundell: Advanced** | Deep-dive Articles | Advanced | [swiftbysundell.com/basics/](https://www.swiftbysundell.com/basics/#filter) |
| **100 Days of SwiftUI (Days 60–100)** | Advanced Projects | Advanced | [hackingwithswift.com/100/swiftui/2](https://www.hackingwithswift.com/100/swiftui/2) |
| **Apple: Swift Concurrency** | Official Docs | Advanced | [developer.apple.com/documentation/swift/concurrency](https://developer.apple.com/documentation/swift/concurrency) |
| **WWDC Videos** | Conference Talks | All levels | [developer.apple.com/wwdc](https://developer.apple.com/wwdc) |

### Phase 4 Exercises

1. Build a concurrent image downloader using `TaskGroup`.
2. Create a thread-safe cache using an `actor`.
3. Implement a custom property wrapper `@UserDefault` for persistent settings.
4. Build a protocol-oriented networking layer with generics.
5. Write unit tests for all of the above.

---

## Phase 5: Competitive Programming with Swift

### 5.1 Why Swift for Competitive Programming?

- Fast execution (comparable to C++ for most problems)
- Clean, readable syntax
- Powerful standard library (sorted, filter, map, reduce)
- Strong typing catches errors at compile time

### 5.2 Input/Output in Swift

```swift
import Foundation

// Reading a single integer
let n = Int(readLine()!)!

// Reading an array of integers
let numbers = readLine()!.split(separator: " ").map { Int($0)! }

// Reading multiple lines
for _ in 0..<n {
    let line = readLine()!
    // process line
}

// Fast output
var output = ""
for i in 0..<n {
    output += "\(results[i])\n"
}
print(output, terminator: "")
```

### 5.3 Common Data Structures

```swift
// Priority Queue (Min-Heap) — implement your own
struct MinHeap<T: Comparable> {
    private var heap: [T] = []

    var isEmpty: Bool { heap.isEmpty }
    var count: Int { heap.count }
    var peek: T? { heap.first }

    mutating func insert(_ value: T) {
        heap.append(value)
        siftUp(from: heap.count - 1)
    }

    mutating func extractMin() -> T? {
        guard !heap.isEmpty else { return nil }
        if heap.count == 1 { return heap.removeLast() }
        let min = heap[0]
        heap[0] = heap.removeLast()
        siftDown(from: 0)
        return min
    }

    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = (child - 1) / 2
        while child > 0 && heap[child] < heap[parent] {
            heap.swapAt(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    private mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = 2 * parent + 1
            let right = 2 * parent + 2
            var smallest = parent
            if left < heap.count && heap[left] < heap[smallest] { smallest = left }
            if right < heap.count && heap[right] < heap[smallest] { smallest = right }
            if smallest == parent { break }
            heap.swapAt(parent, smallest)
            parent = smallest
        }
    }
}
```

### 5.4 Common Algorithms

```swift
// Binary Search
func binarySearch<T: Comparable>(_ array: [T], target: T) -> Int? {
    var low = 0
    var high = array.count - 1
    while low <= high {
        let mid = low + (high - low) / 2
        if array[mid] == target { return mid }
        else if array[mid] < target { low = mid + 1 }
        else { high = mid - 1 }
    }
    return nil
}

// BFS (Breadth-First Search)
func bfs(graph: [[Int]], start: Int) -> [Int] {
    var visited = Set<Int>()
    var queue = [start]
    var order: [Int] = []
    visited.insert(start)

    while !queue.isEmpty {
        let node = queue.removeFirst()
        order.append(node)
        for neighbor in graph[node] {
            if !visited.contains(neighbor) {
                visited.insert(neighbor)
                queue.append(neighbor)
            }
        }
    }
    return order
}

// Dynamic Programming — Longest Common Subsequence
func lcs(_ a: String, _ b: String) -> Int {
    let a = Array(a)
    let b = Array(b)
    let m = a.count, n = b.count
    var dp = Array(repeating: Array(repeating: 0, count: n + 1), count: m + 1)

    for i in 1...m {
        for j in 1...n {
            if a[i - 1] == b[j - 1] {
                dp[i][j] = dp[i - 1][j - 1] + 1
            } else {
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])
            }
        }
    }
    return dp[m][n]
}
```

### 5.5 Practice Platforms

| Platform | Description | Link |
|---|---|---|
| **CEMC (University of Waterloo)** | Canadian Computing Competition archives — great for practice | [cemc.uwaterloo.ca/resources/past-contests](https://cemc.uwaterloo.ca/resources/past-contests?grade=All&academic_year=All&contest_category=29) |
| **LeetCode** | Extensive problem library, Swift supported | [leetcode.com](https://leetcode.com) |
| **HackerRank** | Algorithms and data structure challenges | [hackerrank.com](https://hackerrank.com) |
| **Codeforces** | Competitive programming contests | [codeforces.com](https://codeforces.com) |

### Phase 5 Exercises

1. Solve 10 easy problems from CEMC past contests in Swift.
2. Implement Dijkstra's algorithm using your MinHeap.
3. Solve a dynamic programming problem (e.g., knapsack, coin change).
4. Participate in a LeetCode weekly contest using Swift.
5. Implement a trie (prefix tree) for string searching.

---

## Recommended Learning Schedule

| Week | Focus | Resources |
|---|---|---|
| **Week 1** | Swift basics: variables, types, control flow | Codecademy, Swift Playgrounds |
| **Week 2** | Functions, closures, optionals | Codecademy, 100 Days of SwiftUI (Days 1–7) |
| **Week 3** | Collections, string manipulation | Swift by Sundell Basics, practice problems |
| **Week 4** | Structs, classes, enums | 100 Days of SwiftUI (Days 8–14), Swift Book |
| **Week 5** | Protocols, extensions, generics | Swift by Sundell, Hacking with Swift |
| **Week 6** | Error handling, ARC | 100 Days of SwiftUI (Days 15–25) |
| **Week 7–8** | SwiftUI fundamentals | SwiftUI Quick Start Guide |
| **Week 9–10** | SwiftUI projects | 100 Days of SwiftUI (Days 26–50) |
| **Week 11–12** | Concurrency, advanced patterns | WWDC videos, Swift by Sundell |
| **Week 13–14** | Testing, architecture | 100 Days of SwiftUI (Days 50–100) |
| **Ongoing** | Competitive programming, advanced topics | CEMC, LeetCode |

---

## Complete Resource Directory

### Free Resources

| Resource | URL | Best For |
|---|---|---|
| Codecademy: Learn Swift | [codecademy.com/learn/learn-swift](https://www.codecademy.com/learn/learn-swift) | Complete beginners, interactive learning |
| Hacking with Swift: 100 Days of SwiftUI | [hackingwithswift.com/100/swiftui/2](https://www.hackingwithswift.com/100/swiftui/2) | Structured daily learning, projects |
| Hacking with Swift: SwiftUI Quick Start | [hackingwithswift.com/quick-start/swiftui](https://www.hackingwithswift.com/quick-start/swiftui) | Fast-track SwiftUI learning |
| Swift by Sundell: Basics | [swiftbysundell.com/basics/](https://www.swiftbysundell.com/basics/#filter) | In-depth concept explanations |
| Apple: The Swift Programming Language | [docs.swift.org/swift-book](https://docs.swift.org/swift-book/) | Official language reference |
| Apple: SwiftUI Tutorials | [developer.apple.com/tutorials/swiftui](https://developer.apple.com/tutorials/swiftui) | Official SwiftUI introduction |
| CEMC Past Contests | [cemc.uwaterloo.ca/resources/past-contests](https://cemc.uwaterloo.ca/resources/past-contests?grade=All&academic_year=All&contest_category=29) | Competitive programming practice |
| WWDC Session Videos | [developer.apple.com/wwdc](https://developer.apple.com/wwdc) | Latest Apple technologies |
| Swift Playgrounds | Built-in app on Mac/iPad | Interactive, gamified learning |

---

*Document generated on April 2026. All resources verified as active and updated for 2024+.*
