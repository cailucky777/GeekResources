# Week 3: Functions, Parameters, Return Values, and Intro to Closures

## Learning Objectives

By the end of this lesson, students will be able to:

1. Define and call functions with parameters and return values
2. Use argument labels, parameter names, and default parameter values
3. Explain variable scope (local vs. global)
4. Write functions that return tuples for multiple return values
5. Write simple closures and understand trailing closure syntax

---

## Warm-Up Activity (5 minutes)

**"Recipe Instructions"**

Ask students: "If you had to write instructions for making a sandwich, what would the steps be?" Write 3-4 steps on the board.

Then ask: "What if you wanted to make 10 sandwiches? Would you rewrite all the steps 10 times?" Introduce the idea that a function is like a named recipe you can reuse whenever you need it.

---

## Lesson Content

### 1. Defining and Calling Functions (10 minutes)

A function is a reusable block of code with a name.

```swift
func greet() {
    print("Hello, welcome to Swift class!")
}

// Call the function
greet()
greet()  // You can call it as many times as you want
```

#### Functions with Parameters

```swift
func greet(name: String) {
    print("Hello, \(name)!")
}

greet(name: "Alex")
greet(name: "Jordan")
```

#### Functions with Return Values

```swift
func add(a: Int, b: Int) -> Int {
    return a + b
}

let result = add(a: 5, b: 3)
print(result)  // 8
```

### 2. Argument Labels and Parameter Names (10 minutes)

Swift functions have both an argument label (used when calling) and a parameter name (used inside the function).

```swift
func greet(person name: String) {
    print("Hello, \(name)!")  // 'name' is used inside
}

greet(person: "Sam")  // 'person' is used when calling
```

Use `_` to omit the argument label:

```swift
func square(_ number: Int) -> Int {
    return number * number
}

print(square(5))  // No label needed when calling
```

#### Default Parameter Values

```swift
func greet(name: String, greeting: String = "Hello") {
    print("\(greeting), \(name)!")
}

greet(name: "Alex")                    // "Hello, Alex!"
greet(name: "Alex", greeting: "Hi")   // "Hi, Alex!"
```

### 3. Returning Multiple Values with Tuples (5 minutes)

```swift
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array {
        if value < currentMin { currentMin = value }
        if value > currentMax { currentMax = value }
    }
    return (currentMin, currentMax)
}

let result = minMax(array: [3, 1, 7, 2, 9])
print("Min: \(result.min), Max: \(result.max)")
```

### 4. Variable Scope (5 minutes)

Variables created inside a function only exist inside that function.

```swift
var globalMessage = "I'm available everywhere"

func showScope() {
    var localMessage = "I only exist in this function"
    print(globalMessage)   // OK
    print(localMessage)    // OK
}

showScope()
// print(localMessage)  // ERROR: localMessage is not in scope
```

### 5. Introduction to Closures (10 minutes)

A closure is a block of code that can be stored in a variable and passed around. Functions are actually a special case of closures.

```swift
// A simple closure stored in a variable
let sayHello = {
    print("Hello from a closure!")
}

sayHello()
```

#### Closures with Parameters and Return Values

```swift
let multiply = { (a: Int, b: Int) -> Int in
    return a * b
}

print(multiply(4, 5))  // 20
```

#### Passing Closures to Functions

```swift
let numbers = [5, 2, 8, 1, 9]

// Using a closure with the sorted function
let sortedNumbers = numbers.sorted(by: { (a: Int, b: Int) -> Bool in
    return a < b
})
print(sortedNumbers)  // [1, 2, 5, 8, 9]
```

#### Trailing Closure Syntax (Shorthand)

When the last parameter of a function is a closure, you can use trailing closure syntax:

```swift
let sortedNumbers = numbers.sorted { a, b in
    a < b
}

// Even shorter using shorthand argument names:
let sortedNumbers2 = numbers.sorted { $0 < $1 }
```

---

## Live Coding Demo (10 minutes)

Build a **"Math Toolkit"** with the class.

1. Write a function `add` that takes two `Double` values and returns their sum.
2. Write a function `average` that takes an array of `Double` and returns the average.
3. Write a function `applyOperation` that takes two numbers and a closure, then applies the closure.
4. Demonstrate calling `applyOperation` with different closures for add, subtract, multiply.

```swift
func add(_ a: Double, _ b: Double) -> Double {
    return a + b
}

func average(of numbers: [Double]) -> Double {
    var total = 0.0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

func applyOperation(_ a: Double, _ b: Double, operation: (Double, Double) -> Double) -> Double {
    return operation(a, b)
}

// Using the functions
print(add(3.5, 2.5))                              // 6.0
print(average(of: [90, 85, 92, 78, 88]))          // 86.6

print(applyOperation(10, 3, operation: { $0 + $1 }))  // 13.0
print(applyOperation(10, 3, operation: { $0 - $1 }))  // 7.0
print(applyOperation(10, 3, operation: { $0 * $1 }))  // 30.0
```

---

## Practice Exercises

### Easy

**Exercise 1: Greeting Function**
Write a function called `personalGreeting` that takes a `name` (String) and an `age` (Int) and prints "Hello, [name]! You are [age] years old."

**Exercise 2: Circle Calculator**
Write two functions: `circumference(radius:)` and `area(radius:)` that take a `Double` and return the circumference and area of a circle. Use `Double.pi`.

**Exercise 3: Repeat Printer**
Write a function `repeatPrint(message:times:)` that prints a message a given number of times.

### Medium

**Exercise 4: Password Validator**
Write a function `isValidPassword(_ password: String) -> Bool` that returns `true` if the password has at least 8 characters and contains at least one digit. (Hint: you can loop through characters.)

**Exercise 5: Closure Transformer**
Given an array of integers, use the `map` function with a closure to create a new array where each number is doubled. Then use `filter` with a closure to keep only values greater than 10.

---

## Homework Assignment

**"Function Library"**

Write a Swift program that contains:

1. A function `celsiusToFahrenheit(_ celsius: Double) -> Double`
2. A function `fahrenheitToCelsius(_ fahrenheit: Double) -> Double`
3. A function `convertTemperatures(_ temps: [Double], using converter: (Double) -> Double) -> [Double]` that takes an array and a closure to convert all values
4. Demonstrate calling all three functions, including passing `celsiusToFahrenheit` and `fahrenheitToCelsius` as closures to the third function

**Due:** Beginning of Week 4.

---

## Teacher Notes

- **Common Misconception:** Students often confuse argument labels with parameter names. Use the analogy: the label is what the "caller" sees, the parameter name is what the function "uses internally."
- **Closures Pacing:** Closures are the most challenging concept this week. It is perfectly fine to only cover basic closures (stored in a variable, simple `sorted` example) and save shorthand syntax for review in later weeks.
- **Scope Visualization:** Draw nested boxes on the board to show global scope containing function scope. This visual really helps.
- **Differentiation:** Advanced students can explore `inout` parameters and variadic parameters. Struggling students should focus on writing functions with one parameter and one return value.
- **Connection to Future Weeks:** Emphasize that closures will appear heavily in Week 4 (with `map`, `filter`, `reduce`) and throughout iOS development (completion handlers, SwiftUI).
- **Common Error:** Students will forget the `return` keyword or the `->` return type arrow. Remind them that single-expression functions can omit `return` in Swift.
