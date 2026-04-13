// ============================================================
// Demo02-TodoApp.swift
// A complete Todo app built with SwiftUI and @Observable.
//
// Concepts demonstrated:
//   - @Observable for reactive data management
//   - @State and @Binding for view-level state
//   - List, ForEach, .onDelete for displaying and removing items
//   - TextField and Button for user input
//   - NavigationStack and .navigationTitle
//   - Segmented Picker for filtering
//   - Computed properties for derived data
//
// How to use:
//   1. Create a new Xcode project (App template, SwiftUI).
//   2. Replace the contents of ContentView.swift with this file.
//   3. Make sure the deployment target is iOS 17+ (for @Observable).
//   4. Run in the simulator or preview canvas.
// ============================================================

import SwiftUI

// MARK: - Data Model
// Each todo item is a simple struct with a unique ID, a title,
// a completion flag, and the date it was created.

struct TodoItem: Identifiable {
    let id = UUID()                  // Unique identifier for SwiftUI lists
    var title: String                // What the user typed
    var isCompleted: Bool = false    // Starts uncompleted
    let createdDate: Date = Date()  // Timestamp for sorting or display
}

// MARK: - Data Store (@Observable)
// This class holds the array of todos and all the logic to
// add, toggle, and delete items. Because it is @Observable,
// any SwiftUI view that reads its properties will automatically
// re-render when those properties change.

@Observable
class TodoStore {
    var items: [TodoItem] = [
        // Sample data so the app is not empty on first launch.
        TodoItem(title: "Learn SwiftUI basics"),
        TodoItem(title: "Build a profile card", isCompleted: true),
        TodoItem(title: "Practice @State and @Binding"),
        TodoItem(title: "Create a todo app"),
    ]

    // ── Add a new item ──
    // Creates a TodoItem from the given title and appends it.
    func addItem(title: String) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let newItem = TodoItem(title: title)
        items.insert(newItem, at: 0)  // Insert at top so new items are visible
    }

    // ── Toggle completion ──
    // Finds the item by ID and flips its isCompleted flag.
    func toggleItem(_ item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
        }
    }

    // ── Delete items ──
    // Called by .onDelete; receives the index set of items to remove.
    func deleteItems(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    // ── Clear all completed items ──
    func clearCompleted() {
        items.removeAll { $0.isCompleted }
    }

    // ── Computed: count of remaining (incomplete) items ──
    var remainingCount: Int {
        items.filter { !$0.isCompleted }.count
    }
}

// MARK: - Filter Enum
// Used by the segmented picker to filter the list display.

enum TodoFilter: String, CaseIterable {
    case all = "All"
    case active = "Active"
    case completed = "Done"
}

// MARK: - Main View (TodoAppView)
// The top-level view that owns the store and new-item text field state.

struct TodoAppView: View {
    // The data store. @State works with @Observable classes in iOS 17+.
    @State private var store = TodoStore()

    // The text the user is typing for a new todo.
    @State private var newItemTitle = ""

    // The currently selected filter tab.
    @State private var filter: TodoFilter = .all

    // ── Filtered items based on the selected tab ──
    var filteredItems: [TodoItem] {
        switch filter {
        case .all:       return store.items
        case .active:    return store.items.filter { !$0.isCompleted }
        case .completed: return store.items.filter { $0.isCompleted }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // ── Input Row ──
                // A text field and "Add" button pinned above the list.
                HStack {
                    TextField("What needs to be done?", text: $newItemTitle)
                        .textFieldStyle(.roundedBorder)

                    Button(action: addItem) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.blue)
                    }
                    .disabled(newItemTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                .padding()

                // ── Filter Picker ──
                Picker("Filter", selection: $filter) {
                    ForEach(TodoFilter.allCases, id: \.self) { f in
                        Text(f.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // ── Todo List ──
                List {
                    ForEach(filteredItems) { item in
                        TodoRowView(item: item) {
                            store.toggleItem(item)
                        }
                    }
                    .onDelete(perform: deleteFromFiltered)
                }
                .listStyle(.plain)

                // ── Footer ──
                HStack {
                    Text("\(store.remainingCount) item\(store.remainingCount == 1 ? "" : "s") remaining")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    Spacer()

                    // "Clear Completed" button -- only visible when there
                    // are completed items to clear.
                    if store.items.contains(where: { $0.isCompleted }) {
                        Button("Clear Completed", role: .destructive) {
                            store.clearCompleted()
                        }
                        .font(.footnote)
                    }
                }
                .padding()
            }
            .navigationTitle("My Todos")
        }
    }

    // ── Add Item Action ──
    func addItem() {
        store.addItem(title: newItemTitle)
        newItemTitle = ""  // Clear the text field
    }

    // ── Delete from Filtered List ──
    // Because the list shows filteredItems, the offsets correspond
    // to filteredItems, not store.items. We need to map back.
    func deleteFromFiltered(at offsets: IndexSet) {
        let idsToDelete = offsets.map { filteredItems[$0].id }
        store.items.removeAll { idsToDelete.contains($0.id) }
    }
}

// MARK: - Todo Row View
// A single row in the list. Displays a toggle circle and the title.

struct TodoRowView: View {
    let item: TodoItem        // The data for this row (read-only)
    var onToggle: () -> Void  // Callback when the user taps the circle

    var body: some View {
        HStack(spacing: 12) {
            // ── Completion Toggle Button ──
            Button(action: onToggle) {
                Image(systemName: item.isCompleted
                      ? "checkmark.circle.fill"
                      : "circle")
                    .font(.title3)
                    .foregroundStyle(item.isCompleted ? .green : .gray)
            }
            .buttonStyle(.plain)  // Prevents the button from highlighting the whole row

            // ── Title ──
            Text(item.title)
                .strikethrough(item.isCompleted)              // Line through if done
                .foregroundStyle(item.isCompleted ? .secondary : .primary)

            Spacer()
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview

#Preview {
    TodoAppView()
}
