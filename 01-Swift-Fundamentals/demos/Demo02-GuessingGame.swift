// =============================================================
// Demo 02: Number Guessing Game
// Module: Swift Fundamentals
// Topics: Control flow (if/else, switch, while), optionals,
//         loops, string-to-int conversion, randomness
//
// TEACHER NOTES:
// - This demo ties together Weeks 1-2 concepts with a preview
//   of optionals (Week 5).
// - Run this in Terminal (not Playgrounds) for the best
//   interactive experience: swift Demo02-GuessingGame.swift
// - Walk through the code first, THEN play the game as a class.
// - Ask students to suggest improvements at the end.
// =============================================================

import Foundation

// -------------------------------------------------------------
// SECTION 1: Setting Up the Game
// TEACHER: Explain that Int.random(in:) generates a random
// number within a closed range. 'let' is used because the
// secret number does not change during one round.
// -------------------------------------------------------------

let minNumber = 1
let maxNumber = 100
let secretNumber = Int.random(in: minNumber...maxNumber)
var attempts = 0
let maxAttempts = 7
var hasWon = false

print("========================================")
print("   Welcome to the Number Guessing Game!")
print("========================================")
print("I'm thinking of a number between \(minNumber) and \(maxNumber).")
print("You have \(maxAttempts) attempts. Good luck!\n")

// -------------------------------------------------------------
// SECTION 2: The Game Loop
// TEACHER: This is a 'while' loop that continues as long as
// the player has not won AND has attempts remaining.
// Highlight how multiple conditions are combined with &&.
// -------------------------------------------------------------

while !hasWon && attempts < maxAttempts {
    attempts += 1
    let attemptsRemaining = maxAttempts - attempts

    print("Attempt \(attempts)/\(maxAttempts): Enter your guess: ", terminator: "")

    // --------------------------------------------------------
    // SECTION 3: Reading and Validating Input
    // TEACHER: readLine() returns a String? (optional) because
    // the user might not enter anything. Int() also returns
    // Int? because the string might not be a valid number.
    // This is a natural example of why optionals exist.
    // --------------------------------------------------------

    guard let input = readLine() else {
        print("  Could not read input. Try again.\n")
        attempts -= 1  // Don't count a failed read as an attempt
        continue
    }

    // TEACHER: Show what happens if you type "hello" instead of a number.
    // Int(input) returns nil, and the guard statement catches it.
    guard let guess = Int(input) else {
        print("  '\(input)' is not a valid number. Try again.\n")
        attempts -= 1  // Don't count invalid input as an attempt
        continue
    }

    // --------------------------------------------------------
    // SECTION 4: Range Validation with If/Else
    // TEACHER: This checks that the guess is within the valid
    // range before comparing it to the secret number.
    // --------------------------------------------------------

    if guess < minNumber || guess > maxNumber {
        print("  Please guess between \(minNumber) and \(maxNumber).\n")
        attempts -= 1
        continue
    }

    // --------------------------------------------------------
    // SECTION 5: Comparing the Guess
    // TEACHER: Point out the if/else if/else chain. Ask students
    // if they could rewrite this as a switch statement.
    // --------------------------------------------------------

    if guess == secretNumber {
        hasWon = true
        print("\n  Correct! The number was \(secretNumber)!")
    } else if guess < secretNumber {
        print("  Too low!")

        // TEACHER: Nested if for extra hints when running low on attempts
        if attemptsRemaining <= 2 && attemptsRemaining > 0 {
            let difference = secretNumber - guess
            if difference > 20 {
                print("  Hint: You're way too low.")
            } else if difference > 10 {
                print("  Hint: You're somewhat low.")
            } else {
                print("  Hint: You're close!")
            }
        }

        print("  (\(attemptsRemaining) attempts remaining)\n")
    } else {
        print("  Too high!")

        if attemptsRemaining <= 2 && attemptsRemaining > 0 {
            let difference = guess - secretNumber
            if difference > 20 {
                print("  Hint: You're way too high.")
            } else if difference > 10 {
                print("  Hint: You're somewhat high.")
            } else {
                print("  Hint: You're close!")
            }
        }

        print("  (\(attemptsRemaining) attempts remaining)\n")
    }
}

// -------------------------------------------------------------
// SECTION 6: Game Over -- Using a Switch Statement
// TEACHER: Demonstrate how switch can match on a Bool value.
// This is a clean alternative to if/else for binary outcomes.
// -------------------------------------------------------------

print("\n========================================")

switch hasWon {
case true:
    // TEACHER: Show the switch on attempts to vary the message.
    // This demonstrates switch with ranges.
    print("  YOU WIN!")
    switch attempts {
    case 1:
        print("  Incredible! You got it on the first try!")
    case 2...3:
        print("  Excellent! Only \(attempts) attempts!")
    case 4...5:
        print("  Good job! \(attempts) attempts.")
    default:
        print("  You got it in \(attempts) attempts. Close call!")
    }

case false:
    print("  GAME OVER")
    print("  The number was \(secretNumber).")
    print("  Better luck next time!")
}

print("========================================")

// =============================================================
// CHALLENGE FOR STUDENTS:
// 1. Add a play-again loop that asks "Play again? (y/n)"
// 2. Track the best score across multiple rounds
// 3. Add difficulty levels (easy: 1-50, medium: 1-100, hard: 1-500)
//    using a switch statement to set minNumber and maxNumber
// 4. Add a running "too low / too high" range display
//    (e.g., "The number is between 34 and 78")
// =============================================================
