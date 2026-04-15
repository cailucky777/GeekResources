# Swift Cheatsheet

A one-page reference. Print, keep open, bookmark.

---

## Variables

```swift
let pi = 3.14            // constant
var count = 0            // variable
var name: String = "Bo"  // explicit type
```

## Optionals

```swift
var middleName: String? = nil
if let m = middleName { print(m) }
let display = middleName ?? "—"
guard let m = middleName else { return }
```

## Collections

```swift
var nums = [1, 2, 3]
nums.append(4)
nums.count
nums.first       // Optional

var scores = ["alice": 10, "bob": 8]
scores["alice"]  // Optional

let unique: Set = [1, 2, 2, 3]  // {1, 2, 3}
```

## Control Flow

```swift
for n in 1...5 { print(n) }            // 1 through 5
for n in 1..<5 { print(n) }            // 1 through 4
for (k, v) in scores { }

if count > 0 { ... } else { ... }

switch score {
case 0: print("none")
case 1..<50: print("low")
case 50...100: print("ok")
default: print("??")
}

while attempt < 3 { }
```

## Functions

```swift
func greet(_ name: String, times: Int = 1) -> String {
    String(repeating: "Hi \(name)! ", count: times)
}

greet("Mia")
greet("Mia", times: 3)
```

## Closures

```swift
let square: (Int) -> Int = { $0 * $0 }
[1, 2, 3].map(square)        // [1, 4, 9]
[1, 2, 3].filter { $0 > 1 }  // [2, 3]
[1, 2, 3].reduce(0, +)       // 6
```

## Structs & Classes

```swift
struct Point { var x, y: Double }   // value type, auto init
class View { var title = "" }       // reference type
```

## Protocols

```swift
protocol Greetable {
    func greet() -> String
}

struct Dog: Greetable {
    func greet() -> String { "Woof" }
}
```

## Enums

```swift
enum Direction { case north, south, east, west }
enum Result {
    case success(String)
    case failure(Error)
}
```

## Error Handling

```swift
enum AppError: Error { case badInput }

func parse(_ s: String) throws -> Int {
    guard let n = Int(s) else { throw AppError.badInput }
    return n
}

do {
    let n = try parse("42")
} catch {
    print(error)
}
```

## Concurrency

```swift
func fetch() async throws -> Data {
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}

Task { try await fetch() }
```

## Common Stdlib Methods

```swift
"hello".uppercased()
"hello".contains("ell")
"1,2,3".split(separator: ",")   // ["1","2","3"]
[3, 1, 2].sorted()
[1, 2, 3].contains(2)
Array(repeating: 0, count: 5)
```
