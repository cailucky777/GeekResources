# Week 1: Variables, Constants, and Data Types

## Learning Objectives

By the end of this lesson, students will be able to:

1. Declare variables using `var` and constants using `let`
2. Identify and use the four fundamental data types: `Int`, `Double`, `String`, `Bool`
3. Use string interpolation to embed values inside strings
4. Perform arithmetic operations and understand operator precedence
5. Explain why Swift is a type-safe language and what type inference means

---

## Warm-Up Activity (5 minutes)

**"Name That Type"**

Write the following values on the board and ask students to guess what kind of data each one represents:

- `42`
- `3.14`
- `"Hello, world!"`
- `true`
- `0`
- `"7"`

Discuss: Why might the computer treat `0` and `"0"` differently? Why does it matter?

---

## Lesson Content

### 1. What Is a Variable? (10 minutes)

A variable is a named container that stores a value. In Swift, we create variables with the `var` keyword.

```swift
var score = 0
score = 10  // We can change the value later
```

A constant is declared with `let` and cannot be changed after it is set.

```swift
let maximumScore = 100
// maximumScore = 200  // ERROR: Cannot assign to a 'let' constant
```

**Key Rule:** Use `let` by default. Only use `var` when you know the value needs to change. Xcode will even warn you if you use `var` but never modify the value.

### 2. Data Types (10 minutes)

Swift has several built-in types. The four most common are:

| Type | Description | Example |
|---|---|---|
| `Int` | Whole numbers | `42`, `-7`, `0` |
| `Double` | Decimal numbers | `3.14`, `-0.5`, `100.0` |
| `String` | Text | `"Hello"`, `"Swift"` |
| `Bool` | True or false | `true`, `false` |

#### Type Annotation vs. Type Inference

Swift can figure out the type automatically (type inference):

```swift
var age = 15          // Swift infers Int
var temperature = 72.5 // Swift infers Double
var name = "Alex"      // Swift infers String
var isStudent = true   // Swift infers Bool
```

You can also state the type explicitly (type annotation):

```swift
var age: Int = 15
var temperature: Double = 72.5
var name: String = "Alex"
var isStudent: Bool = true
```

### 3. String Interpolation (5 minutes)

String interpolation lets you insert values into a string using `\()`:

```swift
let name = "Jordan"
let age = 14
let greeting = "My name is \(name) and I am \(age) years old."
print(greeting)
// Output: My name is Jordan and I am 14 years old.
```

You can put any expression inside the parentheses:

```swift
print("Next year I will be \(age + 1) years old.")
```

### 4. Arithmetic Operators (10 minutes)

```swift
let a = 10
let b = 3

print(a + b)   // 13  (addition)
print(a - b)   // 7   (subtraction)
print(a * b)   // 30  (multiplication)
print(a / b)   // 3   (integer division -- no decimals!)
print(a % b)   // 1   (remainder / modulo)
```

**Watch out for integer division!**

```swift
let x = 10
let y = 3
print(x / y)  // Prints 3, not 3.333...

let xDouble = 10.0
let yDouble = 3.0
print(xDouble / yDouble)  // Prints 3.333...
```

### 5. Type Safety (5 minutes)

Swift does not let you mix types without being explicit:

```swift
let wholeNumber = 5       // Int
let decimalNumber = 2.5   // Double

// let sum = wholeNumber + decimalNumber  // ERROR: cannot add Int and Double
let sum = Double(wholeNumber) + decimalNumber  // OK: 7.5
```

---

## Live Coding Demo (10 minutes)

Open a Swift Playground and build a **"Student ID Card"** step by step with the class.

1. Declare constants for `firstName`, `lastName`, `gradeLevel`, and `gpa`.
2. Declare a variable for `absences` (this can change).
3. Use string interpolation to print a formatted ID card.
4. Update `absences` and print again.
5. Try changing a `let` constant and observe the compiler error.

```swift
let firstName = "Sam"
let lastName = "Rivera"
let gradeLevel = 9
var gpa = 3.7
var absences = 2

print("===== STUDENT ID =====")
print("Name: \(firstName) \(lastName)")
print("Grade: \(gradeLevel)")
print("GPA: \(gpa)")
print("Absences: \(absences)")
print("======================")

absences = 3
print("\nUpdated absences: \(absences)")
```

---

## Practice Exercises

### Easy

**Exercise 1: Personal Info**
Declare constants for your name, age, and favorite color. Print a sentence using string interpolation that includes all three.

**Exercise 2: Temperature Converter**
Declare a constant `celsius` set to `30.0`. Calculate Fahrenheit using the formula `F = C * 9/5 + 32` and print the result with a descriptive message.

**Exercise 3: Rectangle Area**
Declare constants `width` and `height` with values of your choice. Calculate and print the area and perimeter.

### Medium

**Exercise 4: Swap Values**
Declare two variables `a` and `b` with different integer values. Swap their values without using a temporary variable (hint: use tuples or arithmetic).

**Exercise 5: Time Breakdown**
Given a total number of seconds (e.g., `3661`), calculate and print the equivalent hours, minutes, and remaining seconds. Use integer division and the modulo operator.

---

## Homework Assignment

**"All About Me" Program**

Write a Swift program that:

1. Declares at least 5 constants and 2 variables about yourself (name, age, favorite subject, hours of sleep, etc.)
2. Performs at least 2 calculations (e.g., hours of sleep per week, days until your next birthday)
3. Prints a nicely formatted summary using string interpolation (at least 5 `print` statements)
4. Includes at least one example of changing a variable's value and printing before and after

**Due:** Beginning of Week 2.

---

## Teacher Notes

- **Common Misconception:** Students often try to use `var` for everything. Reinforce the habit of defaulting to `let`. Xcode warnings help here.
- **Pacing:** The type safety section can be brief if students are grasping concepts quickly. Spend extra time on string interpolation if needed -- it is used constantly going forward.
- **Differentiation:** Advanced students can explore `UInt`, `Float`, `Character`, and multi-line strings (`"""`). Struggling students should focus on `var` vs. `let` and basic `print` statements.
- **Playground Tips:** If Playgrounds are slow, have students use `print()` and check the console instead of relying on the sidebar results view.
- **Assessment:** Walk around during practice exercises and check for correct use of `let` vs. `var`. This is the most important habit to build in Week 1.
