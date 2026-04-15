# FileManager Basics

> When `UserDefaults` isn't enough and SwiftData is too much.

Sometimes you just want to save a file — a JSON blob, a drawing, an exported PDF. `FileManager` is iOS's door to the file system.

---

## The Sandbox

Every iOS app lives in a **sandbox** — its own private folder. You can't read or write anywhere else. Inside the sandbox:

| Folder | Purpose | Backed up by iCloud? |
|---|---|---|
| **Documents/** | User-created content | ✅ Yes |
| **Caches/** | Stuff you can re-download | ❌ No |
| **tmp/** | Temporary scratch | ❌ No, cleared by system |

For student apps, **always use `Documents/`** unless you have a specific reason not to.

---

## Getting a File URL

```swift
func documentsURL(for filename: String) -> URL {
    let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    return docs.appendingPathComponent(filename)
}
```

---

## Write a String

```swift
let url = documentsURL(for: "notes.txt")
try "Hello, world!".write(to: url, atomically: true, encoding: .utf8)
```

## Read a String

```swift
let text = try String(contentsOf: url, encoding: .utf8)
```

---

## Save a Codable Object as JSON

```swift
struct Note: Codable, Identifiable {
    let id: UUID
    var title: String
    var body: String
}

func save(_ notes: [Note]) throws {
    let data = try JSONEncoder().encode(notes)
    try data.write(to: documentsURL(for: "notes.json"))
}

func load() throws -> [Note] {
    let url = documentsURL(for: "notes.json")
    guard FileManager.default.fileExists(atPath: url.path) else { return [] }
    let data = try Data(contentsOf: url)
    return try JSONDecoder().decode([Note].self, from: data)
}
```

---

## A Tiny Persistence Wrapper

```swift
@Observable
final class NotesStore {
    var notes: [Note] = []

    init() {
        notes = (try? load()) ?? []
    }

    func add(_ note: Note) {
        notes.append(note)
        try? save(notes)
    }

    func delete(_ id: UUID) {
        notes.removeAll { $0.id == id }
        try? save(notes)
    }

    // save() / load() as above
}
```

Use in SwiftUI:

```swift
struct ContentView: View {
    @State private var store = NotesStore()

    var body: some View {
        List(store.notes) { note in
            Text(note.title)
        }
    }
}
```

---

## Saving Images

```swift
let uiImage: UIImage = ...
if let data = uiImage.pngData() {
    try data.write(to: documentsURL(for: "avatar.png"))
}

// Load
if let data = try? Data(contentsOf: documentsURL(for: "avatar.png")),
   let image = UIImage(data: data) {
    // use image
}
```

---

## Peeking at Your Files (Simulator)

1. Run your app in the simulator.
2. In Xcode: **Devices and Simulators** window → your simulator → **Installed Apps** → your app → gear icon → **Download Container...**
3. Right-click the downloaded `.xcappdata` → **Show Package Contents** → `AppData/Documents/`.

You can now see exactly what your app saved.

---

## Common Mistakes

- **Hard-coding paths.** Always go through `FileManager.urls(for:)`.
- **Forgetting `try`.** File I/O can fail — handle errors or use `try?`.
- **Blocking the main thread on large files.** For anything big, wrap in `Task { ... }`.
- **Using `Caches/` for user data.** iOS may delete it without warning.

---

## Exercise

Build a **Journal** app:

1. A list of entries (each has a date and body).
2. Add/delete entries.
3. Save entries as JSON in `Documents/entries.json`.
4. Close and reopen the app — entries should still be there.

Bonus: also let the user attach an image to each entry.
