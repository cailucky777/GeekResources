# Unity Beginner Module

An 8-week introductory course teaching high school students game development with Unity. Students progress from navigating the Unity Editor to building a complete game as their final project.

---

## Prerequisites

Students should have a basic understanding of the following before starting this module:

- **Variables and data types** (integers, strings, booleans)
- **Control flow** (if/else statements, loops)
- **Functions** (defining and calling functions, parameters, return values)
- **Basic debugging** (reading error messages, using print statements)

Prior experience with C# is helpful but not required. The module introduces C# concepts as they appear in Unity.

---

## Learning Objectives

By the end of this module, students will be able to:

1. Navigate the Unity Editor and manage projects, scenes, and assets.
2. Understand the GameObject-Component architecture.
3. Write C# scripts to control game behavior (movement, input, collisions).
4. Differentiate between 2D and 3D game development workflows.
5. Apply physics concepts using Rigidbody, Colliders, and Unity's physics engine.
6. Build user interfaces with Unity's UI system (Canvas, Text, Buttons).
7. Implement core game logic: scoring, win/lose conditions, and scene transitions.
8. Plan, build, and present a simple game as a final project.

---

## Weekly Lesson Plan

| Week | Topic | Key Activities |
|------|-------|----------------|
| 1 | Unity Interface | Tour the Editor, create a scene with primitive objects |
| 2 | GameObjects and Components | Transform, Rigidbody, Colliders; build a ball-rolling demo |
| 3 | C# Basics in Unity | Variables, functions, Start/Update, input, moving objects |
| 4 | 2D Game Basics | Sprites, 2D physics, tilemaps, platformer character controller |
| 5 | UI and Game Logic | Canvas, Text, Buttons, score tracking, scene management |
| 6 | Audio, Particles, and Polish | Sound effects, music, particle systems, visual feedback |
| 7 | Final Project Work Session | Students design and build their own game |
| 8 | Final Project Presentations | Playtesting, peer feedback, presentations |

Detailed lesson plans are located in the `lessons/` folder. Guided demos are in the `demos/` folder.

---

## Software Requirements

| Software | Version | Notes |
|----------|---------|-------|
| **Unity Hub** | Latest | Used to manage Unity installations and projects |
| **Unity Editor** | 2022.3 LTS or newer | Use the latest Long Term Support release |
| **Visual Studio Code** or **Visual Studio** | Latest | With the C# extension / Unity integration |
| **Git** (optional) | Latest | For version control of student projects |

### Installation Notes

- Install Unity Hub first, then install the Unity Editor through the Hub.
- During installation, include the **WebGL Build Support** module so students can share games in a browser.
- Ensure each student machine has at least 10 GB of free disk space.
- Teacher machines should have the same setup so demos can be projected live.

---

## Final Project

### Overview

Students design and build a simple game of their choice. The project spans Weeks 7-8 and is presented to the class on the final day.

### Requirements

The final game must include:

- At least one player-controlled GameObject with scripted movement.
- At least one type of interaction (collecting items, avoiding obstacles, triggering events).
- A UI displaying at least one piece of game information (score, health, timer).
- A win or lose condition with a game-over screen.
- At least one sound effect or background music clip.

### Suggested Project Ideas

- A top-down maze game with a timer.
- A 2D platformer with collectible coins and a finish line.
- A simple endless runner with increasing difficulty.
- A Breakout / Brick-Breaker clone.

### Grading Rubric (suggested)

| Category | Points |
|----------|--------|
| Gameplay mechanics work correctly | 30 |
| UI is present and functional | 15 |
| Code quality and comments | 20 |
| Creativity and polish | 15 |
| Presentation and explanation | 20 |
| **Total** | **100** |

---

## Folder Structure

```
03-Unity-Beginner/
  README.md              <-- You are here
  lessons/
    Week01-Unity-Interface.md
    Week02-GameObjects-and-Components.md
    Week03-CSharp-Basics-in-Unity.md
    Week04-2D-Game-Basics.md
    Week05-UI-and-Game-Logic.md
  demos/
    Demo01-RollABall.md
    Demo02-SimplePlatformer.md
```

---

## Additional Resources

- [Unity Learn](https://learn.unity.com/) -- Official tutorials and learning paths
- [Unity Manual](https://docs.unity3d.com/Manual/) -- Full documentation
- [Unity Scripting Reference](https://docs.unity3d.com/ScriptReference/) -- C# API reference
- [Brackeys YouTube Channel](https://www.youtube.com/@Brackeys) -- Beginner-friendly Unity video tutorials
