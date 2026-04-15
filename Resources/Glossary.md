# Glossary

Common programming terms with plain-English explanations, English + 中文.

> Built for international-school students. The 中文 translations are conventional but may differ by region.

---

## A

**API (Application Programming Interface) · 应用程序接口**
A way for one program to talk to another. You send a request, the other program sends back a response. Like a menu at a restaurant — you pick what you want, the kitchen makes it.

**Algorithm · 算法**
A step-by-step procedure to solve a problem. Sorting a list, finding the shortest path, balancing a tree — all algorithms.

**Array · 数组**
An ordered list of values. `[1, 2, 3]`. Swift calls it `Array`, Python calls it `list`.

**async / await · 异步/等待**
Keywords that let you write code that runs at different times without blocking everything. `let data = try await fetch()` means "pause here until `fetch` is done."

---

## B

**Binding · 绑定**
A two-way connection between a value and a view. In SwiftUI, `@Binding` lets a child view change a parent's state.

**Boolean · 布尔值**
True or false. Named after George Boole, who formalized the math.

**Build · 构建**
The process of turning your source code into a runnable program.

---

## C

**Class · 类**
A blueprint for creating objects. Classes define properties (data) and methods (functions). Swift also has `struct`, which is similar but passed by value.

**Closure · 闭包**
An anonymous function you can pass around like a value. In Swift: `{ n in n * 2 }`.

**Commit · 提交**
A saved snapshot of your code in git. Think "checkpoint in a video game."

**Compiler · 编译器**
A program that turns your source code into something the computer runs.

**Concurrency · 并发**
Doing multiple things at once (or appearing to). In Swift, handled with `async/await`, `Task`, and actors.

**Constructor / Initializer · 构造函数 / 初始化器**
The code that runs when you create a new instance of a type. In Swift it's `init(...)`.

---

## D

**Debugger · 调试器**
A tool that lets you pause a running program and inspect it. Xcode includes one built in.

**Dependency · 依赖**
Code your project relies on but didn't write — usually a library.

**Deploy · 部署**
To make your code run somewhere other than your own machine (a server, the App Store, the web).

**Diff · 差异**
The difference between two versions of a file. What git shows you.

---

## E

**Enum (Enumeration) · 枚举**
A type with a fixed set of possible values. `enum Direction { case north, south, east, west }`.

**Environment variable · 环境变量**
A value stored by your shell, not your code. Used for secrets like API keys.

**Error handling · 错误处理**
The code you write to deal with things that might go wrong (bad input, network errors). In Swift: `throws`, `try`, `catch`.

---

## F

**Framework · 框架**
A large library, usually providing the structure for a whole kind of program. SwiftUI, UIKit, Foundation are frameworks.

**Function · 函数**
A reusable chunk of code that takes inputs and returns output.

---

## G

**Git · 分布式版本控制系统**
The version control system. Tracks changes to files over time.

**GitHub · 代码托管平台**
A website that hosts git repositories. Not the same as git.

---

## H

**Hash · 哈希 / 散列**
A fixed-size "fingerprint" derived from data. Used in dictionaries for fast lookup, and in git for identifying commits.

---

## I

**IDE (Integrated Development Environment) · 集成开发环境**
A program that combines an editor, compiler, debugger, and more. Xcode and VS Code are IDEs.

**Instance · 实例**
A specific object created from a class or struct.

**Interface · 接口**
The public-facing part of a piece of code — the functions and properties other code can use.

---

## J

**JSON (JavaScript Object Notation) · JSON 数据格式**
A text format for structured data. Used everywhere on the web.
```json
{ "name": "Ada", "age": 16 }
```

---

## K

**Keychain · 钥匙串**
Apple's secure storage for passwords, tokens, and keys.

---

## L

**Library · 库**
Reusable code someone else wrote that you pull into your project.

**Linter · 代码检查工具**
A program that reads your code and points out style or bug-prone patterns.

---

## M

**Merge · 合并**
Combining branches in git.

**Method · 方法**
A function that belongs to a class or struct.

**Model · 模型**
The data part of your app, as opposed to the UI. Or in ML, a trained function.

---

## N

**Nil · 空值**
The absence of a value. In Swift, `nil` is used with Optionals.

---

## O

**Object · 对象**
An instance of a class. Has properties (data) and methods (behavior).

**Optional · 可选类型**
A Swift type that may or may not contain a value. Written `Int?` for "an Int or nil."

**OSS (Open-Source Software) · 开源软件**
Code whose source is publicly available and free to use (usually under a license).

---

## P

**Package · 包 / 依赖包**
A bundle of code you can install. Swift has **Swift Package Manager (SPM)**.

**Parameter · 参数**
An input to a function.

**Property · 属性**
A value stored inside a class, struct, or enum instance.

**Protocol · 协议**
A contract. "Any type that implements these methods can be used as this protocol." Swift's version of an interface.

**Pull Request (PR) · 拉取请求**
A proposal to merge your branch's changes into another branch. The main collaboration tool on GitHub.

---

## Q

**Query · 查询**
A request for data, typically from a database.

---

## R

**Refactor · 重构**
Improving the structure of code without changing what it does.

**Regex (Regular Expression) · 正则表达式**
A mini-language for matching text patterns. `\d+` means "one or more digits."

**Repository / Repo · 代码仓库**
A git project. Just a folder with a `.git` subfolder.

---

## S

**SDK (Software Development Kit) · 软件开发工具包**
A bundle of tools and libraries for building software on a specific platform.

**Source code · 源代码**
The human-readable text a developer writes.

**State · 状态**
Data your app holds in memory that can change over time.

**String · 字符串**
Text.

**Struct · 结构体**
A Swift value type. Like a class but simpler and passed by copy.

---

## T

**Token · 令牌**
A unit of text from a language model's perspective. Roughly 4 characters of English per token.

**Type · 类型**
The kind of data a value is. `Int`, `String`, `Bool`, your own structs, etc.

---

## U

**URL · 网络资源地址**
An address for a resource on the internet.

---

## V

**Variable · 变量**
A named value that can change.

**Version Control · 版本控制**
The practice (and tools) for tracking changes to code.

---

## W

**Widget · 小组件**
On iOS, a small UI block shown on the home screen or lock screen.

---

## X

**Xcode · 苹果开发工具**
Apple's IDE.

**XCTest · 测试框架**
The classic test framework for Swift and Objective-C.

---

## Y

**YAML · 配置文件格式**
A human-readable data format often used for config files.

---

## Z

**Zero-index · 从零开始索引**
The first element of an array is at index `0`, not `1`. Get used to it.
