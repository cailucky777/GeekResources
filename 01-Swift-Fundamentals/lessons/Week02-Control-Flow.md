# Week 2: Control Flow

## Learning Objectives

By the end of this lesson, students will be able to:

1. Write conditional logic using `if`, `else if`, and `else`
2. Use comparison operators (`==`, `!=`, `<`, `>`, `<=`, `>=`) and logical operators (`&&`, `||`, `!`)
3. Apply `switch` statements for clean multi-case branching
4. Iterate using `for-in` loops over ranges and collections
5. Use `while` and `repeat-while` loops for condition-based iteration

---

## Warm-Up Activity (5 minutes)

**"Choose Your Path"**

Draw a simple flowchart on the board:

```
Is it raining?
  YES --> Bring an umbrella
  NO  --> Wear sunglasses
```

Ask students: "What decisions did you already make today before coming to class?" Collect 3-4 examples and sketch quick flowcharts. Explain that programs make decisions the same way.

---

## Lesson Content

### 1. If / Else If / Else (10 minutes)

The `if` statement runs code only when a condition is `true`.

```swift
let temperature = 85

if temperature > 90 {
    print("It's really hot! Stay hydrated.")
} else if temperature > 70 {
    print("Nice weather outside.")
} else if temperature > 50 {
    print("It's a bit cool. Bring a jacket.")
} else {
    print("It's cold! Bundle up.")
}
```

#### Comparison Operators

| Operator | Meaning |
|---|---|
| `==` | Equal to |
| `!=` | Not equal to |
| `<` | Less than |
| `>` | Greater than |
| `<=` | Less than or equal to |
| `>=` | Greater than or equal to |

#### Logical Operators

```swift
let age = 16
let hasPermission = true

if age >= 16 && hasPermission {
    print("You can drive.")
}

if age < 13 || age > 65 {
    print("You get a discount.")
}

if !hasPermission {
    print("Permission denied.")
}
```

### 2. Switch Statements (10 minutes)

`switch` is ideal when you have many possible values to check. In Swift, `switch` must be exhaustive and does not fall through by default.

```swift
let dayOfWeek = "Wednesday"

switch dayOfWeek {
case "Monday":
    print("Start of the school week.")
case "Tuesday", "Wednesday", "Thursday":
    print("Midweek -- keep going!")
case "Friday":
    print("Almost the weekend!")
case "Saturday", "Sunday":
    print("Weekend! Relax.")
default:
    print("That's not a valid day.")
}
```

#### Switch with Ranges

```swift
let score = 87

switch score {
case 90...100:
    print("A")
case 80..<90:
    print("B")
case 70..<80:
    print("C")
case 60..<70:
    print("D")
default:
    print("F")
}
```

### 3. For-In Loops (10 minutes)

Use `for-in` to repeat code a specific number of times or to iterate over a collection.

```swift
// Loop over a range
for i in 1...5 {
    print("Iteration \(i)")
}

// Loop without using the variable (use _)
for _ in 1...3 {
    print("Hip hip hooray!")
}

// Loop over an array
let fruits = ["Apple", "Banana", "Cherry"]
for fruit in fruits {
    print("I like \(fruit)")
}
```

#### The Stride Function

```swift
// Count by 2s from 0 to 10
for number in stride(from: 0, through: 10, by: 2) {
    print(number)  // 0, 2, 4, 6, 8, 10
}
```

### 4. While and Repeat-While Loops (10 minutes)

Use `while` when you don't know in advance how many times to loop.

```swift
var countdown = 5
while countdown > 0 {
    print("\(countdown)...")
    countdown -= 1
}
print("Liftoff!")
```

`repeat-while` always runs the body at least once (like `do-while` in other languages):

```swift
var attempts = 0
repeat {
    attempts += 1
    print("Attempt \(attempts)")
} while attempts < 3
```

### 5. Nested Control Flow and Break/Continue (5 minutes)

```swift
for i in 1...10 {
    if i % 2 == 0 {
        continue  // Skip even numbers
    }
    print(i)  // Prints 1, 3, 5, 7, 9
}

for i in 1...100 {
    if i == 5 {
        break  // Exit the loop early
    }
    print(i)  // Prints 1, 2, 3, 4
}
```

---

## Live Coding Demo (10 minutes)

Build a **"Grade Calculator"** with the class.

1. Declare a variable for a numeric score.
2. Use `if/else if/else` to assign a letter grade.
3. Refactor to use a `switch` statement with ranges.
4. Wrap it in a `for-in` loop to grade an array of scores.

```swift
let scores = [92, 85, 73, 61, 45, 98, 77]

for score in scores {
    let letter: String
    switch score {
    case 90...100:
        letter = "A"
    case 80..<90:
        letter = "B"
    case 70..<80:
        letter = "C"
    case 60..<70:
        letter = "D"
    default:
        letter = "F"
    }
    print("Score: \(score) -> Grade: \(letter)")
}
```

---

## Practice Exercises

### Easy

**Exercise 1: Age Checker**
Ask the user for an age (hardcode a value). Print whether they are a child (0-12), teenager (13-17), or adult (18+).

**Exercise 2: Even or Odd**
Use a `for-in` loop to print the numbers 1 through 20. Next to each number, print whether it is even or odd.

**Exercise 3: Countdown**
Write a `while` loop that counts down from 10 to 1, then prints "Go!".

### Medium

**Exercise 4: FizzBuzz**
Print numbers 1 to 50. For multiples of 3, print "Fizz" instead. For multiples of 5, print "Buzz". For multiples of both, print "FizzBuzz".

**Exercise 5: Day Planner**
Create a `switch` statement that takes a day of the week (as a `String`) and prints a full class schedule for that day. Include at least 4 classes per day and handle weekends with a "No school" message.

---

## Homework Assignment

**"Number Analyzer"**

Write a Swift program that:

1. Declares an array of at least 10 integers (mix of positive, negative, and zero)
2. Uses a `for-in` loop to go through each number and:
   - Print whether the number is positive, negative, or zero
   - Print whether it is even or odd
3. Uses a `while` loop to find the first negative number in the array and print its index
4. Uses a `switch` statement to categorize each number as "small" (0-10), "medium" (11-50), "large" (51-100), or "out of range"

**Due:** Beginning of Week 3.

---

## Teacher Notes

- **Common Misconception:** Students coming from other languages may expect `switch` to fall through. Emphasize that Swift does not fall through by default and that `fallthrough` is rarely used.
- **Pacing:** `if/else` and `for-in` loops are the highest priority. If time is short, briefly introduce `switch` and `while` and revisit them during exercises.
- **Debugging Tip:** Off-by-one errors are extremely common with ranges. Show the difference between `1...5` (closed range, includes 5) and `1..<5` (half-open range, excludes 5).
- **Differentiation:** Advanced students can try nested loops (e.g., multiplication table). Struggling students should focus on simple `if/else` with one condition before adding `else if`.
- **Engagement:** FizzBuzz is a classic and fun. Consider making it a friendly class competition to see who finishes first with correct output.
- **Connection to Week 1:** Remind students that the conditions in `if` statements evaluate to `Bool` values -- this ties directly back to the `Bool` data type from last week.
