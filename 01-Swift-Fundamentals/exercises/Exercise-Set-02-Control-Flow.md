# Exercise Set 02: Control Flow

**Topics Covered:** `if`/`else if`/`else`, comparison and logical operators, `switch` statements, `for-in` loops, `while` loops, `repeat-while`, `break`, `continue`, ranges.

**Instructions:** Complete each exercise in a Swift Playground or Swift file. Test your code by running it and checking the output.

---

## Exercise 1: Ticket Price

Write a program that sets a constant `age` to a value of your choice. Using `if/else if/else`, print the ticket price based on these rules:
- Children (0-12): $8
- Teens (13-17): $12
- Adults (18-64): $15
- Seniors (65+): $10

---

## Exercise 2: Day of the Week

Declare a constant `dayNumber` as an `Int` (1-7). Use a `switch` statement to print the name of the day (1 = Monday, 7 = Sunday). Include a `default` case for invalid numbers.

---

## Exercise 3: Multiplication Table

Use a `for-in` loop to print the multiplication table for the number 7, from 1 to 12. Format each line like: `7 x 3 = 21`.

---

## Exercise 4: Sum of a Range

Use a `for-in` loop to calculate the sum of all integers from 1 to 100. Print the result. (The answer should be 5050.)

---

## Exercise 5: FizzBuzz

Print the numbers from 1 to 30. For each number:
- If divisible by 3, print "Fizz" instead of the number
- If divisible by 5, print "Buzz" instead of the number
- If divisible by both 3 and 5, print "FizzBuzz" instead of the number
- Otherwise, print the number itself

---

## Exercise 6: Countdown with While

Use a `while` loop to print a countdown from 10 to 1. After the loop, print "Liftoff!".

---

## Exercise 7: Skip the Unlucky Number

Use a `for-in` loop to print numbers from 1 to 20, but skip the number 13 using `continue`. Print a message when you skip it.

---

## Exercise 8: Grade Classifier with Switch

Declare a constant `score` (0-100). Use a `switch` statement with ranges to print the letter grade:
- 90-100: A
- 80-89: B
- 70-79: C
- 60-69: D
- Below 60: F

Also print "Excellent!" for A, "Good job!" for B, "Satisfactory" for C, "Needs improvement" for D, and "Please see the teacher" for F.

---

## Exercise 9: Find the First Multiple

Use a `while` loop to find the first number greater than 500 that is divisible by both 7 and 13. Print the number when found. Use `break` to exit the loop.

---

## Exercise 10: Pattern Printer

Use nested `for-in` loops to print the following triangle pattern:

```
*
**
***
****
*****
```

Then, as a bonus, print an inverted triangle:

```
*****
****
***
**
*
```

---

---

# Solutions

## Solution 1
```swift
let age = 15

if age >= 0 && age <= 12 {
    print("Ticket price: $8 (Child)")
} else if age >= 13 && age <= 17 {
    print("Ticket price: $12 (Teen)")
} else if age >= 18 && age <= 64 {
    print("Ticket price: $15 (Adult)")
} else if age >= 65 {
    print("Ticket price: $10 (Senior)")
} else {
    print("Invalid age.")
}
```

## Solution 2
```swift
let dayNumber = 3

switch dayNumber {
case 1:
    print("Monday")
case 2:
    print("Tuesday")
case 3:
    print("Wednesday")
case 4:
    print("Thursday")
case 5:
    print("Friday")
case 6:
    print("Saturday")
case 7:
    print("Sunday")
default:
    print("Invalid day number. Please enter 1-7.")
}
```

## Solution 3
```swift
let number = 7

for i in 1...12 {
    print("\(number) x \(i) = \(number * i)")
}
```

## Solution 4
```swift
var sum = 0

for i in 1...100 {
    sum += i
}

print("Sum of 1 to 100 = \(sum)")  // 5050
```

## Solution 5
```swift
for i in 1...30 {
    if i % 3 == 0 && i % 5 == 0 {
        print("FizzBuzz")
    } else if i % 3 == 0 {
        print("Fizz")
    } else if i % 5 == 0 {
        print("Buzz")
    } else {
        print(i)
    }
}
```

## Solution 6
```swift
var countdown = 10

while countdown >= 1 {
    print(countdown)
    countdown -= 1
}
print("Liftoff!")
```

## Solution 7
```swift
for i in 1...20 {
    if i == 13 {
        print("Skipping \(i) -- unlucky number!")
        continue
    }
    print(i)
}
```

## Solution 8
```swift
let score = 87

switch score {
case 90...100:
    print("Grade: A -- Excellent!")
case 80...89:
    print("Grade: B -- Good job!")
case 70...79:
    print("Grade: C -- Satisfactory")
case 60...69:
    print("Grade: D -- Needs improvement")
case 0..<60:
    print("Grade: F -- Please see the teacher")
default:
    print("Invalid score. Must be 0-100.")
}
```

## Solution 9
```swift
var number = 501

while true {
    if number % 7 == 0 && number % 13 == 0 {
        print("The first number > 500 divisible by both 7 and 13 is \(number)")
        break
    }
    number += 1
}
// Answer: 546
```

## Solution 10
```swift
// Triangle
let rows = 5

print("Triangle:")
for i in 1...rows {
    var line = ""
    for _ in 1...i {
        line += "*"
    }
    print(line)
}

// Inverted triangle
print("\nInverted triangle:")
for i in stride(from: rows, through: 1, by: -1) {
    var line = ""
    for _ in 1...i {
        line += "*"
    }
    print(line)
}

// Bonus: Shorter version using String(repeating:count:)
// print(String(repeating: "*", count: i))
```
