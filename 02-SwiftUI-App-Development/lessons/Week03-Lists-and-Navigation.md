# Week 3: Lists and Navigation

## Lesson Overview

This lesson covers two of SwiftUI's most important features: **Lists** for displaying collections of data, and **NavigationStack** for moving between screens. Students will combine both to build a contacts list app with detail views.

**Duration:** Two 50-minute sessions (or one 100-minute block)

---

## Learning Objectives

- Display dynamic data using `List` and `ForEach`.
- Make data models conform to `Identifiable`.
- Navigate between screens with `NavigationStack` and `NavigationLink`.
- Pass data to detail views.
- Add features like swipe-to-delete and search filtering.

---

## Part 1: List Basics

`List` is SwiftUI's way of displaying a scrollable column of rows, similar to a table view in UIKit.

### Static List

```swift
List {
    Text("Apple")
    Text("Banana")
    Text("Cherry")
}
```

### Dynamic List with an Array

```swift
struct FruitListView: View {
    let fruits = ["Apple", "Banana", "Cherry", "Date", "Elderberry"]

    var body: some View {
        List(fruits, id: \.self) { fruit in
            Text(fruit)
        }
    }
}
```

- `id: \.self` tells SwiftUI to use each string itself as a unique identifier.
- For custom types, we use the `Identifiable` protocol instead.

---

## Part 2: Custom Data Models with Identifiable

In real apps, list data comes from structs. SwiftUI requires each item to have a unique ID:

```swift
struct Contact: Identifiable {
    let id = UUID()       // Automatically generates a unique ID
    var name: String
    var phone: String
    var email: String
    var isFavorite: Bool
}
```

Now you can use it in a List without `id:`:

```swift
struct ContactListView: View {
    let contacts = [
        Contact(name: "Alice", phone: "555-0101", email: "alice@example.com", isFavorite: true),
        Contact(name: "Bob", phone: "555-0102", email: "bob@example.com", isFavorite: false),
        Contact(name: "Charlie", phone: "555-0103", email: "charlie@example.com", isFavorite: true),
    ]

    var body: some View {
        List(contacts) { contact in
            HStack {
                VStack(alignment: .leading) {
                    Text(contact.name)
                        .font(.headline)
                    Text(contact.phone)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if contact.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
            }
        }
    }
}
```

---

## Part 3: NavigationStack and NavigationLink

`NavigationStack` wraps your view hierarchy and enables push-style navigation. `NavigationLink` creates a tappable row that pushes a new view onto the stack.

```swift
struct ContactListView: View {
    let contacts: [Contact] // assume populated

    var body: some View {
        NavigationStack {
            List(contacts) { contact in
                NavigationLink(destination: ContactDetailView(contact: contact)) {
                    // This is what the row looks like
                    HStack {
                        Text(contact.name)
                        Spacer()
                        if contact.isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundStyle(.yellow)
                        }
                    }
                }
            }
            .navigationTitle("Contacts")
        }
    }
}
```

### The Detail View

```swift
struct ContactDetailView: View {
    let contact: Contact

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 80))
                .foregroundStyle(.blue)

            Text(contact.name)
                .font(.largeTitle)

            VStack(alignment: .leading, spacing: 12) {
                Label(contact.phone, systemImage: "phone.fill")
                Label(contact.email, systemImage: "envelope.fill")
            }
            .font(.title3)

            Spacer()
        }
        .padding()
        .navigationTitle(contact.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
```

> **Instructor Note:** Walk through the navigation flow step by step. Show the automatic back button, the slide gesture, and how `navigationTitle` appears in the navigation bar.

---

## Part 4: ForEach and Sections

When you need more control inside a List, use `ForEach`:

```swift
List {
    Section("Favorites") {
        ForEach(contacts.filter { $0.isFavorite }) { contact in
            NavigationLink(destination: ContactDetailView(contact: contact)) {
                Text(contact.name)
            }
        }
    }

    Section("All Contacts") {
        ForEach(contacts.filter { !$0.isFavorite }) { contact in
            NavigationLink(destination: ContactDetailView(contact: contact)) {
                Text(contact.name)
            }
        }
    }
}
```

---

## Part 5: Swipe to Delete

To support deletion, your data needs to be in a `@State` array, and you use `.onDelete`:

```swift
struct EditableContactListView: View {
    @State private var contacts = [
        Contact(name: "Alice", phone: "555-0101", email: "alice@example.com", isFavorite: true),
        Contact(name: "Bob", phone: "555-0102", email: "bob@example.com", isFavorite: false),
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(contacts) { contact in
                    Text(contact.name)
                }
                .onDelete(perform: deleteContact)
            }
            .navigationTitle("Contacts")
        }
    }

    func deleteContact(at offsets: IndexSet) {
        contacts.remove(atOffsets: offsets)
    }
}
```

> **Key point:** `.onDelete` only works on `ForEach`, not directly on `List`.

---

## Part 6: Searchable

SwiftUI makes adding a search bar easy with the `.searchable` modifier:

```swift
struct SearchableContactsView: View {
    let allContacts: [Contact]
    @State private var searchText = ""

    var filteredContacts: [Contact] {
        if searchText.isEmpty {
            return allContacts
        } else {
            return allContacts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredContacts) { contact in
                Text(contact.name)
            }
            .navigationTitle("Contacts")
            .searchable(text: $searchText, prompt: "Search contacts")
        }
    }
}
```

---

## Exercise: Build a Contacts List App

Combine everything from this lesson to create a complete contacts app:

### Requirements

1. Define a `Contact` struct conforming to `Identifiable`.
2. Create a list of at least 8 sample contacts.
3. Wrap the list in a `NavigationStack`.
4. Each row shows the contact's name and a star icon if they are a favorite.
5. Tapping a row navigates to a detail view showing name, phone, email, and an icon.
6. Support swipe-to-delete.
7. Add a search bar to filter contacts by name.

### Bonus Challenges

- Group contacts into "Favorites" and "Everyone Else" sections.
- Add an "Add Contact" button in the toolbar that presents a form sheet.
- Sort contacts alphabetically.

---

## Vocabulary

| Term | Definition |
|------|-----------|
| **List** | A scrollable container that displays rows of data |
| **ForEach** | Generates views from a collection of identifiable data |
| **Identifiable** | A protocol requiring a unique `id` property |
| **NavigationStack** | A container that manages a stack of views for push/pop navigation |
| **NavigationLink** | A view that pushes a destination view when tapped |
| **Section** | Groups rows inside a List with optional headers and footers |
| **.onDelete** | A modifier on ForEach that enables swipe-to-delete |
| **.searchable** | A modifier that adds a search bar to a navigation view |

---

## Homework

1. Add at least 5 more contacts to your app and organize them into alphabetical sections (A, B, C, etc.).
2. Create a "favorites-only" toggle in the toolbar that filters the list.
3. Design a more detailed contact row with an avatar placeholder (colored circle with initials).
