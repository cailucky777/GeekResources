# Week 5: Optionals, Guard, and Error Handling

## Learning Objectives

By the end of this lesson, students will be able to:

1. Explain what optionals are and why Swift requires them
2. Safely unwrap optionals using `if let`, `guard let`, and the nil coalescing operator (`??`)
3. Recognize and avoid force unwrapping (`!`) pitfalls
4. Define custom error types using `enum` and the `Error` protocol
5. Handle errors using `do-catch`, `try`, and `throws`

---

## Warm-Up Activity (5 minutes)

**"The Empty Locker"**

Ask the class: "Imagine you go to your locker. Sometimes there's a textbook inside, sometimes it's empty. How would you describe this to a computer?"

Write on the board:
- Locker contains a textbook --> `String` with a value
- Locker is empty --> ???

Introduce the idea: In Swift, "empty" is represented by `nil`, and an optional is a container that might hold a value or might be empty.

---

## Lesson Content

### 1. What Are Optionals? (10 minutes)

An optional can hold a value OR `nil` (the absence of a value).

```swift
var middleName: String? = "Marie"
print(middleName)  // Optional("Marie")

var nickname: String? = nil
print(nickname)    // nil
```

**Why do optionals exist?** Swift is designed to be safe. Rather than allowing any variable to secretly be `nil` (which causes crashes in many languages), Swift forces you to explicitly handle the possibility that a value might be missing.

#### Where Optionals Appear Naturally

```swift
let number = Int("42")    // Optional(42) -- parsing could fail
let number2 = Int("abc")  // nil -- "abc" is not a number

let names = ["Alex", "Jordan", "Sam"]
let found = names.first   // Optional("Alex") -- array could be empty

let grades = ["Alex": 92, "Jordan": 85]
let score = grades["Sam"]  // nil -- key might not exist
```

### 2. Unwrapping Optionals (15 minutes)

You cannot use an optional value directly. You must unwrap it first.

#### Force Unwrapping (Dangerous -- Avoid!)

```swift
var name: String? = "Alex"
print(name!)  // "Alex" -- works, but risky

var noName: String? = nil
// print(noName!)  // CRASH! Fatal error: unexpectedly found nil
```

**Rule: Never force unwrap unless you are 100% certain the value is not nil.**

#### If Let (Optional Binding)

```swift
var petName: String? = "Buddy"

if let name = petName {
    print("My pet's name is \(name)")
} else {
    print("I don't have a pet.")
}
```

You can unwrap multiple optionals at once:

```swift
let first: String? = "Alex"
let last: String? = "Smith"

if let firstName = first, let lastName = last {
    print("Full name: \(firstName) \(lastName)")
}
```

#### Guard Let (Early Exit)

`guard let` unwraps an optional and exits the current scope if it is `nil`. This keeps the "happy path" unindented.

```swift
func greetUser(name: String?) {
    guard let unwrappedName = name else {
        print("No name provided.")
        return
    }
    // unwrappedName is available for the rest of the function
    print("Hello, \(unwrappedName)!")
}

greetUser(name: "Jordan")  // "Hello, Jordan!"
greetUser(name: nil)        // "No name provided."
```

#### Nil Coalescing Operator (`??`)

Provide a default value when an optional is `nil`.

```swift
let userColor: String? = nil
let displayColor = userColor ?? "Blue"
print(displayColor)  // "Blue"

let savedScore: Int? = 95
let score = savedScore ?? 0
print(score)  // 95
```

#### Optional Chaining

Access properties or methods on an optional without unwrapping first. The entire chain returns `nil` if any link is `nil`.

```swift
let students: [String: [Int]]? = ["Alex": [90, 85, 92]]
let firstScore = students?["Alex"]?.first
print(firstScore)  // Optional(90)
```

### 3. Error Handling (10 minutes)

#### Defining Errors

```swift
enum LoginError: Error {
    case emptyUsername
    case emptyPassword
    case invalidCredentials
}
```

#### Throwing Errors

```swift
func login(username: String, password: String) throws -> String {
    guard !username.isEmpty else {
        throw LoginError.emptyUsername
    }
    guard !password.isEmpty else {
        throw LoginError.emptyPassword
    }
    guard username == "admin" && password == "1234" else {
        throw LoginError.invalidCredentials
    }
    return "Welcome, \(username)!"
}
```

#### Handling Errors with Do-Catch

```swift
do {
    let message = try login(username: "admin", password: "1234")
    print(message)
} catch LoginError.emptyUsername {
    print("Error: Username cannot be empty.")
} catch LoginError.emptyPassword {
    print("Error: Password cannot be empty.")
} catch LoginError.invalidCredentials {
    print("Error: Wrong username or password.")
} catch {
    print("An unexpected error occurred: \(error)")
}
```

#### Try? and Try!

```swift
// try? returns nil on failure
let result = try? login(username: "", password: "1234")
print(result)  // nil

// try! crashes on failure (avoid this)
// let result2 = try! login(username: "", password: "1234")  // CRASH
```

---

## Live Coding Demo (10 minutes)

Build a **"User Registration Form Validator"** with the class.

1. Define a `RegistrationError` enum with cases for empty name, invalid age, and invalid email.
2. Write a `register` function that validates inputs and throws appropriate errors.
3. Use `do-catch` to handle each error with a user-friendly message.
4. Show `guard let` and `if let` working together.

```swift
enum RegistrationError: Error {
    case emptyName
    case invalidAge
    case invalidEmail
}

func register(name: String?, ageString: String?, email: String?) throws -> String {
    guard let name = name, !name.isEmpty else {
        throw RegistrationError.emptyName
    }
    guard let ageStr = ageString, let age = Int(ageStr), age >= 13 else {
        throw RegistrationError.invalidAge
    }
    guard let email = email, email.contains("@") else {
        throw RegistrationError.invalidEmail
    }
    return "Registered \(name), age \(age), email: \(email)"
}

// Test cases
let testCases: [(String?, String?, String?)] = [
    ("Alex", "15", "alex@email.com"),
    (nil, "15", "alex@email.com"),
    ("Alex", "ten", "alex@email.com"),
    ("Alex", "15", "not-an-email"),
]

for (name, age, email) in testCases {
    do {
        let result = try register(name: name, ageString: age, email: email)
        print("Success: \(result)")
    } catch RegistrationError.emptyName {
        print("Error: Please enter your name.")
    } catch RegistrationError.invalidAge {
        print("Error: Please enter a valid age (must be 13+).")
    } catch RegistrationError.invalidEmail {
        print("Error: Please enter a valid email address.")
    } catch {
        print("Unknown error: \(error)")
    }
}
```

---

## Practice Exercises

### Easy

**Exercise 1: Safe Dictionary Lookup**
Create a dictionary of 5 state capitals. Write code that looks up a state using `if let` and prints the capital or "State not found."

**Exercise 2: Default Values**
Create three optional variables (a `String?`, an `Int?`, and a `Double?`), some set to `nil` and some with values. Use the nil coalescing operator to print each one with a sensible default.

**Exercise 3: String to Int**
Ask the user for input (hardcode a few test strings like "42", "hello", "0"). Use `if let` with `Int()` to safely convert each string and print whether the conversion succeeded.

### Medium

**Exercise 4: Safe Array Operations**
Write a function `safeElement(array: [Int], index: Int) -> Int?` that returns `nil` if the index is out of bounds, or the element if valid. Test it with several indices.

**Exercise 5: ATM Withdrawal**
Define a `WithdrawalError` enum with cases `insufficientFunds`, `invalidAmount`, and `accountLocked`. Write a `withdraw(amount:balance:isLocked:)` function that throws these errors. Handle all errors in a `do-catch` block with user-friendly messages.

---

## Homework Assignment

**"Safe Contact Book"**

Write a Swift program that:

1. Stores contacts in a `[String: [String: String?]]` dictionary where each contact has optional fields: phone, email, address
2. Write a function `lookupContact(name:)` that uses `guard let` to check if the contact exists, and returns a formatted string of their info using nil coalescing for missing fields (e.g., "Phone: Not provided")
3. Write a function `addContact(name:phone:email:address:)` that uses `throws` to validate that at least a phone or email is provided (throw an error otherwise)
4. Demonstrate all functions with at least 5 contacts, some with missing fields

**Due:** Beginning of Week 6.

---

## Teacher Notes

- **Common Misconception:** Students will want to force unwrap everything with `!` to "make the compiler happy." Strongly discourage this. Explain that the compiler error is a safety feature, not a nuisance.
- **Pacing:** Optionals (`if let`, `guard let`, `??`) are the core priority. Error handling is important but can be introduced more briefly and revisited. If time is short, skip `try?` and optional chaining.
- **Analogy That Works:** Compare optionals to a gift box -- it might have a present inside, or it might be empty. You have to open (unwrap) it to find out. You would not want to assume every box has a gift.
- **Differentiation:** Advanced students can explore `guard` with multiple conditions, `defer` statements, and rethrowing functions. Struggling students should focus on `if let` and `??` -- these two tools handle most cases.
- **Connection to Previous Weeks:** Dictionary lookups (Week 4) return optionals. `Int("string")` (Week 1) returns an optional. Show students they have already been encountering optionals without knowing it.
- **Midterm Prep:** This is the last week before the midterm quiz. Consider using the last 5-10 minutes for a review Q&A covering Weeks 1-5.
- **Common Crash:** `index out of range` from arrays and `unexpectedly found nil while unwrapping` are the two most common Swift crashes. This week's lesson directly addresses the second one.
