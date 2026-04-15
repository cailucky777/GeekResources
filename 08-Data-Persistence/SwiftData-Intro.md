# SwiftData Intro

> A database you get for free, with almost no boilerplate. Designed for SwiftUI.

SwiftData is Apple's modern replacement for Core Data. Use it when your app has **structured, searchable records** — todos, notes, recipes, game scores.

---

## The Three Pieces You Need

1. **`@Model`** — marks a class as persistent.
2. **`.modelContainer(...)`** — attaches the database to your app.
3. **`@Query`** — reads from the database in a view.

---

## 1. Define a Model

```swift
import SwiftData

@Model
final class Todo {
    var title: String
    var isDone: Bool
    var createdAt: Date

    init(title: String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
        self.createdAt = .now
    }
}
```

That's it. No schemas, no SQL, no migrations. SwiftData figures out how to store it.

---

## 2. Attach the Container in Your App Entry

```swift
import SwiftUI
import SwiftData

@main
struct TodoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Todo.self)
    }
}
```

---

## 3. Query From a View

```swift
struct ContentView: View {
    @Query(sort: \Todo.createdAt, order: .reverse) private var todos: [Todo]
    @Environment(\.modelContext) private var context

    @State private var newTitle = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(todos) { todo in
                    HStack {
                        Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                        Text(todo.title)
                    }
                    .onTapGesture { todo.isDone.toggle() }
                }
                .onDelete { indexes in
                    for i in indexes { context.delete(todos[i]) }
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack {
                    TextField("New todo", text: $newTitle)
                    Button("Add") {
                        context.insert(Todo(title: newTitle))
                        newTitle = ""
                    }
                }
                .padding()
            }
        }
    }
}
```

Notice:

- You **never write save code.** SwiftData saves automatically.
- Changes to `todo.isDone` propagate to the UI instantly.
- `@Query` re-runs when data changes.

---

## Filtering and Sorting

```swift
// Only incomplete todos
@Query(filter: #Predicate<Todo> { !$0.isDone })
private var openTodos: [Todo]

// Sorted, limited
@Query(
    filter: #Predicate<Todo> { $0.title.contains("urgent") },
    sort: [SortDescriptor(\Todo.createdAt, order: .reverse)]
)
private var urgent: [Todo]
```

`#Predicate` looks scary but it's just normal Swift.

---

## Relationships

```swift
@Model
final class Project {
    var name: String
    @Relationship(deleteRule: .cascade) var todos: [Todo] = []
    init(name: String) { self.name = name }
}

@Model
final class Todo {
    var title: String
    var project: Project?
    init(title: String, project: Project? = nil) {
        self.title = title
        self.project = project
    }
}
```

`deleteRule: .cascade` means "when you delete a Project, delete its Todos too."

---

## When NOT to Use SwiftData

- **Shared across users** → use a server (Supabase, Firebase, CloudKit).
- **Huge datasets (millions of rows)** → you're past student territory; look at SQLite directly.
- **One-off settings** → `@AppStorage` is fine.

---

## Exercise

Build a **Flashcard** app:

1. A `Deck` model with a name and an array of `Card` models.
2. A `Card` has `front` and `back` text and a `lastReviewed` date.
3. UI: list of decks, tap to enter, flip cards, mark as "reviewed."
4. All data persists across launches.

Bonus: add a query that shows "cards I haven't reviewed in 7 days."
