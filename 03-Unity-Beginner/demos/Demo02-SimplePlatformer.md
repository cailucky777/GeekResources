# Demo 02: Simple 2D Platformer

A step-by-step classroom guide to building a 2D platformer with character movement, jumping, collectible items, and a score display.

---

## Overview

| Detail | Info |
|--------|------|
| **Estimated Time** | 75-90 minutes |
| **Difficulty** | Beginner |
| **Unity Template** | 2D (URP) |
| **Concepts Covered** | Sprites, Rigidbody2D, Collider2D, tilemaps, scripting, triggers, UI |
| **Prerequisite Lessons** | Weeks 1-5 (or at minimum Weeks 1-4) |

### What Students Will Build

A side-scrolling platformer where a character runs and jumps across platforms, collects coins, and sees their score on screen. The game ends when the player falls off the bottom of the level.

---

## Teacher Notes

- Have free sprite assets ready before class. Kenney's "Simplified Platformer Pack" (kenney.nl) works perfectly and is free.
- If sprite packs are not available, students can use Unity's default Square and Circle sprites with colored materials -- the game works the same way.
- This demo builds on the platformer controller from Week 4. Students who completed that lesson will have a head start.

---

## Step 1: Project Setup (5 min)

1. Open Unity Hub > **New Project** > **2D (URP)** template.
2. Name it `SimplePlatformer`. Create the project.
3. Create these folders inside `Assets`:
   - `Sprites`
   - `Scripts`
   - `Scenes`
   - `Tiles`
4. Save the scene as `Level1` in the `Scenes` folder.

---

## Step 2: Create the Player (10 min)

### Using a Sprite

1. Import a player sprite into `Assets/Sprites` (drag the PNG file in).
2. Select it in the Project panel. Confirm **Texture Type** is `Sprite (2D and UI)`. Set **Pixels Per Unit** to `32` (or whatever matches your art). Click **Apply**.
3. Drag the sprite into the Scene view. Rename the GameObject to `Player`.

> If no sprite is available: right-click in Hierarchy > **2D Object > Sprites > Square**. Rename to `Player`. Set the Sprite Renderer color to blue.

### Add Physics

1. Select `Player`. **Add Component > Rigidbody 2D**.
   - Set **Gravity Scale** to `3` (makes the character feel heavier and more responsive).
   - Under **Constraints**, check **Freeze Rotation Z**.
2. **Add Component > Box Collider 2D** (or Capsule Collider 2D for smoother ledge handling).
   - Click **Edit Collider** and adjust the green outline to fit the sprite tightly.

### Tag the Player

1. With the Player selected, set **Tag** to `Player` (it is a built-in tag).

---

## Step 3: Build the Level with Tilemaps (15 min)

### Create the Tilemap

1. Hierarchy > right-click > **2D Object > Tilemap > Rectangular**.
2. Rename the Tilemap to `GroundTilemap`.

### Create a Tile Palette

1. **Window > 2D > Tile Palette**.
2. Click **Create New Palette**. Name it `LevelPalette`. Save in `Assets/Tiles`.
3. Drag your ground/platform sprite(s) into the Tile Palette window. Unity creates tile assets automatically.

> If no sprites: create a 32x32 colored square in any image editor, or use Unity's default Square sprite. Drag it into the Tile Palette.

### Paint the Level

Use the Tile Palette brush tool to paint:

1. A **ground layer** spanning the bottom of the screen (about 30 tiles wide).
2. A **gap** in the ground (3-4 tiles wide) that the player must jump over.
3. **Three floating platforms** at varying heights.
4. A **tall wall** on the far right as a level boundary.

### Add Collision

1. Select the `GroundTilemap` object.
2. **Add Component > Tilemap Collider 2D**.
3. **Add Component > Composite Collider 2D** (this merges individual tile colliders into efficient shapes).
4. A Rigidbody2D is automatically added. Set its **Body Type** to `Static`.
5. On the **Tilemap Collider 2D**, check **Used By Composite**.

### Set the Ground Layer

1. Select `GroundTilemap`. Set **Layer** to `Ground`.
   - If the `Ground` layer does not exist, click **Add Layer**, type `Ground` in an empty slot, then go back and select it.

### CHECKPOINT 1
> Player falls and lands on the tilemap ground. Platforms are visible.

---

## Step 4: Player Movement Script (15 min)

Create `Assets/Scripts/PlayerController2D.cs`:

```csharp
using UnityEngine;

public class PlayerController2D : MonoBehaviour
{
    [Header("Movement")]
    public float moveSpeed = 7f;
    public float jumpForce = 14f;

    [Header("Ground Check")]
    public Transform groundCheck;
    public float groundCheckRadius = 0.2f;
    public LayerMask groundLayer;

    private Rigidbody2D rb;
    private bool isGrounded;
    private SpriteRenderer spriteRenderer;

    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
        spriteRenderer = GetComponent<SpriteRenderer>();
    }

    void Update()
    {
        // Ground detection
        isGrounded = Physics2D.OverlapCircle(
            groundCheck.position, groundCheckRadius, groundLayer
        );

        // Horizontal movement
        float moveInput = Input.GetAxis("Horizontal");
        rb.linearVelocity = new Vector2(moveInput * moveSpeed, rb.linearVelocity.y);

        // Flip sprite
        if (moveInput > 0.01f)
            spriteRenderer.flipX = false;
        else if (moveInput < -0.01f)
            spriteRenderer.flipX = true;

        // Jump
        if (Input.GetKeyDown(KeyCode.Space) && isGrounded)
        {
            rb.linearVelocity = new Vector2(rb.linearVelocity.x, jumpForce);
        }
    }
}
```

### Set Up the Ground Check

1. Right-click the **Player** in the Hierarchy > **Create Empty**. Name it `GroundCheck`.
2. Move it to the bottom edge of the player sprite (the character's feet). Approximately Y = -0.5 relative to the player.
3. Select the Player. In the `PlayerController2D` component:
   - Drag `GroundCheck` into the **Ground Check** field.
   - Set **Ground Layer** to `Ground`.
   - Adjust `moveSpeed` and `jumpForce` if needed.

4. Press Play and test. WASD/arrows to move, Space to jump.

### CHECKPOINT 2
> Player moves left/right, jumps only when grounded, and lands on platforms.

---

## Step 5: Create Collectible Coins (15 min)

### The Coin Object

1. Create a new sprite in the scene for the coin. Rename it `Coin`.
   - Use a circle sprite colored yellow if no art is available.
2. Set Scale to `(0.5, 0.5, 1)` to make it smaller than the player.
3. **Add Component > Circle Collider 2D**. Check **Is Trigger**.

### Coin Script

Create `Assets/Scripts/Coin.cs`:

```csharp
using UnityEngine;

public class Coin : MonoBehaviour
{
    public int value = 1;

    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Player"))
        {
            // Tell the ScoreManager to add points
            ScoreManager.Instance.AddScore(value);
            Destroy(gameObject);
        }
    }
}
```

### Optional: Coin Animation

Add a simple bob animation via script. Create `Assets/Scripts/CoinBob.cs`:

```csharp
using UnityEngine;

public class CoinBob : MonoBehaviour
{
    public float bobSpeed = 2f;
    public float bobHeight = 0.2f;

    private Vector3 startPos;

    void Start()
    {
        startPos = transform.position;
    }

    void Update()
    {
        float newY = startPos.y + Mathf.Sin(Time.time * bobSpeed) * bobHeight;
        transform.position = new Vector3(startPos.x, newY, startPos.z);
    }
}
```

Attach `CoinBob` to the Coin for a floating effect.

### Make It a Prefab

1. Create `Assets/Prefabs` folder.
2. Drag the Coin from the Hierarchy into `Prefabs`.
3. Place **6-10 coins** around the level: on platforms, above gaps, in challenging spots.

---

## Step 6: Score Display (10 min)

### ScoreManager Script

Create `Assets/Scripts/ScoreManager.cs`:

```csharp
using UnityEngine;
using TMPro;

public class ScoreManager : MonoBehaviour
{
    public static ScoreManager Instance;

    public TextMeshProUGUI scoreText;

    private int score = 0;

    void Awake()
    {
        if (Instance == null)
            Instance = this;
        else
            Destroy(gameObject);
    }

    void Start()
    {
        UpdateDisplay();
    }

    public void AddScore(int amount)
    {
        score += amount;
        UpdateDisplay();
    }

    public int GetScore()
    {
        return score;
    }

    private void UpdateDisplay()
    {
        scoreText.text = "Coins: " + score;
    }
}
```

### UI Setup

1. Hierarchy > right-click > **UI > Text - TextMeshPro**. Import TMP Essentials if prompted.
2. Rename to `ScoreText`. Anchor top-left. Pos X = `100`, Pos Y = `-30`.
3. Font Size `28`, Color white, Text = `Coins: 0`.
4. Create an empty GameObject named `ScoreManager`. Attach the `ScoreManager` script.
5. Drag `ScoreText` into the script's **Score Text** field.
6. Press Play. Collect coins and verify the score updates.

### CHECKPOINT 3
> Coins disappear on contact, score updates on screen.

---

## Step 7: Game Over on Fall (10 min)

### Kill Zone

1. Create an empty GameObject named `KillZone`.
2. Position it below the level (Y = -5 or lower, spanning the full width).
3. **Add Component > Box Collider 2D**. Check **Is Trigger**. Set Size to `(50, 1)`.

### Game Over Script

Create `Assets/Scripts/GameOverHandler.cs`:

```csharp
using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;

public class GameOverHandler : MonoBehaviour
{
    public GameObject gameOverPanel;
    public TextMeshProUGUI finalScoreText;

    void Start()
    {
        gameOverPanel.SetActive(false);
    }

    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Player"))
        {
            ShowGameOver();
        }
    }

    void ShowGameOver()
    {
        gameOverPanel.SetActive(true);
        finalScoreText.text = "Coins: " + ScoreManager.Instance.GetScore();
        Time.timeScale = 0f;
    }

    public void Restart()
    {
        Time.timeScale = 1f;
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }
}
```

### Game Over UI

1. Right-click the Canvas > **UI > Panel**. Name it `GameOverPanel`.
2. Set Image color to `(0, 0, 0, 180)` for a dark semi-transparent overlay.
3. Add a child **Text - TMP**: "Game Over", font size `56`, centered.
4. Add another child **Text - TMP** for the final score. Name it `FinalScoreText`.
5. Add a child **Button - TMP**. Set button text to "Restart".
6. Disable the `GameOverPanel` (uncheck the checkbox).

### Wire It Up

1. Attach `GameOverHandler` to the `KillZone` object.
2. Drag `GameOverPanel` and `FinalScoreText` into the script fields.
3. Select the Restart button. In **On Click()**, add an entry: drag `KillZone`, select `GameOverHandler > Restart`.
4. Add the current scene to **File > Build Settings > Add Open Scenes**.

### CHECKPOINT 4
> Falling off the level shows the Game Over panel with the score. Restart button reloads the level.

---

## Step 8: Camera Follow (5 min)

Create `Assets/Scripts/CameraFollow2D.cs`:

```csharp
using UnityEngine;

public class CameraFollow2D : MonoBehaviour
{
    public Transform target;
    public float smoothSpeed = 5f;
    public Vector3 offset = new Vector3(0, 2, -10);

    void LateUpdate()
    {
        if (target == null) return;

        Vector3 desiredPosition = target.position + offset;
        Vector3 smoothed = Vector3.Lerp(
            transform.position, desiredPosition, smoothSpeed * Time.deltaTime
        );
        transform.position = smoothed;
    }
}
```

1. Attach to **Main Camera**.
2. Drag the **Player** into the **Target** field.
3. Press Play. The camera smoothly follows the player.

### CHECKPOINT 5 (FINAL)
> Complete game: player moves and jumps, camera follows, coins are collected with a score display, falling triggers Game Over with a Restart option.

---

## Complete File Summary

| Script | Attached To | Purpose |
|--------|------------|---------|
| `PlayerController2D.cs` | Player | Movement and jumping |
| `Coin.cs` | Coin prefab | Detects collection, awards points |
| `CoinBob.cs` | Coin prefab (optional) | Floating animation |
| `ScoreManager.cs` | ScoreManager (empty GO) | Tracks and displays score |
| `GameOverHandler.cs` | KillZone | Detects fall, shows Game Over, handles restart |
| `CameraFollow2D.cs` | Main Camera | Smooth camera follow |

---

## Extension Activities

For students who finish early:

1. **Add enemies**: Create a patrolling sprite that moves back and forth. Trigger Game Over on contact.
2. **Add a double jump**: Allow one extra jump while in the air. Track jumps with a counter.
3. **Add moving platforms**: Create a platform that moves between two points using `Vector3.MoveTowards` or a ping-pong pattern.
4. **Add sound effects**: Import a coin-collect sound clip. Play it with `AudioSource.PlayClipAtPoint()` when a coin is collected.
5. **Build a second level**: Create a new scene with a harder layout. Load it when all coins are collected.
6. **Add a lives system**: Give the player 3 lives. Respawn at the start instead of Game Over. Show lives on the UI.
