# Beginner Competitive Programming Problems

10 beginner-level problems to build foundational problem-solving skills. Each includes a problem statement, I/O format, sample cases, hints, and a solution in Swift.

**Topics covered**: Basic I/O, math, strings, simple loops.

---

## Problem 1: Hello, Contestant!

### Problem Statement

Read a person's name from input and print a greeting.

### Input Format

A single line containing a string (the person's name). The name contains only letters and is at most 50 characters long.

### Output Format

Print `Hello, <name>!` where `<name>` is the input.

### Sample Input

```
Alice
```

### Sample Output

```
Hello, Alice!
```

### Hints

- Use `readLine()` to read input in Swift.
- Remember to handle the optional returned by `readLine()`.

### Solution (Swift)

```swift
if let name = readLine() {
    print("Hello, \(name)!")
}
```

---

## Problem 2: Sum of Two Numbers

### Problem Statement

Read two integers from input and print their sum.

### Input Format

A single line containing two space-separated integers `a` and `b` (-10^9 <= a, b <= 10^9).

### Output Format

Print the sum of `a` and `b`.

### Sample Input

```
3 7
```

### Sample Output

```
10
```

### Hints

- Split the input string by spaces.
- Convert strings to integers using `Int()`.

### Solution (Swift)

```swift
if let line = readLine() {
    let parts = line.split(separator: " ")
    let a = Int(parts[0])!
    let b = Int(parts[1])!
    print(a + b)
}
```

---

## Problem 3: Even or Odd

### Problem Statement

Read an integer and determine if it is even or odd.

### Input Format

A single integer `n` (-10^9 <= n <= 10^9).

### Output Format

Print `Even` if the number is even, `Odd` if it is odd.

### Sample Input

```
4
```

### Sample Output

```
Even
```

### Sample Input 2

```
7
```

### Sample Output 2

```
Odd
```

### Hints

- Use the modulo operator `%` to check divisibility by 2.

### Solution (Swift)

```swift
if let line = readLine(), let n = Int(line) {
    print(n % 2 == 0 ? "Even" : "Odd")
}
```

---

## Problem 4: Maximum of Three

### Problem Statement

Read three integers and print the largest one.

### Input Format

A single line containing three space-separated integers `a`, `b`, and `c` (-10^9 <= a, b, c <= 10^9).

### Output Format

Print the maximum of the three integers.

### Sample Input

```
3 1 7
```

### Sample Output

```
7
```

### Hints

- Use Swift's built-in `max()` function, or compare values with `if` statements.

### Solution (Swift)

```swift
if let line = readLine() {
    let nums = line.split(separator: " ").map { Int($0)! }
    print(max(nums[0], nums[1], nums[2]))
}
```

---

## Problem 5: Sum of N Numbers

### Problem Statement

Read an integer `n`, followed by `n` integers. Print their sum.

### Input Format

- Line 1: An integer `n` (1 <= n <= 1000).
- Line 2: `n` space-separated integers, each between -10^6 and 10^6.

### Output Format

Print the sum of all `n` integers.

### Sample Input

```
5
1 2 3 4 5
```

### Sample Output

```
15
```

### Hints

- Read the second line, split it, convert to integers, then sum them up.
- Swift arrays have a `reduce` method that can compute the sum.

### Solution (Swift)

```swift
let _ = readLine() // read n (not strictly needed)
if let line = readLine() {
    let sum = line.split(separator: " ").map { Int($0)! }.reduce(0, +)
    print(sum)
}
```

---

## Problem 6: Reverse a String

### Problem Statement

Read a string and print it reversed.

### Input Format

A single line containing a string of at most 1000 characters (letters, digits, and spaces).

### Output Format

Print the reversed string.

### Sample Input

```
hello world
```

### Sample Output

```
dlrow olleh
```

### Hints

- Swift strings can be reversed with `String(str.reversed())`.

### Solution (Swift)

```swift
if let line = readLine() {
    print(String(line.reversed()))
}
```

---

## Problem 7: Counting Vowels

### Problem Statement

Read a string and count the number of vowels (a, e, i, o, u -- both lowercase and uppercase).

### Input Format

A single line containing a string of at most 1000 characters.

### Output Format

Print the number of vowels in the string.

### Sample Input

```
Hello World
```

### Sample Output

```
3
```

### Hints

- Create a set of vowel characters and check membership for each character.
- Convert to lowercase first to simplify the check.

### Solution (Swift)

```swift
if let line = readLine() {
    let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
    let count = line.lowercased().filter { vowels.contains($0) }.count
    print(count)
}
```

---

## Problem 8: Multiplication Table

### Problem Statement

Read an integer `n` and print its multiplication table from 1 to 12.

### Input Format

A single integer `n` (1 <= n <= 100).

### Output Format

Print 12 lines, each in the format `n x i = result` where `i` goes from 1 to 12.

### Sample Input

```
5
```

### Sample Output

```
5 x 1 = 5
5 x 2 = 10
5 x 3 = 15
5 x 4 = 20
5 x 5 = 25
5 x 6 = 30
5 x 7 = 35
5 x 8 = 40
5 x 9 = 45
5 x 10 = 50
5 x 11 = 55
5 x 12 = 60
```

### Hints

- Use a `for` loop from 1 to 12.
- Use string interpolation to format the output.

### Solution (Swift)

```swift
if let line = readLine(), let n = Int(line) {
    for i in 1...12 {
        print("\(n) x \(i) = \(n * i)")
    }
}
```

---

## Problem 9: FizzBuzz

### Problem Statement

Read an integer `n` and print all numbers from 1 to `n`. But for multiples of 3, print `Fizz` instead of the number. For multiples of 5, print `Buzz`. For multiples of both 3 and 5, print `FizzBuzz`.

### Input Format

A single integer `n` (1 <= n <= 1000).

### Output Format

Print `n` lines, one for each number from 1 to `n`.

### Sample Input

```
16
```

### Sample Output

```
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
16
```

### Hints

- Check divisibility by 15 first (both 3 and 5), then by 3, then by 5.
- Order of conditions matters!

### Solution (Swift)

```swift
if let line = readLine(), let n = Int(line) {
    for i in 1...n {
        if i % 15 == 0 {
            print("FizzBuzz")
        } else if i % 3 == 0 {
            print("Fizz")
        } else if i % 5 == 0 {
            print("Buzz")
        } else {
            print(i)
        }
    }
}
```

---

## Problem 10: Digit Sum

### Problem Statement

Read a non-negative integer and print the sum of its digits.

### Input Format

A single non-negative integer `n` (0 <= n <= 10^18).

### Output Format

Print the sum of the digits of `n`.

### Sample Input

```
12345
```

### Sample Output

```
15
```

### Sample Input 2

```
0
```

### Sample Output 2

```
0
```

### Hints

- You can process the number as a string and convert each character to an integer.
- Alternatively, use repeated modulo and division.

### Solution (Swift)

```swift
if let line = readLine() {
    let sum = line.compactMap { $0.wholeNumberValue }.reduce(0, +)
    print(sum)
}
```

---

## What's Next?

Once you can solve all 10 problems comfortably, move on to:

1. **CCC Junior problems** from [CEMC Past Contests](https://cemc.uwaterloo.ca/resources/past-contests?grade=All&academic_year=All&contest_category=29)
2. **USACO Bronze** problems from [usaco.guide](https://usaco.guide/)
3. **LeetCode Easy** problems sorted by acceptance rate

Key topics to learn next: arrays, sorting, binary search, and basic data structures (stacks, queues, dictionaries).
