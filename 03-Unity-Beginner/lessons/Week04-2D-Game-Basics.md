# Week 4: 2D Game Basics

## Lesson Overview

| Detail | Info |
|--------|------|
| **Duration** | ~90 minutes |
| **Objective** | Students understand sprites, 2D physics, tilemaps, and build a simple platformer character controller. |
| **Materials** | Unity project (new 2D URP project recommended), sample sprite assets (see Preparation) |

---

## Teacher Preparation

1. Create a new Unity project using the **2D (URP)** template. Name it `Week04-Platformer`.
2. Download free sprites for the demo. Recommended sources:
   - Unity Asset Store: search "2D Platformer" (many free packs available).
   - [Kenney.nl](https://kenney.nl/assets) -- excellent free game art, no attribution required.
   - Or use Unity's built-in square/circle sprites for a minimal approach.
3. Import the sprites into `Assets/Sprites` before class.

---

## Part 1: 2D vs 3D in Unity (10 min)

### Key Differences

| Aspect | 2D | 3D |
|--------|----|----|
| Camera | Orthographic (flat) | Perspective (depth) |
| Physics | Rigidbody**2D**, Collider**2D** | Rigidbody, Collider |
| Visuals | Sprites (flat images) | Meshes (3D models) |
| Axes used | X and Y | X, Y, and Z |
| Gravity default | `(0, -9.81)` in 2D | `(0, -9.81, 0)` in 3D |

> **Important:** 2D and 3D physics are completely separate systems. A Rigidbody2D does not interact with a 3D Collider, and vice versa. If something "doesn't work," check that all components are from the same system (all 2D or all 3D).

---

## Part 2: Sprites (15 min)

### What Is a Sprite?

- A **Sprite** is a 2D image used as a visual in the game.
- In Unity, sprites are imported as Textures with **Texture Type** set to **Sprite (2D and UI)**.

### Importing and Using Sprites

1. Drag an image file (PNG recommended) into the `Assets/Sprites` folder.
2. Select the image in the Project panel. In the Inspector, confirm **Texture Type** is "Sprite (2D and UI)".
3. Set **Pixels Per Unit** (default 100). This controls how large the sprite appears: 100 means 100 pixels = 1 Unity unit.
4. Click **Apply**.
5. Drag the sprite from the Project panel into the Scene view. Unity automatically creates a GameObject with a **Sprite Renderer** component.

### Sprite Renderer Component

| Property | Purpose |
|----------|---------|
| **Sprite** | The image to display |
| **Color** | Tint applied to the sprite |
| **Flip** | Mirror the sprite horizontally or vertically |
| **Sorting Layer / Order in Layer** | Controls draw order (what appears in front of what) |

**Student check:** Import a sprite (or use the default white square) and place it in the scene.

---

## Part 3: 2D Physics (15 min)

### Rigidbody2D

1. Select the player sprite in the Hierarchy.
2. **Add Component > Rigidbody 2D**.
3. Press Play -- the sprite falls due to gravity.

Key Rigidbody2D settings:

| Property | Notes |
|----------|-------|
| **Body Type** | Dynamic (moves with physics), Kinematic (moved by code only), Static (never moves) |
| **Gravity Scale** | Multiplier for gravity. Set to 0 for top-down games. |
| **Freeze Rotation Z** | Check this for platformers to prevent the player from spinning on collision |

> **Teacher tip:** Always check **Freeze Rotation Z** for platformer characters. Students will be confused when their character starts spinning after hitting a wall.

### Collider2D

1. Add a **Box Collider 2D** to the player sprite (or **Capsule Collider 2D** for smoother movement on edges).
2. Adjust the collider size in the Inspector by editing the **Size** and **Offset** fields, or click **Edit Collider** and drag the green handles in the Scene view.

### Ground Setup

1. Create a new empty GameObject named `Ground`.
2. Add a **Sprite Renderer** and assign a ground/platform sprite (or use the default square sprite and scale it).
3. Set Scale to `(10, 1, 1)` to make a wide platform.
4. Add a **Box Collider 2D**.
5. Position it below the player.
6. Press Play -- the player should land on the ground.

---

## Part 4: Tilemaps (15 min)

### What Is a Tilemap?

- A **Tilemap** lets you paint a level using a grid of small images (tiles).
- Much faster than placing individual sprites for floors, walls, and platforms.

### Setting Up a Tilemap

1. In the Hierarchy, right-click > **2D Object > Tilemap > Rectangular**.
2. This creates a **Grid** parent with a **Tilemap** child.
3. Select the Tilemap object. It has a **Tilemap Renderer** component.
4. Add a **Tilemap Collider 2D** component to make the tiles solid.

### Creating a Tile Palette

1. Go to **Window > 2D > Tile Palette**.
2. In the Tile Palette window, click **Create New Palette**. Name it `MainPalette`, keep defaults, and save it in `Assets/Tiles`.
3. Drag sprite images into the Tile Palette window. Unity converts them into Tile assets.
4. Select a tile in the palette, then paint on the Tilemap in the Scene view by clicking/dragging.

### Painting a Level

1. Use the **Brush** tool (default) to paint tiles.
2. Use the **Eraser** to remove tiles.
3. Use the **Rectangle** tool to fill large areas quickly.
4. Paint a ground layer and some platforms at different heights.

**Student check:** Each student should have a painted tilemap level with at least a ground layer and two floating platforms.

---

## Part 5: Platformer Character Controller (20 min)

### The Script

Create a new script called `PlatformerController` in `Assets/Scripts`:

```csharp
using UnityEngine;

public class PlatformerController : MonoBehaviour
{
    public float moveSpeed = 5f;
    public float jumpForce = 10f;
    public Transform groundCheck;
    public float groundCheckRadius = 0.2f;
    public LayerMask groundLayer;

    private Rigidbody2D rb;
    private bool isGrounded;

    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
    }

    void Update()
    {
        // --- Horizontal Movement ---
        float horizontal = Input.GetAxis("Horizontal");
        rb.linearVelocity = new Vector2(horizontal * moveSpeed, rb.linearVelocity.y);

        // --- Flip sprite to face movement direction ---
        if (horizontal > 0.01f)
            transform.localScale = new Vector3(1, 1, 1);
        else if (horizontal < -0.01f)
            transform.localScale = new Vector3(-1, 1, 1);

        // --- Ground Check ---
        isGrounded = Physics2D.OverlapCircle(
            groundCheck.position, groundCheckRadius, groundLayer
        );

        // --- Jump ---
        if (Input.GetKeyDown(KeyCode.Space) && isGrounded)
        {
            rb.linearVelocity = new Vector2(rb.linearVelocity.x, jumpForce);
        }
    }
}
```

### Setting It Up

#### Step 1: Assign the script

1. Attach `PlatformerController` to the player GameObject.
2. The script needs a Rigidbody2D on the same object (which you added in Part 3).

#### Step 2: Create the Ground Check

1. Right-click the **Player** in the Hierarchy > **Create Empty**. Name it `GroundCheck`.
2. Move `GroundCheck` to the bottom of the player sprite (at the character's feet).
3. In the `PlatformerController` component in the Inspector, drag `GroundCheck` into the **Ground Check** field.

#### Step 3: Set up the Ground Layer

1. Select the Tilemap (or ground object). In the Inspector, click the **Layer** dropdown > **Add Layer**.
2. In an empty slot, type `Ground`.
3. Go back to the Tilemap/ground object and set its Layer to `Ground`.
4. In the `PlatformerController` Inspector, set **Ground Layer** to `Ground`.

#### Step 4: Test

1. Press Play.
2. Use A/D or Left/Right arrows to move.
3. Press Space to jump.
4. The character should only jump when touching the ground.

### Troubleshooting

| Problem | Likely Cause |
|---------|-------------|
| Character falls through the ground | Missing Collider2D on player or ground |
| Character spins on collision | Rigidbody2D > Constraints > Freeze Rotation Z is not checked |
| Jump doesn't work | Ground Check position is wrong, or Ground Layer not assigned |
| Character slides too much | Increase Rigidbody2D linear drag or create a Physics Material 2D with higher friction |

---

## Wrap-Up (5 min)

### Key Vocabulary

| Term | Definition |
|------|-----------|
| **Sprite** | A 2D image used as a visual element in a game |
| **Rigidbody2D** | 2D physics component enabling gravity, forces, and velocity |
| **Collider2D** | 2D collision shape for detecting physical interactions |
| **Tilemap** | A grid-based system for painting levels with reusable tiles |
| **Tile Palette** | The tool window where tiles are organized and selected for painting |
| **LayerMask** | A filter that tells physics queries which layers to include |
| **OverlapCircle** | A Physics2D method that checks if any collider overlaps a circular area |

### Homework

- Design a short platformer level (at least 3 platforms the player must jump between).
- Add a "hazard" area (a red-colored tile zone) at the bottom. If the player falls in, log "Game Over!" using `OnTriggerEnter2D`.
- Challenge: Add double-jump (allow the player to jump once more while in the air).
- Next week: UI and game logic -- adding scores, a game over screen, and menus.
