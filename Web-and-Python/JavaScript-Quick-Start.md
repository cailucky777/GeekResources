# JavaScript Quick Start

Enough to make your HTML page interactive.

---

## Running JavaScript

Two easy ways:

1. **In a browser.** Add `<script>...</script>` in an HTML file. Open in Chrome. Open DevTools (⌥⌘I) → Console.
2. **With Node.js.**
   ```bash
   brew install node
   node --version
   node script.js
   ```

---

## Syntax Essentials

```javascript
// Variables — prefer const, fall back to let. Avoid var.
const name = "Ada";
let score = 0;
score += 10;

// Template strings
const msg = `Hi, ${name}. Score: ${score}`;

// Arrays
const nums = [1, 2, 3];
nums.push(4);
nums.map(n => n * 2);       // [2, 4, 6, 8]
nums.filter(n => n > 2);    // [3, 4]

// Objects
const user = { name: "Ada", age: 16 };
console.log(user.name);

// Functions
function greet(name, times = 1) {
    return `Hi ${name}! `.repeat(times);
}

// Arrow functions (for short callbacks)
const sq = n => n * n;

// If / else
if (score > 0) { } else { }

// Loops
for (const n of nums) console.log(n);
nums.forEach((n, i) => console.log(i, n));

// Async
async function fetchData() {
    const r = await fetch("/api/items");
    return await r.json();
}
```

---

## DOM Basics (Making HTML Interactive)

```html
<button id="btn">Click me</button>
<p id="status"></p>

<script>
  const btn = document.getElementById("btn");
  const status = document.getElementById("status");
  let count = 0;

  btn.addEventListener("click", () => {
      count += 1;
      status.textContent = `Clicked ${count} times`;
  });
</script>
```

---

## Fetching From an API

```javascript
fetch("https://api.github.com/users/anthropics")
    .then(r => r.json())
    .then(data => console.log(data.name))
    .catch(err => console.error(err));

// Or with async/await:
async function showUser() {
    const r = await fetch("https://api.github.com/users/anthropics");
    const data = await r.json();
    document.getElementById("name").textContent = data.name;
}
showUser();
```

---

## Working with Local Storage

Persist small things in the browser:

```javascript
localStorage.setItem("theme", "dark");
const theme = localStorage.getItem("theme");
localStorage.removeItem("theme");
```

---

## When to Level Up

If you find yourself building more than one page:

- Consider a tiny framework: **Astro**, **SvelteKit**, or **Next.js**.
- Or just keep using plain JS and a few `.html` files — simple scales further than people say.

---

## Exercise

Take the landing page you built in `HTML-CSS-Quick-Start.md` and add:

1. A **dark-mode toggle button.** (Swap a CSS class, persist with `localStorage`.)
2. A **countdown to app launch** using `setInterval`.
3. Fetch the **current star count** of your project's GitHub repo and display it.

That's three different JS patterns in one afternoon.
