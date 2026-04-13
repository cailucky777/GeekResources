# Week 3: C# Scripting Basics in Unity

## Lesson Overview

| Detail | Info |
|--------|------|
| **Duration** | ~90 minutes |
| **Objective** | Students write C# scripts to declare variables, use Start() and Update(), read player input, and move a GameObject with code. |
| **Materials** | Unity project, Visual Studio Code (or Visual Studio) with C# extension |

---

## Part 1: Your First Script (25 min)

### Creating a Script

1. In the **Project** panel, right-click on the `Assets` folder > **Create > Folder**. Name it `Scripts`.
2. Open the `Scripts` folder. Right-click > **Create > C# Script**. Name it `HelloWorld`.
3. **Important:** Name the script before pressing Enter. If you rename it later, you must also rename the class inside the file to match.
4. Double-click the script to open it in your code editor.

### Anatomy of a Unity Script

```csharp
using UnityEngine;

public class HelloWorld : MonoBehaviour
{
    // Start is called once when the script first runs
    void Start()
    {
        Debug.Log("Hello, Unity!");
    }

    // Update is called once per frame (60+ times per second)
    void Update()
    {

    }
}
```

Walk through each part:

| Part | Explanation |
|------|-------------|
| `using UnityEngine;` | Imports Unity's library so we can use Unity features |
| `public class HelloWorld : MonoBehaviour` | Defines a class that inherits from MonoBehaviour (required for all Unity scripts) |
| `Start()` | Runs once when the game starts or when the object is first created |
| `Update()` | Runs every single frame -- this is where real-time logic goes |
| `Debug.Log()` | Prints a message to the Console panel |

### Attaching the Script

1. Create a **Cube** in the scene (or select an existing object).
2. Drag the `HelloWorld` script from the Project panel onto the Cube in the Hierarchy (or use **Add Component** in the Inspector).
3. Press **Play**. Open the **Console** panel. You should see "Hello, Unity!" printed once.

**Student check:** Every student should see the message in the Console.

---

## Part 2: Variables (15 min)

### Declaring Variables

```csharp
public class VariableDemo : MonoBehaviour
{
    // Public variables appear in the Inspector
    public int score = 0;
    public float speed = 5.0f;
    public string playerName = "Player 1";
    public bool isAlive = true;

    // Private variables do NOT appear in the Inspector
    private int secretNumber = 42;

    void Start()
    {
        Debug.Log("Player: " + playerName);
        Debug.Log("Speed: " + speed);
        Debug.Log("Score: " + score);
    }
}
```

### Key Points

- **public** variables show up in the Inspector and can be edited without touching code.
- **private** variables are hidden from the Inspector (they are internal to the script).
- **float** numbers must end with `f` (e.g., `5.0f`).
- Variable names use **camelCase** (e.g., `playerName`, `moveSpeed`).

### Hands-On

1. Create a new script called `VariableDemo`.
2. Type the code above.
3. Attach it to a GameObject.
4. Press Play and check the Console.
5. **Without stopping Play mode**, look at the Inspector -- notice the public variables are editable. Change `speed` to 10 and see the Console still shows 5 (because Start already ran).
6. Stop Play. Change `speed` in the Inspector to 10. Play again -- now Start prints 10.

> **Teacher note:** Reinforce that Inspector values override the defaults written in code, and that changes made during Play mode are lost.

---

## Part 3: Update() and Time (15 min)

### The Game Loop

- `Update()` runs once per frame.
- On a 60 FPS game, Update runs 60 times per second.
- This is where you check for input, move objects, and run real-time logic.

### Time.deltaTime

- `Time.deltaTime` is the time (in seconds) since the last frame.
- Multiplying movement by `Time.deltaTime` makes it **frame-rate independent**.
- Without it, objects move faster on faster computers.

```csharp
void Update()
{
    // This moves 5 units per SECOND, regardless of frame rate
    float distance = speed * Time.deltaTime;
    Debug.Log("Distance this frame: " + distance);
}
```

---

## Part 4: Input Handling (15 min)

### Reading Keyboard Input

```csharp
void Update()
{
    // Returns true every frame the key is held down
    if (Input.GetKey(KeyCode.W))
    {
        Debug.Log("W is being held");
    }

    // Returns true only on the frame the key is first pressed
    if (Input.GetKeyDown(KeyCode.Space))
    {
        Debug.Log("Space was just pressed");
    }

    // Returns true only on the frame the key is released
    if (Input.GetKeyUp(KeyCode.Space))
    {
        Debug.Log("Space was just released");
    }
}
```

### Input Axes

Unity provides built-in input axes for common controls:

```csharp
void Update()
{
    // Returns a value from -1 to 1
    // Left arrow / A key = -1, Right arrow / D key = 1
    float horizontal = Input.GetAxis("Horizontal");

    // Down arrow / S key = -1, Up arrow / W key = 1
    float vertical = Input.GetAxis("Vertical");

    Debug.Log("H: " + horizontal + " V: " + vertical);
}
```

**Student check:** Create a script that logs axis values. Attach it and press Play. Press WASD or arrow keys and watch the Console.

---

## Part 5: Moving Objects with Code (20 min)

### The Movement Script

This is the core script students will reuse and modify throughout the course.

```csharp
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    public float speed = 5.0f;

    void Update()
    {
        // Read input
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");

        // Create a direction vector
        Vector3 direction = new Vector3(horizontal, 0, vertical);

        // Move the object
        transform.Translate(direction * speed * Time.deltaTime);
    }
}
```

### Step-by-Step

1. Create a new script called `PlayerMovement`. Type the code above.
2. Create a scene with a **Plane** (ground) and a **Cube** (player).
3. Attach `PlayerMovement` to the Cube.
4. Press **Play**. Use WASD or arrow keys to move the cube around.
5. Adjust the `speed` value in the Inspector while in Play mode to find a good speed. Remember the value, stop Play, and set it permanently.

### Explanation

| Line | What It Does |
|------|-------------|
| `Input.GetAxis("Horizontal")` | Returns -1 to 1 based on A/D or Left/Right keys |
| `Vector3 direction` | Packs the input into a 3D direction (X = left/right, Z = forward/back) |
| `transform.Translate(...)` | Moves this object by the given amount |
| `* speed * Time.deltaTime` | Scales movement by speed and makes it frame-rate independent |

### Challenge Additions

Once basic movement works, students can try:

1. **Add rotation:** Make the object face the direction of movement.
   ```csharp
   if (direction != Vector3.zero)
   {
       transform.rotation = Quaternion.LookRotation(direction);
   }
   ```

2. **Clamp position:** Prevent the player from moving off the plane.
   ```csharp
   Vector3 pos = transform.position;
   pos.x = Mathf.Clamp(pos.x, -5f, 5f);
   pos.z = Mathf.Clamp(pos.z, -5f, 5f);
   transform.position = pos;
   ```

3. **Sprint:** Move faster when holding Left Shift.
   ```csharp
   float currentSpeed = Input.GetKey(KeyCode.LeftShift) ? speed * 2 : speed;
   transform.Translate(direction * currentSpeed * Time.deltaTime);
   ```

---

## Wrap-Up (5 min)

### Key Vocabulary

| Term | Definition |
|------|-----------|
| **MonoBehaviour** | The base class for all Unity scripts that attach to GameObjects |
| **Start()** | Called once when the script is first activated |
| **Update()** | Called every frame; used for real-time logic |
| **Time.deltaTime** | Time elapsed since the last frame; used for frame-rate-independent movement |
| **Input.GetAxis()** | Returns a -1 to 1 value for built-in input axes (Horizontal, Vertical) |
| **transform.Translate()** | Moves the GameObject by a given offset |
| **Vector3** | A data type representing a 3D point or direction (x, y, z) |

### Homework

- Modify the movement script so the player can also move up and down (Y axis) using Q and E keys (use `Input.GetKey`).
- Challenge: Make a "collectible" cube that prints a message to the Console when the player touches it (hint: look up `OnTriggerEnter` in the Unity docs).
- Next week: 2D game basics -- sprites, 2D physics, and building a platformer.
