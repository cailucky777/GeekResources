# Demo 01: Roll a Ball

A classroom-adapted version of Unity's classic "Roll a Ball" tutorial. Students build a complete mini-game where a ball rolls around a board, collects pickups, and displays a score.

---

## Overview

| Detail | Info |
|--------|------|
| **Estimated Time** | 60-75 minutes |
| **Difficulty** | Beginner |
| **Unity Template** | 3D (URP) |
| **Concepts Covered** | Rigidbody, input, forces, triggers, UI, prefabs |

### What Students Will Build

A top-down game where the player controls a ball using WASD/arrow keys. The ball rolls around a walled arena, collecting spinning cubes. A score counter tracks progress, and a "You Win!" message appears when all items are collected.

---

## Teacher Notes

- This demo works best after completing Weeks 1-3. Students should already be familiar with the Editor, GameObjects, components, and basic scripting.
- Allocate extra time for students who type slowly -- the scripting sections can be a bottleneck.
- Have the finished project ready on your machine so you can show the end result before students start.

---

## Checkpoint System

The demo is divided into checkpoints. At each checkpoint, pause and verify every student has reached the same state before continuing.

---

## Step 1: Project Setup

1. Open Unity Hub. Click **New Project**.
2. Select the **3D (URP)** template.
3. Name the project `RollABall`.
4. Click **Create Project**.
5. Once the Editor opens, save the default scene as `MiniGame` (File > Save As > create a `Scenes` folder > save).

---

## Step 2: Create the Playing Field

1. Hierarchy > right-click > **3D Object > Plane**. Rename it `Ground`.
2. Set Transform:
   - Position: `(0, 0, 0)`
   - Scale: `(2, 1, 2)`
3. Create a material called `GroundMaterial` in `Assets/Materials` (create the folder).
   - Set Base Map color to a dark teal/green.
   - Apply it to the Ground.

### CHECKPOINT 1
> Every student should have a colored ground plane centered at the origin.

---

## Step 3: Create the Player Ball

1. Hierarchy > right-click > **3D Object > Sphere**. Rename it `Player`.
2. Set Position to `(0, 0.5, 0)`.
3. Add a **Rigidbody** component (Add Component > Rigidbody).
4. Create a `PlayerMaterial` (bright blue). Apply it to the Player.

---

## Step 4: Move the Player with Code

1. Create `Assets/Scripts` folder.
2. Create a C# script called `PlayerController`.
3. Double-click to open and replace the contents with:

```csharp
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public float speed = 10f;

    private Rigidbody rb;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
    }

    void FixedUpdate()
    {
        float moveHorizontal = Input.GetAxis("Horizontal");
        float moveVertical = Input.GetAxis("Vertical");

        Vector3 movement = new Vector3(moveHorizontal, 0.0f, moveVertical);
        rb.AddForce(movement * speed);
    }
}
```

4. Save the script. Return to Unity.
5. Attach `PlayerController` to the **Player** object (drag script onto the object).
6. Press **Play**. Use WASD or arrow keys to roll the ball.

> **Teacher note:** We use `FixedUpdate()` instead of `Update()` because we are applying physics forces. `FixedUpdate` runs at a fixed interval and is the correct place for Rigidbody operations.

### CHECKPOINT 2
> Every student's ball should roll around with keyboard input.

---

## Step 5: Set Up the Camera

1. Select **Main Camera**.
2. Set Position to `(0, 10, -10)` and Rotation to `(45, 0, 0)`.
3. Create a script called `CameraController`:

```csharp
using UnityEngine;

public class CameraController : MonoBehaviour
{
    public Transform player;

    private Vector3 offset;

    void Start()
    {
        offset = transform.position - player.position;
    }

    void LateUpdate()
    {
        transform.position = player.position + offset;
    }
}
```

4. Attach `CameraController` to **Main Camera**.
5. Drag the **Player** object into the **Player** field in the Inspector.
6. Press Play -- the camera should follow the ball.

> **Teacher note:** We use `LateUpdate()` for the camera so it moves after the player has finished moving, preventing jitter.

---

## Step 6: Build the Walls

1. Create a **Cube**. Rename it `WallNorth`.
2. Set Position to `(0, 0.5, 10)` and Scale to `(20.5, 1, 0.5)`.
3. Duplicate it (Ctrl+D / Cmd+D). Rename to `WallSouth`. Set Position to `(0, 0.5, -10)`.
4. Duplicate again. Rename to `WallEast`. Set Position to `(10, 0.5, 0)` and Scale to `(0.5, 1, 20.5)`.
5. Duplicate. Rename to `WallWest`. Set Position to `(-10, 0.5, 0)` and Scale to `(0.5, 1, 20.5)`.
6. Create a dark gray material and apply it to all four walls.
7. Select all four walls, right-click > **Create Empty Parent**. Name the parent `Walls`.

8. Press Play. The ball should stay inside the walled area.

### CHECKPOINT 3
> Ball rolls, camera follows, and the ball bounces off all four walls.

---

## Step 7: Create Collectible Pickups

1. Create a **Cube**. Rename it `Pickup`.
2. Set Position to `(2, 0.5, 2)`.
3. Set Rotation to `(45, 45, 45)` so it looks like a diamond.
4. Set Scale to `(0.5, 0.5, 0.5)`.
5. Create a bright yellow material and apply it.

### Make It Spin

Create a script called `Rotator`:

```csharp
using UnityEngine;

public class Rotator : MonoBehaviour
{
    public float rotateSpeed = 45f;

    void Update()
    {
        transform.Rotate(new Vector3(15, 30, 45) * rotateSpeed * Time.deltaTime);
    }
}
```

Attach `Rotator` to the Pickup. Press Play to verify it spins.

### Make It a Trigger

1. Select the Pickup. In the **Box Collider** component, check **Is Trigger**.
2. The ball will now pass through the pickup instead of bouncing off it. We will detect the overlap in code.

### Turn It into a Prefab

1. Create an `Assets/Prefabs` folder.
2. Drag the `Pickup` from the Hierarchy into the `Prefabs` folder. It becomes a **Prefab** (the name turns blue in the Hierarchy).
3. Now you can drag the prefab from the Project panel into the scene to create copies.
4. Place **8-12 pickups** around the arena at various positions.

### CHECKPOINT 4
> Multiple spinning yellow cubes are scattered around the arena.

---

## Step 8: Collect the Pickups

Add to the `PlayerController` script:

```csharp
    private int pickupCount;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
        pickupCount = GameObject.FindGameObjectsWithTag("Pickup").Length;
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Pickup"))
        {
            other.gameObject.SetActive(false);
            pickupCount--;

            if (pickupCount <= 0)
            {
                Debug.Log("You Win!");
            }
        }
    }
```

### Tag the Pickups

1. Select one Pickup in the scene. Click the **Tag** dropdown > **Add Tag**.
2. Create a new tag called `Pickup`.
3. Select the Pickup **Prefab** (in the Project panel, not the scene). Set its Tag to `Pickup`.
4. Click **Apply All** (or Overrides > Apply All) so all instances get the tag.
5. Verify in the scene that all pickups show the `Pickup` tag.

Press Play. Roll into the pickups -- they should disappear. Collect all of them and check the Console for "You Win!"

### CHECKPOINT 5
> Pickups disappear on contact. "You Win!" prints in the Console when all are collected.

---

## Step 9: Add the Score UI

1. Hierarchy > right-click > **UI > Text - TextMeshPro**. Import TMP Essentials if prompted.
2. Rename the text to `ScoreText`.
3. Set anchor to top-left. Set Pos X to `120`, Pos Y to `-40`.
4. Set Font Size to `32`, Color to white, Text to `Score: 0`.

### Create a Win Text

1. Duplicate `ScoreText`. Rename to `WinText`.
2. Set anchor to center. Set Pos X to `0`, Pos Y to `50`.
3. Set Font Size to `48`, Color to white, Text to `You Win!`.
4. **Disable** the WinText object (uncheck the checkbox).

### Update PlayerController

Add these fields and update the methods:

```csharp
using TMPro;

// Add these fields:
public TextMeshProUGUI scoreText;
public GameObject winTextObject;
private int score;

// In Start(), add:
score = 0;
UpdateScoreText();
winTextObject.SetActive(false);

// In OnTriggerEnter(), replace Debug.Log with:
score++;
UpdateScoreText();
if (pickupCount <= 0)
{
    winTextObject.SetActive(true);
}

// Add this method:
void UpdateScoreText()
{
    scoreText.text = "Score: " + score;
}
```

Wire up the references:
1. Select the Player. Drag `ScoreText` into the **Score Text** field.
2. Drag `WinText` into the **Win Text Object** field.
3. Press Play. Collect pickups and watch the score increase. Collect all to see "You Win!"

### CHECKPOINT 6 (FINAL)
> Complete game: ball rolls, camera follows, pickups spin and disappear, score updates, "You Win!" shows when all pickups are collected.

---

## Complete PlayerController Script (Reference)

```csharp
using UnityEngine;
using TMPro;

public class PlayerController : MonoBehaviour
{
    public float speed = 10f;
    public TextMeshProUGUI scoreText;
    public GameObject winTextObject;

    private Rigidbody rb;
    private int score;
    private int pickupCount;

    void Start()
    {
        rb = GetComponent<Rigidbody>();
        score = 0;
        pickupCount = GameObject.FindGameObjectsWithTag("Pickup").Length;
        UpdateScoreText();
        winTextObject.SetActive(false);
    }

    void FixedUpdate()
    {
        float moveHorizontal = Input.GetAxis("Horizontal");
        float moveVertical = Input.GetAxis("Vertical");

        Vector3 movement = new Vector3(moveHorizontal, 0.0f, moveVertical);
        rb.AddForce(movement * speed);
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Pickup"))
        {
            other.gameObject.SetActive(false);
            pickupCount--;
            score++;
            UpdateScoreText();

            if (pickupCount <= 0)
            {
                winTextObject.SetActive(true);
            }
        }
    }

    void UpdateScoreText()
    {
        scoreText.text = "Score: " + score;
    }
}
```

---

## Extension Activities

For students who finish early:

1. **Add a timer** that counts up and displays elapsed time.
2. **Add obstacles** (static cubes) that the ball must navigate around.
3. **Add a restart button** that reloads the scene (use `SceneManager.LoadScene`).
4. **Change the ball color** each time a pickup is collected using `GetComponent<Renderer>().material.color`.
5. **Add a second level** with a different layout and load it when all pickups are collected.
