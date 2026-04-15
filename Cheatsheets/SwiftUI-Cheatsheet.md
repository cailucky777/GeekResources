# SwiftUI Cheatsheet

## Basic Views

```swift
Text("Hello")
Image(systemName: "star.fill")
Image("my-asset")
Label("Home", systemImage: "house")
Button("Tap") { }
TextField("Name", text: $name)
Toggle("Enabled", isOn: $on)
Picker("Color", selection: $color) { Text("Red").tag("r") }
Slider(value: $volume, in: 0...1)
ProgressView()
```

## Layout

```swift
VStack(alignment: .leading, spacing: 8) { }
HStack(spacing: 12) { }
ZStack { }
Spacer()
LazyVGrid(columns: [GridItem(), GridItem()]) { }
```

## Modifiers

```swift
Text("Hi")
    .font(.title)
    .bold()
    .foregroundStyle(.blue)
    .padding()
    .background(.yellow)
    .clipShape(RoundedRectangle(cornerRadius: 12))
    .shadow(radius: 4)
    .frame(maxWidth: .infinity)
```

## State

```swift
@State private var count = 0
@Binding var selection: Int
@Observable class ViewModel { var items: [Item] = [] }
@Environment(\.colorScheme) var scheme
@AppStorage("dark") var dark = false
@Query private var todos: [Todo]
```

## Navigation

```swift
NavigationStack {
    List(items) { item in
        NavigationLink(item.name, value: item)
    }
    .navigationTitle("Items")
    .navigationDestination(for: Item.self) { ItemDetail(item: $0) }
}
```

## Presentation

```swift
.sheet(isPresented: $show) { SheetView() }
.fullScreenCover(isPresented: $show) { CoverView() }
.alert("Error", isPresented: $showAlert) { Button("OK") {} }
.confirmationDialog("Delete?", isPresented: $ask) { Button("Yes", role: .destructive) {} }
```

## List

```swift
List(items) { Text($0.name) }

List {
    Section("Chores") {
        ForEach(chores) { Text($0.title) }
            .onDelete { idx in chores.remove(atOffsets: idx) }
            .onMove   { s, d in chores.move(fromOffsets: s, toOffset: d) }
    }
}
```

## Animation

```swift
withAnimation { expanded.toggle() }

Text("Hi")
    .scaleEffect(big ? 1.5 : 1)
    .animation(.spring, value: big)
```

## Async

```swift
.task {
    do { items = try await api.fetch() }
    catch { self.error = error }
}

.refreshable { await reload() }
```

## Form

```swift
Form {
    Section("Profile") {
        TextField("Name", text: $name)
        Toggle("Notifications", isOn: $notify)
    }
    Section { Button("Save") {} }
}
```

## Safe Area + Paddings

```swift
.safeAreaInset(edge: .bottom) { Bar() }
.padding(.horizontal, 16)
.padding(.top)
```
