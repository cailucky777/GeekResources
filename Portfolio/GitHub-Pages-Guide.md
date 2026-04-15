# Free Personal Website with GitHub Pages

Zero dollars, one afternoon, a real URL.

---

## Two Flavors

| Approach | Difficulty | Output |
|---|---|---|
| **User site** | Easy | `https://<username>.github.io` — your personal page |
| **Project site** | Easy | `https://<username>.github.io/<repo>` — one page per project |

Most students should start with a **user site.**

---

## Step 1 — Create the Repo

1. New repo named **`<your-username>.github.io`**.
2. Make it public.
3. Add a single file: `index.html`.

---

## Step 2 — The Simplest Possible Page

`index.html`:

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Alice Chen</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    :root { font-family: system-ui; color-scheme: light dark; }
    body  { max-width: 640px; margin: 48px auto; padding: 0 16px; line-height: 1.5; }
    h1    { margin-bottom: 0; }
    p.sub { margin-top: 4px; opacity: 0.7; }
    .card { display: block; padding: 16px; border: 1px solid #ccc;
            border-radius: 12px; margin-bottom: 12px; text-decoration: none;
            color: inherit; }
    .card:hover { background: rgba(0,0,0,0.04); }
  </style>
</head>
<body>
  <h1>Alice Chen</h1>
  <p class="sub">High-school student · iOS & game dev · Seattle, WA</p>

  <h2>Projects</h2>

  <a class="card" href="https://github.com/alice/flashcards">
    <strong>Flashcards Pro</strong><br>
    A SwiftUI spaced-repetition app. TestFlight ·
    <em>Swift · SwiftData · AI</em>
  </a>

  <a class="card" href="https://github.com/alice/pixel-dungeon">
    <strong>Pixel Dungeon</strong><br>
    A 2D rogue-like game in Unity. <em>C# · procedural generation</em>
  </a>

  <h2>Contact</h2>
  <p>✉️ alice@example.com · 🐙 <a href="https://github.com/alice">GitHub</a></p>
</body>
</html>
```

Commit. Wait 1–2 minutes. Visit `https://<your-username>.github.io`. You have a live website.

---

## Step 3 — Enable Pages (If Not Automatic)

Repo → **Settings → Pages** → Source: **Deploy from branch** → `main` / root → Save.

---

## Step 4 — Add a Custom Domain (Optional)

Own a domain already?

1. Add a `CNAME` file in the repo with the domain (`alice-chen.dev`).
2. In your DNS provider, add:
   - `A` record → GitHub's IPs (find current ones in Pages docs).
   - `CNAME` for `www` → `<username>.github.io`.
3. In repo settings, add the custom domain and check "Enforce HTTPS."

---

## Step 5 — Going Further

When the one-file site gets limiting:

- **Static site generators** like [Astro](https://astro.build) or [Eleventy](https://www.11ty.dev). Both build straight into GitHub Pages via a GitHub Action.
- **Tailwind CSS** for clean styling without writing CSS.
- **MDX / blog posts** — sharing what you learn is a power move.

But don't upgrade before the one-file version exists. Ship simple first.

---

## Tips

- **One page is enough for a portfolio.** Nobody navigates deep.
- **Put your best project at the top.**
- **Every project links to its repo.** Recruiters click to see real code.
- **Update it twice a year.** Stale personal sites hurt more than no site at all.

---

## Exercise

Take the HTML above, replace my projects with yours, and push it. Text someone the URL. You now have a website. That's a win a lot of people older than you don't have.
