// =============================================================
// Demo 01: Simple Calculator
// Module: Swift Fundamentals
// Topics: Variables, constants, operators, functions, type conversion
//
// TEACHER NOTES:
// - Walk through this file top to bottom with the class.
// - Pause at each section header to explain the concept.
// - Encourage students to predict the output before running each print().
// - After the walkthrough, challenge students to add new operations
//   (e.g., power, square root) on their own.
// =============================================================

import Foundation

// -------------------------------------------------------------
// SECTION 1: Constants and Variables
// TEACHER: Explain that 'let' is for values that never change,
// and 'var' is for values that will be updated.
// -------------------------------------------------------------

let calculatorName = "SwiftCalc"   // This will never change
var lastResult: Double = 0.0       // This will be updated after each calculation

print("Welcome to \(calculatorName)!")
print("----------------------------")

// -------------------------------------------------------------
// SECTION 2: Basic Arithmetic with Functions
// TEACHER: Show how functions encapsulate reusable operations.
// Point out the argument labels, parameter names, and return types.
// -------------------------------------------------------------

/// Adds two numbers and returns the result.
func add(_ a: Double, _ b: Double) -> Double {
    return a + b
}

/// Subtracts the second number from the first.
func subtract(_ a: Double, _ b: Double) -> Double {
    return a - b
}

/// Multiplies two numbers.
func multiply(_ a: Double, _ b: Double) -> Double {
    return a * b
}

/// Divides the first number by the second.
/// Returns nil if the divisor is zero (division by zero is undefined).
/// TEACHER: This is a great preview of optionals -- the function
/// returns Double? because the operation might not be valid.
func divide(_ a: Double, _ b: Double) -> Double? {
    if b == 0 {
        return nil  // Cannot divide by zero
    }
    return a / b
}

/// Returns the remainder of dividing a by b (modulo operation).
/// Works with integers only.
func remainder(_ a: Int, _ b: Int) -> Int {
    return a % b
}

// -------------------------------------------------------------
// SECTION 3: Using the Calculator Functions
// TEACHER: Walk through each call. Ask students to predict
// the result before you run the code.
// -------------------------------------------------------------

print("\n--- Basic Operations ---")

lastResult = add(15, 7)
print("15 + 7 = \(lastResult)")

lastResult = subtract(20, 8.5)
print("20 - 8.5 = \(lastResult)")

lastResult = multiply(6, 7)
print("6 x 7 = \(lastResult)")

// TEACHER: Show how we handle the optional return value safely.
if let result = divide(100, 4) {
    lastResult = result
    print("100 / 4 = \(lastResult)")
} else {
    print("Cannot divide by zero!")
}

// TEACHER: Now try dividing by zero -- what happens?
if let result = divide(50, 0) {
    print("50 / 0 = \(result)")
} else {
    print("50 / 0 = Error! Cannot divide by zero.")
}

print("7 % 3 = \(remainder(7, 3))")  // Remainder: 1

// -------------------------------------------------------------
// SECTION 4: Chaining Operations
// TEACHER: Show how the result of one function becomes
// the input to another. This demonstrates composition.
// -------------------------------------------------------------

print("\n--- Chained Operations ---")

// Calculate: (10 + 5) * 3
let step1 = add(10, 5)
let step2 = multiply(step1, 3)
print("(10 + 5) * 3 = \(step2)")

// Calculate the average of three numbers
let num1 = 85.0
let num2 = 92.0
let num3 = 78.0
let sum = add(add(num1, num2), num3)
if let average = divide(sum, 3) {
    print("Average of \(num1), \(num2), \(num3) = \(average)")
}

// -------------------------------------------------------------
// SECTION 5: Type Conversion
// TEACHER: Demonstrate that Swift does not allow mixing Int
// and Double without explicit conversion. This is type safety.
// -------------------------------------------------------------

print("\n--- Type Conversion ---")

let wholeNumber: Int = 7
let decimalNumber: Double = 2.5

// This would cause an error:
// let badSum = wholeNumber + decimalNumber

// You must convert explicitly:
let goodSum = Double(wholeNumber) + decimalNumber
print("\(wholeNumber) + \(decimalNumber) = \(goodSum)")

// Converting Double to Int truncates (does not round):
let truncated = Int(9.99)
print("Int(9.99) = \(truncated)")  // 9, not 10

// -------------------------------------------------------------
// SECTION 6: A Simple Calculation History
// TEACHER: This section previews arrays (Week 4). You can skip
// this in Week 1 and revisit it later, or use it as a teaser.
// -------------------------------------------------------------

print("\n--- Calculation History ---")

var history: [String] = []

func calculate(_ a: Double, _ operation: String, _ b: Double) -> Double? {
    var result: Double?

    switch operation {
    case "+":
        result = add(a, b)
    case "-":
        result = subtract(a, b)
    case "*":
        result = multiply(a, b)
    case "/":
        result = divide(a, b)
    default:
        print("Unknown operation: \(operation)")
        return nil
    }

    if let r = result {
        let entry = "\(a) \(operation) \(b) = \(r)"
        history.append(entry)
        return r
    }
    return nil
}

_ = calculate(25, "+", 17)
_ = calculate(100, "-", 33)
_ = calculate(8, "*", 12)
_ = calculate(144, "/", 12)
_ = calculate(10, "/", 0)

print("History:")
for (index, entry) in history.enumerated() {
    print("  \(index + 1). \(entry)")
}

// =============================================================
// CHALLENGE FOR STUDENTS:
// 1. Add a power function: power(base, exponent)
// 2. Add a square root function using Foundation's sqrt()
// 3. Add a percentage function: whatPercent(part, whole)
// 4. Make the calculate() function support your new operations
// =============================================================
