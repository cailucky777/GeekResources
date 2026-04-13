# API Integration in iOS Applications: A Complete Tutorial

A detailed guide to connecting your iOS app to APIs — from basic HTTP requests to advanced networking patterns.

---

## Table of Contents

1. [What is an API?](#what-is-an-api)
2. [Part 1: HTTP Fundamentals](#part-1-http-fundamentals)
3. [Part 2: URLSession — Built-in Networking](#part-2-urlsession--built-in-networking)
4. [Part 3: JSON Parsing with Codable](#part-3-json-parsing-with-codable)
5. [Part 4: Building a Complete API Client](#part-4-building-a-complete-api-client)
6. [Part 5: Connecting API Data to SwiftUI](#part-5-connecting-api-data-to-swiftui)
7. [Part 6: Authentication and Security](#part-6-authentication-and-security)
8. [Part 7: Advanced Networking Patterns](#part-7-advanced-networking-patterns)
9. [Part 8: Third-Party Libraries](#part-8-third-party-libraries)
10. [Part 9: Real-World Project — Building a Weather App](#part-9-real-world-project--building-a-weather-app)
11. [Part 10: Best Practices and Common Pitfalls](#part-10-best-practices-and-common-pitfalls)

---

## What is an API?

An **API (Application Programming Interface)** is a set of rules and protocols that allows your app to communicate with external services. When your iOS app fetches weather data, loads social media feeds, or processes payments, it's using APIs.

### How API Communication Works

```
┌──────────────┐     HTTP Request      ┌──────────────┐
│              │ ─────────────────────► │              │
│   iOS App    │   GET /users/123      │  API Server  │
│  (Client)    │                       │              │
│              │ ◄───────────────────── │              │
└──────────────┘     HTTP Response     └──────────────┘
                   { "name": "Alice" }
```

### Types of APIs You'll Encounter

| Type | Description | Example |
|---|---|---|
| **REST API** | Most common; uses HTTP methods (GET, POST, PUT, DELETE) | GitHub API, Twitter API |
| **GraphQL** | Query-based; client specifies exactly what data it needs | GitHub GraphQL API, Shopify |
| **WebSocket** | Real-time two-way communication | Chat apps, live data feeds |
| **gRPC** | High-performance binary protocol | Internal microservices |

This tutorial focuses primarily on **REST APIs**, as they are the most widely used.

---

## Part 1: HTTP Fundamentals

### HTTP Methods

| Method | Purpose | Example |
|---|---|---|
| `GET` | Retrieve data | Get a list of users |
| `POST` | Create new data | Create a new user |
| `PUT` | Update entire resource | Update all user fields |
| `PATCH` | Partially update resource | Update just the email |
| `DELETE` | Remove data | Delete a user |

### HTTP Status Codes

| Code Range | Meaning | Common Codes |
|---|---|---|
| `2xx` | Success | `200 OK`, `201 Created`, `204 No Content` |
| `3xx` | Redirect | `301 Moved Permanently`, `304 Not Modified` |
| `4xx` | Client Error | `400 Bad Request`, `401 Unauthorized`, `404 Not Found`, `429 Rate Limited` |
| `5xx` | Server Error | `500 Internal Server Error`, `503 Service Unavailable` |

### Anatomy of an HTTP Request

```
GET /api/v1/users?page=1&limit=10 HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
Content-Type: application/json
Accept: application/json
```

### Anatomy of an HTTP Response

```
HTTP/1.1 200 OK
Content-Type: application/json
X-RateLimit-Remaining: 95

{
  "users": [
    {"id": 1, "name": "Alice", "email": "alice@example.com"},
    {"id": 2, "name": "Bob", "email": "bob@example.com"}
  ],
  "total": 42,
  "page": 1
}
```

---

## Part 2: URLSession — Built-in Networking

`URLSession` is Apple's built-in framework for making network requests. No third-party libraries needed.

### 2.1 Simple GET Request

```swift
import Foundation

func fetchData() async throws -> Data {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
    let (data, response) = try await URLSession.shared.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }

    return data
}

// Usage
Task {
    do {
        let data = try await fetchData()
        print(String(data: data, encoding: .utf8)!)
    } catch {
        print("Error: \(error)")
    }
}
```

### 2.2 POST Request

```swift
func createPost(title: String, body: String) async throws -> Data {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let payload: [String: Any] = [
        "title": title,
        "body": body,
        "userId": 1
    ]
    request.httpBody = try JSONSerialization.data(withJSONObject: payload)

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }

    return data
}
```

### 2.3 PUT and DELETE Requests

```swift
// PUT (Update)
func updatePost(id: Int, title: String, body: String) async throws -> Data {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")!

    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    let payload = ["id": id, "title": title, "body": body, "userId": 1] as [String: Any]
    request.httpBody = try JSONSerialization.data(withJSONObject: payload)

    let (data, _) = try await URLSession.shared.data(for: request)
    return data
}

// DELETE
func deletePost(id: Int) async throws {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")!

    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"

    let (_, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }
}
```

### 2.4 Adding Query Parameters

```swift
func searchUsers(query: String, page: Int) async throws -> Data {
    var components = URLComponents(string: "https://api.example.com/users")!
    components.queryItems = [
        URLQueryItem(name: "search", value: query),
        URLQueryItem(name: "page", value: String(page)),
        URLQueryItem(name: "limit", value: "20")
    ]

    guard let url = components.url else {
        throw URLError(.badURL)
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}
```

### 2.5 Setting Headers

```swift
var request = URLRequest(url: url)

// Common headers
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
request.setValue("application/json", forHTTPHeaderField: "Accept")
request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
request.setValue("en-US", forHTTPHeaderField: "Accept-Language")

// Custom headers
request.setValue("MyApp/1.0", forHTTPHeaderField: "User-Agent")
request.setValue("abc123", forHTTPHeaderField: "X-API-Key")
```

### 2.6 Configuring URLSession

```swift
// Custom configuration
let config = URLSessionConfiguration.default
config.timeoutIntervalForRequest = 30        // 30 seconds timeout
config.timeoutIntervalForResource = 300      // 5 minutes for large downloads
config.waitsForConnectivity = true            // Wait for network
config.httpAdditionalHeaders = [
    "Accept": "application/json",
    "X-App-Version": "1.0"
]

// Cache policy
config.requestCachePolicy = .returnCacheDataElseLoad

// Create session with custom config
let session = URLSession(configuration: config)

// Use the custom session
let (data, _) = try await session.data(from: url)
```

---

## Part 3: JSON Parsing with Codable

Swift's `Codable` protocol makes it easy to convert between JSON and Swift types.

### 3.1 Basic Codable

```swift
// Define your model
struct Post: Codable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

// Decode JSON to Swift object
func fetchPost(id: Int) async throws -> Post {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let post = try JSONDecoder().decode(Post.self, from: data)
    return post
}

// Encode Swift object to JSON
func encodePost(_ post: Post) throws -> Data {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    return try encoder.encode(post)
}
```

### 3.2 Handling Different JSON Key Formats

APIs often use `snake_case` while Swift uses `camelCase`:

```swift
struct User: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let emailAddress: String
    let createdAt: Date
}

// JSON from API:
// { "id": 1, "first_name": "Alice", "last_name": "Smith",
//   "email_address": "alice@example.com", "created_at": "2024-01-15T10:30:00Z" }

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
decoder.dateDecodingStrategy = .iso8601

let user = try decoder.decode(User.self, from: data)
```

### 3.3 Custom Coding Keys

When JSON keys don't match your property names:

```swift
struct Product: Codable {
    let id: Int
    let name: String
    let price: Double
    let imageURL: String
    let isAvailable: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name = "product_name"
        case price = "unit_price"
        case imageURL = "img_url"
        case isAvailable = "in_stock"
    }
}
```

### 3.4 Handling Nested JSON

```swift
// JSON structure:
// {
//   "status": "ok",
//   "data": {
//     "user": { "id": 1, "name": "Alice" },
//     "posts": [{ "id": 1, "title": "Hello" }]
//   }
// }

struct APIResponse: Codable {
    let status: String
    let data: ResponseData
}

struct ResponseData: Codable {
    let user: User
    let posts: [Post]
}

struct User: Codable {
    let id: Int
    let name: String
}

struct Post: Codable {
    let id: Int
    let title: String
}

// Decode
let response = try JSONDecoder().decode(APIResponse.self, from: data)
let user = response.data.user
let posts = response.data.posts
```

### 3.5 Handling Optional and Dynamic Fields

```swift
struct Article: Codable {
    let id: Int
    let title: String
    let subtitle: String?        // Optional field (may be null or missing)
    let tags: [String]?          // Optional array
    let metadata: [String: String]?  // Optional dictionary
}

// Handling dynamic/unknown keys
struct DynamicResponse: Codable {
    let results: [String: AnyCodable]  // Need a custom type for this
}

// A simpler approach: use JSONSerialization for truly dynamic data
func parseDynamic(data: Data) throws -> [String: Any] {
    guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
        throw URLError(.cannotParseResponse)
    }
    return json
}
```

### 3.6 Decoding Arrays

```swift
// When the API returns an array at the top level
// [{"id": 1, "title": "First"}, {"id": 2, "title": "Second"}]

func fetchAllPosts() async throws -> [Post] {
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([Post].self, from: data)
}
```

---

## Part 4: Building a Complete API Client

### 4.1 Defining the API Error Type

```swift
enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse(statusCode: Int)
    case decodingFailed(Error)
    case networkError(Error)
    case unauthorized
    case rateLimited(retryAfter: Int?)
    case serverError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse(let code):
            return "Invalid response (status code: \(code))"
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .unauthorized:
            return "Unauthorized — please check your credentials"
        case .rateLimited(let retry):
            if let retry {
                return "Rate limited — try again in \(retry) seconds"
            }
            return "Rate limited — please try again later"
        case .serverError(let code):
            return "Server error (status code: \(code))"
        }
    }
}
```

### 4.2 Building the HTTP Method Enum

```swift
enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
```

### 4.3 Creating the Endpoint Protocol

```swift
protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension APIEndpoint {
    var baseURL: String { "https://api.example.com" }
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }
}
```

### 4.4 Defining Endpoints

```swift
enum UserEndpoint: APIEndpoint {
    case list(page: Int, limit: Int)
    case detail(id: Int)
    case create(name: String, email: String)
    case update(id: Int, name: String)
    case delete(id: Int)

    var path: String {
        switch self {
        case .list:
            return "/api/v1/users"
        case .detail(let id), .update(let id, _), .delete(let id):
            return "/api/v1/users/\(id)"
        case .create:
            return "/api/v1/users"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .list, .detail: return .get
        case .create: return .post
        case .update: return .put
        case .delete: return .delete
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .list(let page, let limit):
            return [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
        default:
            return nil
        }
    }

    var body: Data? {
        switch self {
        case .create(let name, let email):
            return try? JSONEncoder().encode(["name": name, "email": email])
        case .update(_, let name):
            return try? JSONEncoder().encode(["name": name])
        default:
            return nil
        }
    }

    var headers: [String: String]? {
        switch self {
        case .create, .update:
            return ["Content-Type": "application/json"]
        default:
            return nil
        }
    }
}
```

### 4.5 The API Client

```swift
class APIClient {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared) {
        self.session = session

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }

    /// Generic request method
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        // Build URL
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw APIError.invalidURL
        }
        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        // Build request
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body

        // Add default headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        // Add endpoint-specific headers
        endpoint.headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        // Execute request
        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw APIError.networkError(error)
        }

        // Validate response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse(statusCode: -1)
        }

        switch httpResponse.statusCode {
        case 200...299:
            break  // Success
        case 401:
            throw APIError.unauthorized
        case 429:
            let retryAfter = httpResponse.value(forHTTPHeaderField: "Retry-After")
                .flatMap(Int.init)
            throw APIError.rateLimited(retryAfter: retryAfter)
        case 500...599:
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        default:
            throw APIError.invalidResponse(statusCode: httpResponse.statusCode)
        }

        // Decode response
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed(error)
        }
    }

    /// For requests that don't return a body (e.g., DELETE)
    func requestNoContent(_ endpoint: APIEndpoint) async throws {
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw APIError.invalidURL
        }
        components.queryItems = endpoint.queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        let (_, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            let code = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw APIError.invalidResponse(statusCode: code)
        }
    }
}
```

### 4.6 Using the API Client

```swift
// Models
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let createdAt: Date?
}

struct PaginatedResponse<T: Codable>: Codable {
    let data: [T]
    let total: Int
    let page: Int
}

// Usage
let client = APIClient()

// Fetch users
let response: PaginatedResponse<User> = try await client.request(
    UserEndpoint.list(page: 1, limit: 20)
)
print("Found \(response.total) users")

// Fetch single user
let user: User = try await client.request(UserEndpoint.detail(id: 1))
print("User: \(user.name)")

// Create user
let newUser: User = try await client.request(
    UserEndpoint.create(name: "Alice", email: "alice@example.com")
)

// Delete user
try await client.requestNoContent(UserEndpoint.delete(id: 1))
```

---

## Part 5: Connecting API Data to SwiftUI

### 5.1 ViewModel Pattern

```swift
import SwiftUI

@Observable
class UserListViewModel {
    var users: [User] = []
    var isLoading = false
    var errorMessage: String?
    var currentPage = 1

    private let client = APIClient()

    func fetchUsers() async {
        isLoading = true
        errorMessage = nil

        do {
            let response: PaginatedResponse<User> = try await client.request(
                UserEndpoint.list(page: currentPage, limit: 20)
            )
            users = response.data
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func loadNextPage() async {
        currentPage += 1
        await fetchUsers()
    }

    func deleteUser(_ user: User) async {
        do {
            try await client.requestNoContent(UserEndpoint.delete(id: user.id))
            users.removeAll { $0.id == user.id }
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
```

### 5.2 SwiftUI View

```swift
struct UserListView: View {
    @State private var viewModel = UserListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.users.isEmpty {
                    ProgressView("Loading users...")
                } else if let error = viewModel.errorMessage, viewModel.users.isEmpty {
                    ContentUnavailableView {
                        Label("Error", systemImage: "exclamationmark.triangle")
                    } description: {
                        Text(error)
                    } actions: {
                        Button("Retry") {
                            Task { await viewModel.fetchUsers() }
                        }
                    }
                } else {
                    List {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: UserDetailView(user: user)) {
                                UserRowView(user: user)
                            }
                        }
                        .onDelete { indexSet in
                            Task {
                                for index in indexSet {
                                    await viewModel.deleteUser(viewModel.users[index])
                                }
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.fetchUsers()
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

struct UserRowView: View {
    let user: User

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user.name)
                .font(.headline)
            Text(user.email)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}
```

### 5.3 Loading Images from URLs

```swift
// Built-in AsyncImage (iOS 15+)
struct UserAvatarView: View {
    let avatarURL: URL?

    var body: some View {
        AsyncImage(url: avatarURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
            case .failure:
                Image(systemName: "person.circle.fill")
                    .foregroundStyle(.gray)
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 50, height: 50)
    }
}
```

### 5.4 Search with Debouncing

```swift
@Observable
class SearchViewModel {
    var query = ""
    var results: [User] = []
    var isSearching = false

    private let client = APIClient()
    private var searchTask: Task<Void, Never>?

    func search() {
        // Cancel previous search
        searchTask?.cancel()

        guard !query.isEmpty else {
            results = []
            return
        }

        searchTask = Task {
            // Debounce: wait 300ms before searching
            try? await Task.sleep(for: .milliseconds(300))

            guard !Task.isCancelled else { return }

            isSearching = true
            do {
                let response: PaginatedResponse<User> = try await client.request(
                    UserEndpoint.list(page: 1, limit: 20)
                    // In a real app, pass the query to the API
                )
                if !Task.isCancelled {
                    results = response.data
                }
            } catch {
                if !Task.isCancelled {
                    results = []
                }
            }
            isSearching = false
        }
    }
}

struct SearchView: View {
    @State private var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.results) { user in
                Text(user.name)
            }
            .overlay {
                if viewModel.isSearching {
                    ProgressView()
                }
            }
            .searchable(text: $viewModel.query)
            .onChange(of: viewModel.query) {
                viewModel.search()
            }
            .navigationTitle("Search Users")
        }
    }
}
```

---

## Part 6: Authentication and Security

### 6.1 API Key Authentication

```swift
// Store API keys securely (NEVER hardcode in source code!)
// Option 1: Environment variable / .xcconfig file
// Option 2: Keychain

class AuthenticatedAPIClient: APIClient {
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
        super.init()
    }

    // Override to add API key to all requests
    func authenticatedRequest<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        // Modify the endpoint to include the API key header
        // In practice, you'd modify the URLRequest before sending
        return try await request(endpoint)
    }
}
```

### 6.2 OAuth 2.0 / Bearer Token Authentication

```swift
// Token-based authentication
class TokenManager {
    private let keychain = KeychainHelper.shared

    var accessToken: String? {
        get { keychain.read(key: "accessToken") }
        set {
            if let newValue {
                keychain.save(key: "accessToken", value: newValue)
            } else {
                keychain.delete(key: "accessToken")
            }
        }
    }

    var refreshToken: String? {
        get { keychain.read(key: "refreshToken") }
        set {
            if let newValue {
                keychain.save(key: "refreshToken", value: newValue)
            } else {
                keychain.delete(key: "refreshToken")
            }
        }
    }
}

// Simple Keychain Helper
class KeychainHelper {
    static let shared = KeychainHelper()

    func save(key: String, value: String) {
        let data = value.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    func read(key: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        guard let data = result as? Data else { return nil }
        return String(data: data, encoding: .utf8)
    }

    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
}
```

### 6.3 Login Flow

```swift
struct LoginCredentials: Codable {
    let email: String
    let password: String
}

struct AuthResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
}

func login(email: String, password: String) async throws -> AuthResponse {
    let url = URL(string: "https://api.example.com/auth/login")!

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(
        LoginCredentials(email: email, password: password)
    )

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
        throw APIError.unauthorized
    }

    let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)

    // Store tokens securely
    let tokenManager = TokenManager()
    tokenManager.accessToken = authResponse.accessToken
    tokenManager.refreshToken = authResponse.refreshToken

    return authResponse
}
```

### 6.4 Token Refresh

```swift
func refreshAccessToken() async throws -> String {
    let tokenManager = TokenManager()

    guard let refreshToken = tokenManager.refreshToken else {
        throw APIError.unauthorized
    }

    let url = URL(string: "https://api.example.com/auth/refresh")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(["refreshToken": refreshToken])

    let (data, _) = try await URLSession.shared.data(for: request)
    let response = try JSONDecoder().decode(AuthResponse.self, from: data)

    tokenManager.accessToken = response.accessToken
    tokenManager.refreshToken = response.refreshToken

    return response.accessToken
}
```

### 6.5 App Transport Security (ATS)

iOS enforces HTTPS by default. If you need to connect to an HTTP endpoint (not recommended for production):

```xml
<!-- Info.plist -->
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSExceptionDomains</key>
    <dict>
        <key>api.example.com</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
        </dict>
    </dict>
</dict>
```

> **Warning:** Only use this for development/testing. Production apps should always use HTTPS.

---

## Part 7: Advanced Networking Patterns

### 7.1 Retry Logic

```swift
func requestWithRetry<T: Decodable>(
    _ endpoint: APIEndpoint,
    maxRetries: Int = 3,
    client: APIClient = APIClient()
) async throws -> T {
    var lastError: Error?

    for attempt in 0..<maxRetries {
        do {
            return try await client.request(endpoint)
        } catch APIError.rateLimited(let retryAfter) {
            let delay = retryAfter ?? (2 * (attempt + 1))
            try await Task.sleep(for: .seconds(delay))
            lastError = APIError.rateLimited(retryAfter: retryAfter)
        } catch APIError.serverError {
            // Exponential backoff for server errors
            let delay = pow(2.0, Double(attempt))
            try await Task.sleep(for: .seconds(delay))
            lastError = APIError.serverError(statusCode: 500)
        } catch {
            throw error  // Don't retry client errors
        }
    }

    throw lastError ?? APIError.networkError(URLError(.timedOut))
}
```

### 7.2 Caching Responses

```swift
class CachedAPIClient {
    private let client = APIClient()
    private let cache = NSCache<NSString, CacheEntry>()

    class CacheEntry {
        let data: Any
        let timestamp: Date

        init(data: Any) {
            self.data = data
            self.timestamp = Date()
        }

        func isValid(maxAge: TimeInterval) -> Bool {
            return Date().timeIntervalSince(timestamp) < maxAge
        }
    }

    func request<T: Decodable>(
        _ endpoint: APIEndpoint,
        cacheMaxAge: TimeInterval = 300  // 5 minutes
    ) async throws -> T {
        let cacheKey = NSString(string: "\(endpoint.path)")

        // Check cache
        if let entry = cache.object(forKey: cacheKey),
           entry.isValid(maxAge: cacheMaxAge),
           let cached = entry.data as? T {
            return cached
        }

        // Fetch from network
        let result: T = try await client.request(endpoint)

        // Store in cache
        cache.setObject(CacheEntry(data: result), forKey: cacheKey)

        return result
    }
}
```

### 7.3 Uploading Files (Multipart Form Data)

```swift
func uploadImage(_ image: UIImage, to endpoint: String) async throws -> Data {
    let url = URL(string: endpoint)!
    let boundary = UUID().uuidString

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue(
        "multipart/form-data; boundary=\(boundary)",
        forHTTPHeaderField: "Content-Type"
    )

    var body = Data()

    // Add image data
    if let imageData = image.jpegData(compressionQuality: 0.8) {
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append(
            "Content-Disposition: form-data; name=\"image\"; filename=\"photo.jpg\"\r\n"
                .data(using: .utf8)!
        )
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
    }

    // Close boundary
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)

    request.httpBody = body

    let (data, _) = try await URLSession.shared.data(for: request)
    return data
}
```

### 7.4 Download with Progress

```swift
class DownloadManager: NSObject, URLSessionDownloadDelegate {
    var progressHandler: ((Double) -> Void)?
    var completionHandler: ((URL?, Error?) -> Void)?

    private lazy var session: URLSession = {
        URLSession(configuration: .default, delegate: self, delegateQueue: nil)
    }()

    func download(from url: URL) {
        let task = session.downloadTask(with: url)
        task.resume()
    }

    // Progress callback
    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didWriteData bytesWritten: Int64,
        totalBytesWritten: Int64,
        totalBytesExpectedToWrite: Int64
    ) {
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        DispatchQueue.main.async {
            self.progressHandler?(progress)
        }
    }

    // Completion callback
    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didFinishDownloadingTo location: URL
    ) {
        DispatchQueue.main.async {
            self.completionHandler?(location, nil)
        }
    }
}
```

### 7.5 WebSocket Connections

```swift
class WebSocketManager {
    private var webSocketTask: URLSessionWebSocketTask?

    func connect(to url: URL) {
        webSocketTask = URLSession.shared.webSocketTask(with: url)
        webSocketTask?.resume()
        listen()
    }

    func send(_ message: String) async throws {
        try await webSocketTask?.send(.string(message))
    }

    private func listen() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Received: \(text)")
                case .data(let data):
                    print("Received data: \(data.count) bytes")
                @unknown default:
                    break
                }
                // Continue listening
                self?.listen()

            case .failure(let error):
                print("WebSocket error: \(error)")
            }
        }
    }

    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
}
```

---

## Part 8: Third-Party Libraries

### 8.1 Adding Dependencies with Swift Package Manager (SPM)

1. In Xcode, go to **File > Add Package Dependencies**.
2. Enter the package URL.
3. Select the version rule (e.g., "Up to Next Major Version").
4. Click **Add Package**.

### 8.2 Alamofire (Popular Networking Library)

Package URL: `https://github.com/Alamofire/Alamofire`

```swift
import Alamofire

// Simple GET request
func fetchUsers() async throws -> [User] {
    let response = await AF.request("https://api.example.com/users")
        .serializingDecodable([User].self)
        .response

    switch response.result {
    case .success(let users):
        return users
    case .failure(let error):
        throw error
    }
}

// POST with parameters
func createUser(name: String, email: String) async throws -> User {
    let parameters: [String: String] = [
        "name": name,
        "email": email
    ]

    let response = await AF.request(
        "https://api.example.com/users",
        method: .post,
        parameters: parameters,
        encoder: JSONParameterEncoder.default
    )
    .serializingDecodable(User.self)
    .response

    switch response.result {
    case .success(let user):
        return user
    case .failure(let error):
        throw error
    }
}

// Upload with progress
AF.upload(multipartFormData: { formData in
    formData.append(imageData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
}, to: "https://api.example.com/upload")
.uploadProgress { progress in
    print("Upload progress: \(progress.fractionCompleted)")
}
.response { response in
    print("Upload complete")
}
```

### 8.3 Kingfisher (Image Loading & Caching)

Package URL: `https://github.com/onevcat/Kingfisher`

```swift
import Kingfisher
import SwiftUI

struct UserAvatarView: View {
    let avatarURL: URL?

    var body: some View {
        KFImage(avatarURL)
            .placeholder {
                ProgressView()
            }
            .retry(maxCount: 3)
            .cacheOriginalImage()
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
    }
}
```

---

## Part 9: Real-World Project — Building a Weather App

Let's build a complete weather app using the OpenWeatherMap API as an example.

### 9.1 Project Setup

1. Create a new Xcode project (iOS > App, SwiftUI).
2. Get a free API key from a weather API provider.

### 9.2 Define Models

```swift
// Models/Weather.swift
struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: [DayForecast]
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
}

struct CurrentWeather: Codable {
    let tempC: Double
    let tempF: Double
    let condition: WeatherCondition
    let humidity: Int
    let windKph: Double
    let feelslikeC: Double
    let uv: Double
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
    let code: Int
}

struct DayForecast: Codable, Identifiable {
    var id: String { date }
    let date: String
    let day: DayDetail
}

struct DayDetail: Codable {
    let maxtempC: Double
    let mintempC: Double
    let condition: WeatherCondition
    let dailyChanceOfRain: Int
}
```

### 9.3 Build the API Client

```swift
// Services/WeatherService.swift
enum WeatherEndpoint: APIEndpoint {
    case current(city: String)
    case forecast(city: String, days: Int)

    var baseURL: String { "https://api.weatherapi.com/v1" }

    var path: String {
        switch self {
        case .current: return "/current.json"
        case .forecast: return "/forecast.json"
        }
    }

    var method: HTTPMethod { .get }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .current(let city):
            return [
                URLQueryItem(name: "key", value: WeatherConfig.apiKey),
                URLQueryItem(name: "q", value: city)
            ]
        case .forecast(let city, let days):
            return [
                URLQueryItem(name: "key", value: WeatherConfig.apiKey),
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "days", value: String(days))
            ]
        }
    }
}

// IMPORTANT: Store API keys securely, not in source code
enum WeatherConfig {
    static var apiKey: String {
        // In production, load from Keychain or .xcconfig
        ProcessInfo.processInfo.environment["WEATHER_API_KEY"] ?? ""
    }
}
```

### 9.4 Build the ViewModel

```swift
// ViewModels/WeatherViewModel.swift
import SwiftUI
import CoreLocation

@Observable
class WeatherViewModel {
    var currentWeather: CurrentWeather?
    var location: Location?
    var forecast: [DayForecast] = []
    var isLoading = false
    var errorMessage: String?
    var searchCity = "San Francisco"

    private let client = APIClient()

    func fetchWeather() async {
        isLoading = true
        errorMessage = nil

        do {
            let response: WeatherResponse = try await client.request(
                WeatherEndpoint.forecast(city: searchCity, days: 5)
            )
            currentWeather = response.current
            location = response.location
            forecast = response.forecast
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
```

### 9.5 Build the UI

```swift
// Views/WeatherView.swift
struct WeatherView: View {
    @State private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Search bar
                    HStack {
                        TextField("City name", text: $viewModel.searchCity)
                            .textFieldStyle(.roundedBorder)
                        Button("Search") {
                            Task { await viewModel.fetchWeather() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.horizontal)

                    if viewModel.isLoading {
                        ProgressView("Loading weather...")
                            .padding(.top, 50)
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                            .padding()
                    } else if let weather = viewModel.currentWeather,
                              let location = viewModel.location {
                        // Current weather card
                        CurrentWeatherCard(
                            weather: weather,
                            location: location
                        )

                        // Forecast
                        ForecastSection(forecast: viewModel.forecast)
                    }
                }
            }
            .navigationTitle("Weather")
            .task {
                await viewModel.fetchWeather()
            }
        }
    }
}

struct CurrentWeatherCard: View {
    let weather: CurrentWeather
    let location: Location

    var body: some View {
        VStack(spacing: 12) {
            Text(location.name)
                .font(.title2)
                .fontWeight(.semibold)

            Text("\(Int(weather.tempC))°C")
                .font(.system(size: 64, weight: .thin))

            Text(weather.condition.text)
                .font(.title3)
                .foregroundStyle(.secondary)

            HStack(spacing: 30) {
                Label("\(weather.humidity)%", systemImage: "humidity")
                Label("\(Int(weather.windKph)) km/h", systemImage: "wind")
                Label("UV \(Int(weather.uv))", systemImage: "sun.max")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}

struct ForecastSection: View {
    let forecast: [DayForecast]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("5-Day Forecast")
                .font(.headline)
                .padding(.horizontal)

            ForEach(forecast) { day in
                HStack {
                    Text(day.date)
                        .frame(width: 100, alignment: .leading)

                    Spacer()

                    Text(day.day.condition.text)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text("\(Int(day.day.mintempC))° / \(Int(day.day.maxtempC))°")
                        .font(.subheadline)
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal)
    }
}
```

---

## Part 10: Best Practices and Common Pitfalls

### Best Practices

1. **Always use HTTPS.** iOS enforces this by default — don't disable ATS in production.

2. **Never hardcode API keys.** Use `.xcconfig` files, environment variables, or Keychain storage.

3. **Handle all error states.** Show meaningful error messages to users, not raw error dumps.

4. **Use `Codable` for JSON parsing.** Avoid manual JSON parsing with `JSONSerialization` when possible.

5. **Cancel unnecessary requests.** When a view disappears, cancel in-flight requests:

```swift
.task {
    await viewModel.fetchData()  // Automatically cancelled when view disappears
}
```

6. **Decode on a background thread.** URLSession already returns on a background thread — don't block the main thread:

```swift
// Good: Decoding happens off the main thread
func fetchUsers() async throws -> [User] {
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([User].self, from: data)  // Still on background thread
}
```

7. **Use `@MainActor` for UI updates:**

```swift
@MainActor
@Observable
class ViewModel {
    var data: [Item] = []  // UI-bound properties on main actor
}
```

8. **Implement pagination for large datasets.** Don't load everything at once.

9. **Cache appropriately.** Use `URLCache` for HTTP caching, `NSCache` for in-memory caching.

10. **Test your networking code.** Use protocol-based design for easy mocking:

```swift
protocol NetworkSession {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}

// In tests, create a mock:
class MockSession: NetworkSession {
    var mockData: Data?
    var mockResponse: URLResponse?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return (mockData!, mockResponse!)
    }
}
```

### Common Pitfalls

| Pitfall | Solution |
|---|---|
| Updating UI from background thread | Use `@MainActor` or `DispatchQueue.main.async` |
| Not handling network errors | Always use do-catch and show user-friendly messages |
| Memory leaks from retain cycles | Use `[weak self]` in closures or prefer async/await |
| Hardcoded API keys in source code | Use .xcconfig, Keychain, or environment variables |
| Not validating HTTP status codes | Always check response status before decoding |
| Ignoring rate limits | Implement retry-after logic and exponential backoff |
| Loading full images at original resolution | Use thumbnail URLs or resize images client-side |
| Not testing offline scenarios | Use Network Link Conditioner to test slow/no connectivity |
| Blocking main thread with synchronous calls | Always use async/await or completion handlers |
| Not cancelling requests when views disappear | Use `.task` modifier — it handles cancellation automatically |

---

## Glossary

| Term | Definition |
|---|---|
| **API** | Application Programming Interface — a way for apps to communicate with servers |
| **REST** | Representational State Transfer — an architectural style for APIs |
| **JSON** | JavaScript Object Notation — a lightweight data format |
| **HTTP** | Hypertext Transfer Protocol — the protocol for web communication |
| **HTTPS** | HTTP Secure — encrypted HTTP communication |
| **URLSession** | Apple's framework for making network requests |
| **Codable** | Swift protocol for encoding/decoding data (JSON, plist, etc.) |
| **OAuth** | Open Authorization — a standard for secure API access delegation |
| **Bearer Token** | An authentication token sent in the Authorization header |
| **Rate Limiting** | Server-imposed limits on how many requests you can make |
| **Pagination** | Breaking large datasets into smaller pages |
| **ATS** | App Transport Security — iOS requirement for HTTPS |
| **SPM** | Swift Package Manager — Apple's dependency manager |

---

## Next Steps

After completing this tutorial, explore:

1. **GraphQL with Apollo iOS** — for more flexible API queries.
2. **Combine framework** — reactive programming for networking.
3. **SwiftData / Core Data** — for local data persistence alongside API data.
4. **Push Notifications (APNs)** — for real-time server-to-app communication.
5. **CloudKit** — Apple's cloud database service (no custom server needed).
6. **Firebase** — Google's backend-as-a-service for iOS apps.

### Recommended Resources

| Resource | Link |
|---|---|
| Hacking with Swift: Networking | [hackingwithswift.com/quick-start/swiftui](https://www.hackingwithswift.com/quick-start/swiftui) |
| Swift by Sundell: Networking | [swiftbysundell.com/basics/](https://www.swiftbysundell.com/basics/#filter) |
| Apple: URLSession Docs | [developer.apple.com/documentation/foundation/urlsession](https://developer.apple.com/documentation/foundation/urlsession) |
| Codecademy: Learn Swift | [codecademy.com/learn/learn-swift](https://www.codecademy.com/learn/learn-swift) |

---

*Document generated on April 2026. APIs and frameworks may evolve — always consult the latest documentation.*
