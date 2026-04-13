# Week 4: Arrays, Dictionaries, and Sets

## Learning Objectives

By the end of this lesson, students will be able to:

1. Create and manipulate arrays (add, remove, access, iterate)
2. Create and use dictionaries with key-value pairs
3. Understand when to use a set and how it differs from an array
4. Apply common collection methods and properties (`count`, `isEmpty`, `contains`, `append`, `remove`)
5. Use `map`, `filter`, and `reduce` with closures on collections

---

## Warm-Up Activity (5 minutes)

**"Organize the Classroom"**

Give students three scenarios:

1. "I need a list of students in the order they sit." --> **Array** (ordered, duplicates allowed)
2. "I need to look up each student's grade by their name." --> **Dictionary** (key-value pairs)
3. "I need a list of unique lunch choices with no repeats." --> **Set** (unordered, no duplicates)

Ask: "Which container fits each scenario and why?"

---

## Lesson Content

### 1. Arrays (15 minutes)

An array stores an ordered list of values of the same type.

```swift
// Creating arrays
var fruits = ["Apple", "Banana", "Cherry"]
let numbers: [Int] = [10, 20, 30, 40, 50]
var emptyArray: [String] = []
```

#### Accessing Elements

```swift
print(fruits[0])       // "Apple"
print(fruits.first)    // Optional("Apple")
print(fruits.last)     // Optional("Cherry")
print(fruits.count)    // 3
```

#### Modifying Arrays

```swift
fruits.append("Date")                   // Add to end
fruits.insert("Elderberry", at: 1)      // Insert at index
fruits.remove(at: 0)                    // Remove at index
fruits.removeLast()                     // Remove last element
fruits += ["Fig", "Grape"]              // Concatenate
```

#### Iterating Over Arrays

```swift
for fruit in fruits {
    print(fruit)
}

// With index
for (index, fruit) in fruits.enumerated() {
    print("\(index): \(fruit)")
}
```

#### Useful Array Methods

```swift
let scores = [85, 92, 78, 95, 88]

print(scores.contains(92))       // true
print(scores.min()!)              // 78
print(scores.max()!)              // 95
print(scores.sorted())           // [78, 85, 88, 92, 95]
print(scores.reversed())         // reversed collection
```

### 2. Dictionaries (10 minutes)

A dictionary stores key-value pairs. Keys must be unique.

```swift
// Creating dictionaries
var studentGrades: [String: Int] = [
    "Alex": 92,
    "Jordan": 85,
    "Sam": 78
]

// Empty dictionary
var emptyDict: [String: String] = [:]
```

#### Accessing and Modifying

```swift
// Access (returns an optional)
if let grade = studentGrades["Alex"] {
    print("Alex's grade: \(grade)")
}

// Add or update
studentGrades["Taylor"] = 90     // Add new entry
studentGrades["Alex"] = 95       // Update existing

// Remove
studentGrades.removeValue(forKey: "Sam")
// or
studentGrades["Sam"] = nil
```

#### Iterating Over Dictionaries

```swift
for (name, grade) in studentGrades {
    print("\(name): \(grade)")
}

// Just keys or values
for name in studentGrades.keys {
    print(name)
}

for grade in studentGrades.values {
    print(grade)
}
```

### 3. Sets (5 minutes)

A set stores unique, unordered values.

```swift
var uniqueColors: Set<String> = ["Red", "Blue", "Green", "Red"]
print(uniqueColors)         // {"Blue", "Green", "Red"} -- no duplicate
print(uniqueColors.count)   // 3

uniqueColors.insert("Yellow")
uniqueColors.remove("Blue")
print(uniqueColors.contains("Green"))  // true
```

#### Set Operations

```swift
let setA: Set = [1, 2, 3, 4, 5]
let setB: Set = [4, 5, 6, 7, 8]

print(setA.union(setB))          // {1, 2, 3, 4, 5, 6, 7, 8}
print(setA.intersection(setB))   // {4, 5}
print(setA.subtracting(setB))    // {1, 2, 3}
```

### 4. Map, Filter, and Reduce (10 minutes)

These higher-order functions let you transform collections using closures.

#### Map -- Transform each element

```swift
let numbers = [1, 2, 3, 4, 5]
let doubled = numbers.map { $0 * 2 }
print(doubled)  // [2, 4, 6, 8, 10]

let names = ["alex", "jordan", "sam"]
let capitalized = names.map { $0.capitalized }
print(capitalized)  // ["Alex", "Jordan", "Sam"]
```

#### Filter -- Keep elements that match a condition

```swift
let scores = [85, 92, 78, 95, 62, 88]
let passing = scores.filter { $0 >= 80 }
print(passing)  // [85, 92, 95, 88]
```

#### Reduce -- Combine all elements into a single value

```swift
let numbers2 = [10, 20, 30, 40]
let total = numbers2.reduce(0) { $0 + $1 }
print(total)  // 100

// Shorter version
let total2 = numbers2.reduce(0, +)
print(total2)  // 100
```

#### Chaining

```swift
let scores2 = [85, 92, 78, 95, 62, 88]
let passingAverage = Double(scores2.filter { $0 >= 80 }.reduce(0, +)) / Double(scores2.filter { $0 >= 80 }.count)
print("Passing average: \(passingAverage)")
```

---

## Live Coding Demo (10 minutes)

Build a **"Class Roster Manager"** with the class.

1. Create an array of student names.
2. Create a dictionary mapping student names to their test scores.
3. Use `filter` to find students scoring above 85.
4. Use `map` to create an array of formatted strings like "Alex: A".
5. Use `reduce` to calculate the class average.

```swift
let students = ["Alex", "Jordan", "Sam", "Taylor", "Morgan"]
let scores: [String: Int] = [
    "Alex": 92, "Jordan": 85, "Sam": 78, "Taylor": 95, "Morgan": 68
]

// Find honor roll students (above 85)
let honorRoll = students.filter { scores[$0]! > 85 }
print("Honor Roll: \(honorRoll)")

// Create formatted grade reports
let reports = students.map { name -> String in
    let score = scores[name]!
    let letter = score >= 90 ? "A" : score >= 80 ? "B" : score >= 70 ? "C" : "D"
    return "\(name): \(letter) (\(score))"
}
reports.forEach { print($0) }

// Class average
let classAverage = Double(scores.values.reduce(0, +)) / Double(scores.count)
print("Class Average: \(classAverage)")
```

---

## Practice Exercises

### Easy

**Exercise 1: Favorite Foods**
Create an array of 5 favorite foods. Print the array, add 2 more items, remove one, and print the final list.

**Exercise 2: Phone Book**
Create a dictionary with 5 contacts (name: phone number). Look up a contact, add a new one, and print all contacts.

**Exercise 3: Unique Letters**
Given a string, create a set of all unique characters. Print how many unique characters there are.

### Medium

**Exercise 4: Word Counter**
Given a sentence as a `String`, split it into words and use a dictionary to count how many times each word appears.

**Exercise 5: Student Stats**
Given an array of test scores, use `map`, `filter`, and `reduce` to:
- Create a new array with 5 bonus points added to each score
- Filter to only passing scores (70+)
- Calculate the average of the passing scores

---

## Homework Assignment

**"Inventory Manager"**

Write a Swift program that simulates a simple store inventory:

1. Use a dictionary `[String: Int]` where keys are product names and values are quantities
2. Write a function `addProduct(name:quantity:)` that adds or updates inventory
3. Write a function `removeProduct(name:quantity:)` that decreases stock (do not allow negative stock)
4. Write a function `listLowStock(threshold:)` that uses `filter` to return items below a given quantity
5. Write a function `totalItems()` that uses `reduce` to return the total quantity of all items
6. Demonstrate all functions with sample data

**Due:** Beginning of Week 5.

---

## Teacher Notes

- **Common Misconception:** Students try to access dictionary values without handling optionals (e.g., `dict["key"]` returns `String?`, not `String`). This is a great bridge to Week 5's optionals lesson.
- **Pacing:** Arrays should get the most time since they are used most frequently. Sets can be covered briefly. `map`/`filter`/`reduce` are important but can be revisited in later weeks.
- **Index Out of Range:** This is the most common runtime crash students will encounter. Show what happens when you access `array[10]` on a 3-element array. Teach defensive practices like checking `count` first.
- **Differentiation:** Advanced students can explore `compactMap`, `flatMap`, and sorting dictionaries. Struggling students should focus on creating arrays, adding/removing elements, and basic `for-in` iteration.
- **Visual Aid:** Draw arrays as numbered boxes, dictionaries as two-column tables, and sets as circles (like Venn diagrams for set operations).
- **Connection to Previous Weeks:** `map`, `filter`, and `reduce` reinforce closures from Week 3. If students struggle, review closure syntax before proceeding.
