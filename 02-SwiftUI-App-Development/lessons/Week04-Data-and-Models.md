# Week 4: Data and Models

## Lesson Overview

This lesson teaches students how to design **data models**, use the **@Observable** macro for reactive data flow, and connect models to views. Students will build a functional Todo app that creates, displays, toggles, and deletes tasks.

**Duration:** Two 50-minute sessions (or one 100-minute block)

---

## Learning Objectives

- Design Swift structs as data models for an app.
- Understand the role of `@Observable` in SwiftUI's data flow.
- Separate data logic from view code.
- Build a complete Todo app with add, toggle, and delete functionality.
- Understand the difference between value types (structs) and reference types (classes) in the context of data flow.

---

## Part 1: Structs as Data Models

A **data model** is a struct (or class) that represents the information your app works with. Good models are simple, clear, and focused.

### Example: A Todo Item

```swift
struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    var createdDate: Date = Date()
}
```

### Design Principles for Models

1. **Use meaningful property names** -- `title` not `t`, `isCompleted` not `done`.
2. **Provide sensible defaults** -- `isCompleted` starts as `false`.
3. **Conform to Identifiable** -- so SwiftUI can track items in lists.
4. **Keep models small** -- one struct per concept (a todo item, a contact, a recipe).

> **Class discussion:** Ask students: "What properties would you need for a `Recipe` model? A `Song` model? A `Student` model?" Brainstorm on the board.

---

## Part 2: @Observable

In earlier lessons, we used `@State` for simple values like integers and strings. For more complex data -- especially shared data -- SwiftUI provides the `@Observable` macro.

### What Is @Observable?

`@Observable` is applied to a **class** that holds your app's data. When any of its properties change, SwiftUI automatically updates any views that read those properties.

```swift
import SwiftUI

@Observable
class TodoStore {
    var items: [TodoItem] = []

    func addItem(title: String) {
        let newItem = TodoItem(title: title)
        items.append(newItem)
    }

    func toggleItem(_ item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }

    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
```

### Key Points

- `@Observable` works on **classes** (reference types), not structs.
- You do **not** need `@Published` -- the `@Observable` macro handles change tracking automatically.
- Views that reference properties on an `@Observable` object will re-render when those properties change.

---

## Part 3: Connecting Models to Views

### Creating and Using the Store

```swift
struct TodoAppView: View {
    @State private var store = TodoStore()
    @State private var newItemTitle = ""

    var body: some View {
        NavigationStack {
            VStack {
                // Input area
                HStack {
                    TextField("New todo...", text: $newItemTitle)
                        .textFieldStyle(.roundedBorder)

                    Button(action: addItem) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .disabled(newItemTitle.isEmpty)
                }
                .padding()

                // Todo list
                List {
                    ForEach(store.items) { item in
                        TodoRowView(item: item) {
                            store.toggleItem(item)
                        }
                    }
                    .onDelete(perform: store.deleteItems)
                }
            }
            .navigationTitle("My Todos")
        }
    }

    func addItem() {
        store.addItem(title: newItemTitle)
        newItemTitle = ""
    }
}
```

### The Row View

```swift
struct TodoRowView: View {
    let item: TodoItem
    var onToggle: () -> Void

    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(item.isCompleted ? .green : .gray)
                    .font(.title3)
            }
            .buttonStyle(.plain)

            Text(item.title)
                .strikethrough(item.isCompleted)
                .foregroundStyle(item.isCompleted ? .secondary : .primary)

            Spacer()
        }
    }
}
```

---

## Part 4: Data Flow Patterns

SwiftUI data flows in one direction: **from parent to child**. Here is how different tools fit together:

```
@Observable class (data store)
    |
    v
@State (owned by a view)
    |
    v
$binding (passed to child views)
    |
    v
Child views read and write through bindings
```

### When to Use What

| Tool | Use When |
|------|----------|
| `@State` | A view owns a simple, private value (a number, string, boolean) |
| `@Binding` | A child view needs to read/write a parent's @State |
| `@Observable` | You have a data store or model with multiple properties shared across views |

> **Instructor Note:** Draw the data flow diagram on the board. Trace how a button tap in `TodoRowView` calls `onToggle`, which calls `store.toggleItem()`, which mutates `items`, which causes the `List` to re-render.

---

## Part 5: Adding Features to the Todo App

### Filtering

Add a filter to show all, active, or completed items:

```swift
enum TodoFilter: String, CaseIterable {
    case all = "All"
    case active = "Active"
    case completed = "Completed"
}

// Inside the view:
@State private var filter: TodoFilter = .all

var filteredItems: [TodoItem] {
    switch filter {
    case .all: return store.items
    case .active: return store.items.filter { !$0.isCompleted }
    case .completed: return store.items.filter { $0.isCompleted }
    }
}

// Add a Picker in the toolbar:
.toolbar {
    ToolbarItem(placement: .topBarLeading) {
        Picker("Filter", selection: $filter) {
            ForEach(TodoFilter.allCases, id: \.self) { filter in
                Text(filter.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}
```

### Item Count Badge

```swift
Text("\(store.items.filter { !$0.isCompleted }.count) remaining")
    .font(.footnote)
    .foregroundStyle(.secondary)
```

---

## Exercise: Build the Complete Todo App

Combine all the pieces from this lesson into a working Todo app:

### Requirements

1. A `TodoItem` struct conforming to `Identifiable`.
2. A `TodoStore` class marked with `@Observable` that manages an array of items.
3. Methods to add, toggle, and delete items in the store.
4. A main view with a text field, add button, and list.
5. A row view that shows a checkmark icon and the title (with strikethrough when completed).
6. Swipe-to-delete support.

### Bonus Challenges

- Add a segmented filter (All / Active / Completed).
- Display a count of remaining items.
- Add a "Clear Completed" button.
- Sort items so incomplete items appear before completed ones.

### Reference Solution

See [Demo02-TodoApp.swift](../demos/Demo02-TodoApp.swift) for a complete, commented implementation.

---

## Vocabulary

| Term | Definition |
|------|-----------|
| **Data model** | A struct or class that represents the data your app works with |
| **@Observable** | A macro that makes a class's property changes visible to SwiftUI |
| **Identifiable** | A protocol requiring a unique `id` so SwiftUI can track items |
| **UUID** | A universally unique identifier, useful for giving each model instance a distinct ID |
| **Reference type** | A class instance that is shared (not copied) when passed around |
| **Value type** | A struct instance that is copied when passed around |

---

## Homework

1. Add a `priority` property to `TodoItem` (high, medium, low) and display a colored dot next to each item.
2. Add a detail view for each todo item that lets you edit the title.
3. Think about your final project: write down what data models you would need and what properties each would have. Bring your list to next week's class.
