# Week 1: Getting to Know the Unity Editor

## Lesson Overview

| Detail | Info |
|--------|------|
| **Duration** | ~90 minutes (one class period) |
| **Objective** | Students can identify every major panel in the Unity Editor and create a simple scene using primitive objects. |
| **Materials** | Unity Hub + Unity Editor installed, projector for teacher demo |

---

## Teacher Preparation

1. Open Unity Hub and create a fresh 3D (URP) project called `Week01-Demo` before class.
2. Arrange your Editor layout to the **Default** layout (Window > Layouts > Default) so it matches the descriptions below.
3. Have the project open and ready to project on screen when students arrive.

---

## Part 1: Editor Tour (30 min)

Walk students through each panel. After introducing a panel, give students 1-2 minutes to locate it on their own screen.

### 1.1 Scene View

> **Screenshot to show:** The Scene view with the 3D grid visible, the navigation gizmo in the top-right corner, and the toolbar (Move, Rotate, Scale) at the top-left.

- This is the 3D workspace where you build your game world.
- Demonstrate navigation:
  - **Right-click + drag** to look around.
  - **Middle-click + drag** to pan.
  - **Scroll wheel** to zoom.
  - **F key** to focus on a selected object.
- Point out the **Move (W)**, **Rotate (E)**, and **Scale (R)** tools in the toolbar.

**Student check:** Ask students to orbit around the default camera in the scene.

### 1.2 Game View

> **Screenshot to show:** The Game view tab next to the Scene view, showing "Display 1" dropdown and the aspect ratio selector.

- This shows what the player will see when the game runs.
- Click the **Play** button at the top-center of the Editor. Point out that the Play button tints the Editor (blue or dark, depending on settings).
- Warn students: **changes made while in Play mode are lost when you stop playing.** This is the number-one beginner mistake.

**Student check:** Press Play, observe the Game view, then press Play again to stop.

### 1.3 Hierarchy Panel

> **Screenshot to show:** The Hierarchy panel on the left side, showing "Main Camera" and "Directional Light" as the default objects.

- Lists every GameObject in the current scene.
- Objects can be nested (parent-child relationships) by dragging one onto another.
- Right-click in the Hierarchy to create new objects.

### 1.4 Inspector Panel

> **Screenshot to show:** The Inspector with the Main Camera selected, showing the Transform component and the Camera component.

- Displays all **components** attached to the selected GameObject.
- Every GameObject has at least a **Transform** (position, rotation, scale).
- Values can be edited directly by typing or dragging the number fields.

**Student check:** Select Main Camera, then look at the Inspector. Change the Position Y value to 5 and observe what happens in the Scene view.

### 1.5 Project Panel

> **Screenshot to show:** The Project panel at the bottom, showing the Assets folder.

- This is the file browser for your project.
- All assets (scripts, images, sounds, prefabs) live here.
- Mirrors the `Assets/` folder on disk.
- Right-click to create folders, scripts, materials, and more.

### 1.6 Console Panel

> **Screenshot to show:** The Console panel (may be tabbed behind the Project panel), with the Clear, Collapse, and Error Pause buttons visible.

- Displays log messages, warnings, and errors.
- `Debug.Log("Hello")` in a script prints here.
- Essential for debugging. Students should keep this panel visible at all times.

---

## Part 2: Creating Your First Scene (40 min)

### Step-by-Step Instructions

Guide students through each step. Pause after every few steps so no one falls behind.

#### Step 1: Create a ground plane

1. In the **Hierarchy**, right-click and choose **3D Object > Plane**.
2. A flat white square appears in the scene. Select it in the Hierarchy.
3. In the **Inspector**, set the Transform values:
   - Position: `(0, 0, 0)`
   - Rotation: `(0, 0, 0)`
   - Scale: `(2, 1, 2)` -- this makes the plane larger.

#### Step 2: Add a cube

1. Right-click in the Hierarchy and choose **3D Object > Cube**.
2. In the Inspector, set Position to `(0, 0.5, 0)` so the cube sits on top of the plane.
3. Notice the cube already has a **Box Collider** component -- we will learn about colliders in Week 2.

#### Step 3: Add a sphere

1. Right-click in the Hierarchy > **3D Object > Sphere**.
2. Set Position to `(3, 0.5, 0)`.
3. Ask students: "Why do we set Y to 0.5?" (Answer: the sphere's center is at its position, and its radius is 0.5, so Y = 0.5 places it exactly on the ground.)

#### Step 4: Add a cylinder

1. Right-click > **3D Object > Cylinder**.
2. Set Position to `(-3, 1, 0)`.

#### Step 5: Add color with Materials

1. In the **Project** panel, right-click on the `Assets` folder and choose **Create > Folder**. Name it `Materials`.
2. Open the `Materials` folder. Right-click inside it and choose **Create > Material**. Name it `Red`.
3. In the Inspector for the material, click the color box next to **Base Map** (or **Albedo** in Standard shader) and pick a red color.
4. **Drag** the `Red` material from the Project panel onto the Cube in the Scene view (or onto the Cube in the Hierarchy).
5. The cube turns red.
6. Repeat to create `Blue` and `Green` materials. Apply them to the Sphere and Cylinder.

> **Teacher tip:** Walk around the room at this point. Common issues: students creating materials in the wrong folder, or dragging materials onto the wrong object.

#### Step 6: Reposition the camera

1. Select **Main Camera** in the Hierarchy.
2. Set Position to `(0, 5, -8)` and Rotation to `(30, 0, 0)`.
3. Press **Play** to see the scene from the camera's perspective in the Game view.

#### Step 7: Save the scene

1. **File > Save** (or Ctrl+S / Cmd+S).
2. Unity will ask where to save. Create a folder called `Scenes` in Assets and save as `MyFirstScene`.

---

## Part 3: Mini-Challenge (15 min)

Ask students to create a small scene of their own using only primitive objects and materials. Suggestions:

- A simple house (cubes for walls, a rotated cube or plane for a roof).
- A snowman (stacked spheres of different scales).
- A table and chairs.
- A traffic light (cylinder + three spheres with red/yellow/green materials).

Walk around and help students who are stuck. Encourage creativity.

---

## Wrap-Up (5 min)

### Key Vocabulary

| Term | Definition |
|------|-----------|
| **Scene View** | The 3D workspace where you build and arrange your game world |
| **Game View** | The preview of what the player sees through the camera |
| **Hierarchy** | The list of all GameObjects in the current scene |
| **Inspector** | The detail panel showing components and properties of a selected object |
| **Project Panel** | The file browser for all assets in your project |
| **Console** | The panel that displays log messages, warnings, and errors |
| **Material** | An asset that defines the visual appearance (color, texture) of an object's surface |

### Homework / Next Class Prep

- Explore the Unity Editor on your own. Try creating different primitive shapes and changing their colors.
- Read: Unity Manual section on "The Main Windows" (link in the module README).
- Next week we will learn about **GameObjects and Components** and build a ball-rolling demo.
