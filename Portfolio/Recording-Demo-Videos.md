# Recording Demo Videos

A 30-second demo video makes a project 10x more compelling than screenshots alone.

---

## Recording on macOS Simulator

1. Run your app in the iOS simulator.
2. **File → Record Screen** (or `⌘R` inside simulator when focused on its menu). Alternatively use macOS's screen recorder: `⌘⇧5`.
3. Drive your app through the golden-path flow.
4. Stop. You get a `.mov`.

---

## Recording on a Real Device

1. Connect iPhone to Mac with a cable.
2. Open **QuickTime Player**.
3. **File → New Movie Recording.**
4. Click the arrow next to the record button → select your iPhone as camera and microphone.
5. Record what's on the phone in real time.

---

## Edit to 30 Seconds

Long videos lose viewers. The ideal demo is:

- **5 seconds** — app opens, clear what it is.
- **15 seconds** — the primary feature in action.
- **10 seconds** — a cool detail, the empty state handled well, or a visual flourish.

Tools:

- **iMovie** (free, built-in) — trim, crop, add titles.
- **CapCut** (free, web + desktop) — fast, TikTok-style.
- **Final Cut** (paid) — overkill for demos.

---

## Convert to GIF (For Your README)

A video doesn't autoplay in a GitHub README. A GIF does.

```bash
# ffmpeg one-liner
ffmpeg -i demo.mov -vf "fps=15,scale=480:-1:flags=lanczos" -loop 0 demo.gif
```

Or use [ezgif.com](https://ezgif.com) to convert + compress in the browser.

Keep GIFs **under 3 MB**. Bigger ones don't render well on GitHub mobile.

---

## Tips

- **Silence is fine.** Most portfolio demos don't need narration.
- **No mouse cursor bouncing around.** Plan your clicks.
- **Simulator > real phone** for clean demos (no scratches, notifications, or weird lighting).
- **Use the same device size for all screenshots + videos** in one project. Consistency reads as care.
- **Light-mode demo for general use, dark-mode for flex.** Pick one per project.

---

## Where to Post

- **In the README** — GIF at the top.
- **On your personal site** — embed the MP4 or link a YouTube unlisted video.
- **In your GitHub profile README** — as a link or image.
- **On X / LinkedIn / TikTok** — students who post their work get noticed way faster than students who don't.

---

## Exercise

Right now — not tomorrow — record a 30-second demo of something you've already built. Post it as a GIF in its README.

It's the highest-leverage use of 15 minutes in your entire portfolio journey.
