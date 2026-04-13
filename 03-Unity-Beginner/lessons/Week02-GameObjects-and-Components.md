# Week 2: GameObjects and Components

## Lesson Overview

| Detail | Info |
|--------|------|
| **Duration** | ~90 minutes |
| **Objective** | Students understand the GameObject-Component model, can add Rigidbody and Collider components, and build a ball-rolling demo. |
| **Materials** | Unity project from Week 1 (or a fresh 3D project) |

---

## Part 1: Concept -- Everything Is a GameObject (20 min)

### What Is a GameObject?

- A **GameObject** is the fundamental building block in Unity. Every object in a scene is a GameObject.
- By itself, a GameObject is an empty container. It does nothing until you attach **Components** to it.
- Even the camera and the light in your scene are GameObjects with specific components attached.

### What Is a Component?

- A **Component** is a piece of functionality you attach to a GameObject.
- Every GameObject automatically has a **Transform** component (position, rotation, scale).
- Other common components: MeshRenderer, Camera, Light, AudioSource, Rigidbody, Collider, and custom scripts.

### The Inspector Revisited

1. Have students create an empty GameObject: Hierarchy > right-click > **Create Empty**.
2. Select it and look at the Inspector. Only the Transform component is present.
3. Click **Add Component** at the bottom of the Inspector. Browse the categories or search by name.
4. Add a **Mesh Filter** and a **Mesh Renderer**. In the Mesh Filter, set the Mesh to "Sphere". Now the empty object looks like a sphere.

> **Teacher note:** This exercise shows that a "Sphere" in Unity is just an empty GameObject with Mesh Filter + Mesh Renderer + Sphere Collider added automatically. Understanding this demystifies "magic" objects.

---

## Part 2: Transform Deep Dive (15 min)

### Position, Rotation, Scale

- **Position** is measured in Unity units (roughly equivalent to meters).
- **Rotation** is in degrees (Euler angles). Internally Unity uses quaternions, but the Inspector shows degrees.
- **Scale** multiplies the object's base size. `(1, 1, 1)` is default.

### Parent-Child Relationships

1. Create a Cube and a small Sphere.
2. Drag the Sphere onto the Cube in the Hierarchy so it becomes a child.
3. Move the Cube -- the Sphere moves with it.
4. The child's Transform values are now **relative to the parent**.

**Student check:** Create a "solar system" -- a large sphere (sun) with a smaller sphere (planet) as a child. Move the sun and observe the planet following.

---

## Part 3: Rigidbody and Physics (20 min)

### What Is a Rigidbody?

- A **Rigidbody** tells Unity's physics engine to control this object.
- Without a Rigidbody, an object is static -- physics ignores it.
- With a Rigidbody, the object responds to gravity, forces, and collisions.

### Adding a Rigidbody

1. Create a **Sphere** and set its Position to `(0, 5, 0)` (hovering above the ground).
2. Make sure you have a **Plane** at `(0, 0, 0)` as the ground.
3. Press **Play**. The sphere stays frozen in the air because it has no Rigidbody.
4. Stop Play mode. Select the Sphere, click **Add Component**, and search for **Rigidbody**. Add it.
5. Press **Play** again. The sphere falls and lands on the plane.

### Key Rigidbody Properties

| Property | What It Does |
|----------|-------------|
| **Mass** | How heavy the object is (affects force interactions, not gravity speed) |
| **Drag** | Air resistance -- slows the object over time |
| **Use Gravity** | Whether gravity pulls the object down |
| **Is Kinematic** | If checked, physics forces are ignored (you move it manually via code) |

---

## Part 4: Colliders (15 min)

### What Is a Collider?

- A **Collider** defines the physical shape of an object for collision detection.
- Primitive objects come with a matching collider (Box Collider for Cube, Sphere Collider for Sphere, etc.).
- Without a collider, objects pass through each other.

### Types of Colliders

| Collider | Shape | Best For |
|----------|-------|----------|
| **Box Collider** | Rectangular box | Crates, walls, floors |
| **Sphere Collider** | Sphere | Balls, round pickups |
| **Capsule Collider** | Capsule | Player characters |
| **Mesh Collider** | Matches the object's mesh exactly | Complex shapes (expensive) |

### Trigger Colliders

- Check **Is Trigger** on a collider to make it detect overlaps without blocking movement.
- Useful for pickup zones, checkpoints, and invisible boundaries.
- We will use triggers more in Week 3 when we write scripts.

---

## Part 5: Ball-Rolling Demo (20 min)

Build a simple scene where a ball rolls on a tilted surface and falls off the edge.

### Step 1: Set Up the Ramp

1. Create a **Cube**. Rename it `Ramp`.
2. Set Scale to `(4, 0.2, 8)` to make it a long flat plank.
3. Set Rotation to `(10, 0, 0)` to tilt it slightly.
4. Set Position to `(0, 2, 0)`.

### Step 2: Add Walls

1. Create two more Cubes. Name them `WallLeft` and `WallRight`.
2. Set Scale for both to `(0.2, 0.5, 8)`.
3. Position `WallLeft` at `(-2, 2.25, 0)` and `WallRight` at `(2, 2.25, 0)`.
4. Match the Ramp's rotation `(10, 0, 0)` on both walls.
5. Parent both walls under the Ramp so they move together.

### Step 3: Create the Ball

1. Create a **Sphere**. Rename it `Ball`.
2. Set Position to `(0, 3.5, -3)` (at the high end of the ramp).
3. Add a **Rigidbody** component.

### Step 4: Add a Ground Plane

1. Create a **Plane** at `(0, 0, 0)` with Scale `(3, 1, 3)`.
2. This catches the ball after it rolls off the ramp.

### Step 5: Apply Materials

1. Create materials for the ramp (gray), walls (dark gray), ball (red), and ground (green).
2. Apply them to the respective objects.

### Step 6: Play and Observe

1. Press **Play**. The ball should roll down the ramp due to gravity and fall onto the ground plane.
2. Experiment:
   - Change the ramp's rotation angle. Steeper = faster rolling.
   - Change the ball's Rigidbody **Mass** and **Drag**. Observe differences.
   - Remove the walls and see the ball roll off the side.

**Student check:** Every student should see the ball rolling down the ramp before moving on.

---

## Wrap-Up (5 min)

### Key Vocabulary

| Term | Definition |
|------|-----------|
| **GameObject** | A container object in Unity; the base entity in every scene |
| **Component** | A modular piece of functionality attached to a GameObject |
| **Transform** | The component that stores position, rotation, and scale |
| **Rigidbody** | A component that enables physics simulation (gravity, forces) |
| **Collider** | A component that defines the physical shape for collision detection |
| **Trigger** | A collider mode that detects overlaps without physical blocking |

### Homework

- Experiment with the ball-rolling demo: add obstacles (cubes on the ramp), change angles, add more balls.
- Challenge: Create a "marble run" with multiple ramps leading into each other.
- Next week: We write our first C# scripts to control objects with code.
