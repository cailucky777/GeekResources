# Python Quick Start

From zero to a useful script in an hour.

---

## 1. Install

macOS already ships with a version of Python, but don't use it for your own code. Install a fresh one:

```bash
brew install python
python3 --version        # should print 3.12+ or similar
```

---

## 2. Virtual Environments

A `venv` isolates your project's dependencies so they don't conflict with other projects.

```bash
cd my-project
python3 -m venv .venv
source .venv/bin/activate      # activate
pip install requests pandas    # install some libraries
deactivate                     # when you're done
```

Every Python project gets its own `.venv`. **Always activate before installing or running.**

Add to `.gitignore`:
```
.venv/
__pycache__/
*.pyc
```

---

## 3. Syntax Essentials

```python
# Variables (no `let`/`var` — just assign)
name = "Ada"
age = 16
pi = 3.14

# Types are inferred; you can annotate if you want:
score: int = 100

# Strings
greeting = f"Hello, {name}! You are {age}."

# Lists (like Swift arrays)
nums = [1, 2, 3]
nums.append(4)
first = nums[0]

# Dicts (like Swift dictionaries)
scores = {"alice": 10, "bob": 8}
print(scores["alice"])

# If / else
if age >= 18:
    print("adult")
elif age >= 13:
    print("teen")
else:
    print("kid")

# Loops
for n in range(5):       # 0 to 4
    print(n)

for k, v in scores.items():
    print(k, v)

# Functions
def greet(name: str, times: int = 1) -> str:
    return f"Hi {name}! " * times

print(greet("Mia", times=3))

# Comprehensions (very Pythonic)
squares = [n * n for n in range(10)]
even = [n for n in range(10) if n % 2 == 0]
```

---

## 4. A Useful First Script

Read a CSV, print the top 5 scorers.

```python
# top_students.py
import csv

with open("scores.csv") as f:
    rows = list(csv.DictReader(f))

# Each row looks like: {"name": "Ava", "score": "92"}
rows.sort(key=lambda r: int(r["score"]), reverse=True)

for row in rows[:5]:
    print(row["name"], row["score"])
```

Run it:

```bash
python top_students.py
```

---

## 5. Making HTTP Requests

```python
import requests

r = requests.get("https://api.github.com/users/anthropics")
print(r.status_code)         # 200
data = r.json()
print(data["name"], data["public_repos"])
```

---

## 6. Writing Your Own API Client

```python
import os, requests

ANTHROPIC_KEY = os.environ["CLAUDE_API_KEY"]  # from your shell env

def ask_claude(prompt: str) -> str:
    r = requests.post(
        "https://api.anthropic.com/v1/messages",
        headers={
            "x-api-key": ANTHROPIC_KEY,
            "anthropic-version": "2023-06-01",
            "content-type": "application/json",
        },
        json={
            "model": "claude-opus-4-6",
            "max_tokens": 512,
            "messages": [{"role": "user", "content": prompt}],
        },
    )
    return r.json()["content"][0]["text"]

print(ask_claude("Explain recursion in one sentence."))
```

Set the key once in your shell:

```bash
export CLAUDE_API_KEY=sk-ant-...
```

---

## 7. Next Libraries to Know

| Library | What It's For |
|---|---|
| **requests** | HTTP client |
| **pandas** | Spreadsheet-style data manipulation |
| **beautifulsoup4** | Parse HTML (web scraping) |
| **flask** or **fastapi** | Build small web APIs |
| **openai**, **anthropic** | Official AI client libraries |
| **pytest** | Testing |
| **rich** | Pretty terminal output |

---

## Exercise

Write a Python script that:

1. Opens a text file (any file you have).
2. Counts the 10 most common words.
3. Prints them nicely.

You now know Python well enough to automate your homework.
