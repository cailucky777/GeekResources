# Exercise Set 01: Variables, Types, and Basic Operations

**Topics Covered:** Variables (`var`), constants (`let`), data types (`Int`, `Double`, `String`, `Bool`), string interpolation, arithmetic operators, type conversion.

**Instructions:** Complete each exercise in a Swift Playground or Swift file. Test your code by running it and checking the output.

---

## Exercise 1: Declare and Print

Declare the following constants and print each one:
- Your first name (String)
- Your age (Int)
- Your height in meters (Double)
- Whether you are a student (Bool)

**Expected output example:**
```
Name: Alex
Age: 15
Height: 1.65
Is a student: true
```

---

## Exercise 2: Variable vs. Constant

Declare a variable `currentTemperature` set to `72.0` and a constant `boilingPoint` set to `212.0`. Print both. Then change `currentTemperature` to `85.5` and print it again. Try to change `boilingPoint` and observe the error. Comment out the error line and write a comment explaining why it fails.

---

## Exercise 3: String Interpolation Message

Declare constants for a `city` (String), `population` (Int), and `area` (Double, in square miles). Use string interpolation to print:
```
The city of [city] has a population of [population] and covers [area] square miles.
```

---

## Exercise 4: Arithmetic Operations

Declare two constants: `a = 17` and `b = 5`. Print the result of each operation:
- Addition
- Subtraction
- Multiplication
- Integer division
- Remainder (modulo)

---

## Exercise 5: Temperature Converter

Declare a constant `fahrenheit` set to `98.6`. Convert it to Celsius using the formula `C = (F - 32) * 5 / 9`. Print the result with a message like: `98.6F is 37.0C`.

---

## Exercise 6: Type Conversion

Declare an `Int` constant `wholePart = 7` and a `Double` constant `decimalPart = 0.5`. Add them together (you will need a type conversion) and store the result in a new constant. Print the result.

---

## Exercise 7: Multi-line String

Create a multi-line string (using triple quotes `"""`) that displays a short poem or song lyric (at least 3 lines). Print it.

---

## Exercise 8: Days Alive Calculator

Declare a constant `ageInYears` with your age. Calculate the approximate number of days you have been alive (assume 365 days per year). Print a message like: `I am approximately [days] days old.`

---

## Exercise 9: Receipt Calculator

Declare constants for an item name (String), quantity (Int), and price per item (Double). Calculate the subtotal, tax (8.5%), and total. Print a formatted receipt:

```
Item: Widget
Quantity: 3
Price each: $12.50
Subtotal: $37.50
Tax (8.5%): $3.19
Total: $40.69
```

---

## Exercise 10: Swap Two Variables

Declare two variables `x = 10` and `y = 25`. Swap their values so that `x` is `25` and `y` is `10`. Print before and after. Try to do it without using a third variable (hint: use a tuple).

---

---

# Solutions

## Solution 1
```swift
let firstName = "Alex"
let age = 15
let height = 1.65
let isStudent = true

print("Name: \(firstName)")
print("Age: \(age)")
print("Height: \(height)")
print("Is a student: \(isStudent)")
```

## Solution 2
```swift
var currentTemperature = 72.0
let boilingPoint = 212.0

print("Current temperature: \(currentTemperature)")
print("Boiling point: \(boilingPoint)")

currentTemperature = 85.5
print("Updated temperature: \(currentTemperature)")

// boilingPoint = 300.0  // ERROR: Cannot assign to value: 'boilingPoint' is a 'let' constant
// This fails because 'let' declares a constant whose value cannot be changed after assignment.
```

## Solution 3
```swift
let city = "Springfield"
let population = 120000
let area = 85.7

print("The city of \(city) has a population of \(population) and covers \(area) square miles.")
```

## Solution 4
```swift
let a = 17
let b = 5

print("a + b = \(a + b)")   // 22
print("a - b = \(a - b)")   // 12
print("a * b = \(a * b)")   // 85
print("a / b = \(a / b)")   // 3 (integer division)
print("a % b = \(a % b)")   // 2
```

## Solution 5
```swift
let fahrenheit = 98.6
let celsius = (fahrenheit - 32) * 5 / 9
print("\(fahrenheit)F is \(String(format: "%.1f", celsius))C")
```

## Solution 6
```swift
let wholePart = 7
let decimalPart = 0.5
let result = Double(wholePart) + decimalPart
print(result)  // 7.5
```

## Solution 7
```swift
let poem = """
Roses are red,
Violets are blue,
Swift is fun,
And so are you!
"""
print(poem)
```

## Solution 8
```swift
let ageInYears = 15
let daysAlive = ageInYears * 365
print("I am approximately \(daysAlive) days old.")
```

## Solution 9
```swift
let itemName = "Widget"
let quantity = 3
let pricePerItem = 12.50

let subtotal = Double(quantity) * pricePerItem
let tax = subtotal * 0.085
let total = subtotal + tax

print("Item: \(itemName)")
print("Quantity: \(quantity)")
print("Price each: $\(String(format: "%.2f", pricePerItem))")
print("Subtotal: $\(String(format: "%.2f", subtotal))")
print("Tax (8.5%): $\(String(format: "%.2f", tax))")
print("Total: $\(String(format: "%.2f", total))")
```

## Solution 10
```swift
var x = 10
var y = 25

print("Before: x = \(x), y = \(y)")

// Swap using a tuple (no third variable needed)
(x, y) = (y, x)

print("After: x = \(x), y = \(y)")
```
