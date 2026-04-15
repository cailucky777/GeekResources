# A Tiny Backend for Your iOS App

Your iOS app talks to the internet. Sometimes you need **the other side** of that conversation — a small server you wrote, running something only you want.

This walks through the simplest possible backend in two flavors: Python (Flask) and JavaScript (Express).

---

## Why You Might Want One

- **Hide an API key** from users (see `../09-AI-Integration/Safety-First-API-Keys.md`).
- **Aggregate data** that many users share (leaderboards, chatrooms).
- **Run something the phone can't** (cron job, heavy computation).
- **Let your web version share a backend** with your iOS version.

---

## Option A: Python + Flask

### Setup

```bash
mkdir myapi && cd myapi
python3 -m venv .venv && source .venv/bin/activate
pip install flask
```

### `app.py`

```python
from flask import Flask, jsonify, request

app = Flask(__name__)
TODOS = []
NEXT_ID = 1

@app.get("/todos")
def list_todos():
    return jsonify(TODOS)

@app.post("/todos")
def create_todo():
    global NEXT_ID
    data = request.get_json()
    item = { "id": NEXT_ID, "title": data["title"], "done": False }
    NEXT_ID += 1
    TODOS.append(item)
    return jsonify(item), 201

if __name__ == "__main__":
    app.run(port=5050, debug=True)
```

### Run

```bash
python app.py
# then, in another terminal:
curl localhost:5050/todos
curl -X POST -H "Content-Type: application/json" \
     -d '{"title":"Study"}' localhost:5050/todos
```

---

## Option B: JavaScript + Express

### Setup

```bash
mkdir myapi && cd myapi
npm init -y
npm install express
```

### `server.js`

```javascript
const express = require("express");
const app = express();
app.use(express.json());

let todos = [];
let nextId = 1;

app.get("/todos", (req, res) => res.json(todos));

app.post("/todos", (req, res) => {
    const item = { id: nextId++, title: req.body.title, done: false };
    todos.push(item);
    res.status(201).json(item);
});

app.listen(5050, () => console.log("http://localhost:5050"));
```

### Run

```bash
node server.js
```

---

## Calling It From Your iOS App

Assuming your server is on your Mac at `http://localhost:5050` — and your iPhone and Mac are on the same Wi-Fi — use your Mac's LAN address (e.g., `192.168.1.42`).

Because this is HTTP (not HTTPS), add an **App Transport Security** exception **for development only**:

```xml
<!-- Info.plist -->
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsLocalNetworking</key>
  <true/>
</dict>
```

Then in Swift:

```swift
struct Todo: Codable, Identifiable {
    let id: Int
    let title: String
    let done: Bool
}

func fetchTodos() async throws -> [Todo] {
    let url = URL(string: "http://192.168.1.42:5050/todos")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return try JSONDecoder().decode([Todo].self, from: data)
}
```

---

## Deploying So It's Not Just on Your Mac

For actual shared use, deploy to:

- **Fly.io** (free tier, easy for Flask/Express).
- **Railway** / **Render** — similar.
- **Cloudflare Workers** (JS, different model).
- **Heroku** (paid, classic).

Each has a free tier and good step-by-step docs.

---

## Where to Put Secrets

Use environment variables on the server, not source code:

```bash
export ANTHROPIC_API_KEY=sk-ant-...
python app.py
```

In code:

```python
import os
key = os.environ["ANTHROPIC_API_KEY"]
```

---

## Exercise

Build a tiny "guess my number" server:

- `POST /start` → server picks a random 1–100, returns a game ID.
- `POST /guess` → body `{id, guess}` → returns `"higher" | "lower" | "correct"`.

Then call it from a SwiftUI view. That's a full-stack app you understand end-to-end.
