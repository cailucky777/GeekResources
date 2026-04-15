# Unit Testing Intro

> "Code without tests is code you don't trust."

A **unit test** is a tiny program that checks whether another piece of your code does what you think it does. In Swift, there are two test frameworks: the classic **XCTest** and the newer **Swift Testing**.

---

## Why Test?

- **Catch bugs before users do.**
- **Refactor fearlessly** — if tests pass, you didn't break anything.
- **Document how your code is supposed to be used.**
- **Debug less** — a failing test points straight at the problem.

---

## Creating a Test Target

1. In Xcode, `File → New → Target...`
2. Choose **Unit Testing Bundle**.
3. Xcode creates a folder like `MyAppTests/`.

To run tests: **`⌘U`**.

---

## Swift Testing (Recommended for New Projects)

```swift
import Testing
@testable import MyApp

@Test func scoreStartsAtZero() {
    let game = Game()
    #expect(game.score == 0)
}

@Test func addingCorrectAnswerIncreasesScore() {
    var game = Game()
    game.submit(answer: .correct)
    #expect(game.score == 10)
}

@Test("Score never goes negative", arguments: [-5, -100, -1])
func scoreNeverNegative(penalty: Int) {
    var game = Game()
    game.applyPenalty(penalty)
    #expect(game.score >= 0)
}
```

### Key APIs

- `@Test` — marks a function as a test.
- `#expect(condition)` — soft assertion; test continues even if it fails.
- `#require(condition)` — stops the test immediately if false.
- `arguments:` — run the same test with multiple inputs.

---

## XCTest (Older, But You'll See It Everywhere)

```swift
import XCTest
@testable import MyApp

final class GameTests: XCTestCase {
    func test_scoreStartsAtZero() {
        let game = Game()
        XCTAssertEqual(game.score, 0)
    }

    func test_correctAnswerAddsTen() {
        var game = Game()
        game.submit(answer: .correct)
        XCTAssertEqual(game.score, 10)
    }
}
```

### Assertions Cheat Sheet

| XCTest | Swift Testing |
|---|---|
| `XCTAssertEqual(a, b)` | `#expect(a == b)` |
| `XCTAssertTrue(x)` | `#expect(x)` |
| `XCTAssertNil(x)` | `#expect(x == nil)` |
| `XCTAssertThrowsError(try f())` | `#expect(throws: MyError.self) { try f() }` |

---

## The AAA Pattern

Every good test has three parts:

```swift
@Test func studentCanJoinClass() {
    // Arrange — set up the world
    let classroom = Classroom(capacity: 30)
    let student = Student(name: "Maya")

    // Act — do the thing
    classroom.add(student)

    // Assert — check the result
    #expect(classroom.students.count == 1)
    #expect(classroom.students.first?.name == "Maya")
}
```

---

## What to Test First

You do **not** need 100% coverage. Start with:

1. **Pure functions** — ones that just compute from inputs to outputs. Easiest to test.
2. **Anything with math or logic.** Scoring, discount calculations, date math.
3. **Edge cases.** Empty arrays, zero, negative numbers, very long strings.
4. **Bugs you've already fixed.** Write a test that would have caught the bug. Now it'll never come back.

**Don't try to test the UI yet** — that's UI testing, a separate topic.

---

## Exercises

1. Create a function `isPalindrome(_ s: String) -> Bool`. Write 5 tests: `""`, `"a"`, `"abba"`, `"hello"`, `"Racecar"`.
2. Write a `Calculator` struct with `add`, `subtract`, `divide`. Test division by zero.
3. Break one of your existing functions on purpose. Confirm that one of your tests fails. Fix it. Confirm tests pass again.

---

## Rules of Good Tests

- **One concept per test.** If it fails, you know what broke.
- **Names describe behavior.** `test_emptyCart_hasTotalOfZero` > `test1`.
- **Tests should be fast.** Slow tests get skipped.
- **No network, no randomness, no file system** (unless you mock them).
- **If you can't test it, your code is probably too tangled.** That's a design smell.
