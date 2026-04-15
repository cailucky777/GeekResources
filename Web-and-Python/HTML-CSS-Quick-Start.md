# HTML + CSS Quick Start

Just enough to build a landing page for your app.

---

## 1. The Smallest Possible Page

`index.html`:

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>My App</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
  <h1>Hello, world</h1>
  <p>This is my first web page.</p>
</body>
</html>
```

Double-click to open in any browser. Done.

---

## 2. HTML: Structure Only

HTML is just a tree of tags. The most useful ones:

```html
<h1>, <h2>, <h3>   <!-- headings -->
<p>                <!-- paragraph -->
<ul><li></li></ul> <!-- unordered list -->
<ol><li></li></ol> <!-- ordered list -->
<a href="...">     <!-- link -->
<img src="..." alt="...">
<div>              <!-- generic container -->
<section>, <article>, <header>, <footer>, <nav>   <!-- semantic blocks -->
<form><input><button></form>
```

Rule: **pick the most semantic tag available.** `<nav>` > `<div class="nav">`.

---

## 3. CSS: How It Looks

Two ways to apply CSS. Easiest for beginners is a `<style>` block in the HTML or a separate `styles.css`.

```html
<link rel="stylesheet" href="styles.css">
```

```css
/* styles.css */
body {
  font-family: system-ui, -apple-system, sans-serif;
  max-width: 720px;
  margin: 48px auto;
  padding: 0 16px;
  line-height: 1.6;
  color: #222;
}

h1 {
  font-size: 48px;
  margin-bottom: 8px;
}

a {
  color: #0366d6;
  text-decoration: none;
}

a:hover {
  text-decoration: underline;
}
```

---

## 4. The 5 CSS Concepts Worth Knowing

1. **Selectors** — `h1`, `.class`, `#id`.
2. **Box model** — every element has `margin` (outside), `border`, `padding` (inside), `content`.
3. **Flexbox** — 1D layout.
   ```css
   .row { display: flex; gap: 16px; align-items: center; }
   ```
4. **Grid** — 2D layout.
   ```css
   .grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; }
   ```
5. **Media queries** — responsive design.
   ```css
   @media (max-width: 600px) {
     body { font-size: 18px; }
   }
   ```

---

## 5. A Landing Page Template

```html
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
  <title>Flashcards Pro</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    :root { color-scheme: light dark; }
    body { font-family: system-ui; max-width: 720px; margin: 0 auto; padding: 48px 16px; line-height: 1.6; }
    header { text-align: center; margin-bottom: 48px; }
    h1 { font-size: 56px; margin: 0; }
    .sub { opacity: 0.7; font-size: 20px; }
    .cta { display: inline-block; margin-top: 24px; padding: 14px 28px;
           background: #111; color: #fff; border-radius: 8px; text-decoration: none; }
    .features { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 16px; }
    .feature { padding: 16px; border: 1px solid #ccc; border-radius: 12px; }
    img.screenshot { width: 100%; border-radius: 16px; margin: 32px 0; }
    footer { text-align: center; margin-top: 64px; opacity: 0.6; font-size: 14px; }
  </style>
</head>
<body>
  <header>
    <h1>Flashcards Pro</h1>
    <p class="sub">Learn anything, one card at a time.</p>
    <a class="cta" href="https://apps.apple.com/...">Download on the App Store</a>
  </header>

  <img class="screenshot" src="screenshot.png" alt="App screenshot">

  <section class="features">
    <div class="feature"><h3>Spaced repetition</h3><p>Cards come back when you need them.</p></div>
    <div class="feature"><h3>Works offline</h3><p>Study anywhere, no network needed.</p></div>
    <div class="feature"><h3>AI hints</h3><p>Stuck? Ask for a gentle nudge.</p></div>
  </section>

  <footer>© 2026 Your Name · <a href="/privacy.html">Privacy</a></footer>
</body>
</html>
```

Drop it into a GitHub Pages repo (see `../Portfolio/GitHub-Pages-Guide.md`). You have a live app website.

---

## 6. Tools That Help

- **VS Code** — free, fast editor. Install "Live Server" extension for auto-reload.
- **Chrome / Safari DevTools** — right-click → Inspect. Change CSS live.
- **[caniuse.com](https://caniuse.com)** — check if a CSS feature works in browsers you care about.

---

## Exercise

Build a single-page site for an existing project of yours:

- Hero with title + one-line description.
- One screenshot.
- 3 feature cards.
- Link to the repo.
- Footer.

Ship it via GitHub Pages in under 2 hours. You just doubled your portfolio.
