# Week 5: UI and Game Logic

## Lesson Overview

| Detail | Info |
|--------|------|
| **Duration** | ~90 minutes |
| **Objective** | Students build a UI with score display, buttons, and a game-over screen. They implement score tracking and scene management. |
| **Materials** | Platformer project from Week 4 (or any project with a playable character) |

---

## Part 1: The Canvas and UI System (20 min)

### How Unity UI Works

Unity's UI system is built around three core concepts:

1. **Canvas** -- A special GameObject that holds all UI elements. UI elements must be children of a Canvas.
2. **Rect Transform** -- The UI version of Transform. Uses anchors, pivots, and screen-relative positioning instead of world coordinates.
3. **UI Elements** -- Text, Image, Button, Slider, and more.

### Creating a Canvas

1. In the Hierarchy, right-click > **UI > Canvas**.
2. Unity also creates an **EventSystem** object automatically -- this handles clicks and input for UI.
3. Select the Canvas. In the Inspector, note **Canvas Scaler**:
   - Set **UI Scale Mode** to **Scale With Screen Size**.
   - Set **Reference Resolution** to `1920 x 1080`.
   - This ensures the UI looks consistent across different screen sizes.

> **Teacher tip:** The Canvas appears enormous in the Scene view because it matches screen pixel dimensions. Zoom out to see it, or use the 2D view toggle.

### Adding a Text Element

1. Right-click the **Canvas** in the Hierarchy > **UI > Text - TextMeshPro**.
2. If prompted to import TMP Essentials, click **Import TMP Essentials**.
3. Select the new text object. In the Inspector:
   - Set **Text** to `Score: 0`.
   - Set **Font Size** to `36`.
   - Set **Color** to white.
4. Use the **Rect Transform** anchors to pin the text to the **top-left** corner:
   - Click the anchor preset square in the Rect Transform > choose top-left.
   - Set **Pos X** to `120`, **Pos Y** to `-40`.

### Adding a Button

1. Right-click the Canvas > **UI > Button - TextMeshPro**.
2. Expand the Button in the Hierarchy -- it has a child **Text (TMP)** object.
3. Select the child text and change it to `Restart`.
4. Position the button in the center of the screen for now (we will use it in the Game Over screen later).

**Student check:** Every student should have a Canvas with a Score text in the top-left and a button visible in the Game view.

---

## Part 2: Score Tracking (20 min)

### The GameManager Script

Create a script called `GameManager` in `Assets/Scripts`:

```csharp
using UnityEngine;
using TMPro;

public class GameManager : MonoBehaviour
{
    public static GameManager Instance;

    public TextMeshProUGUI scoreText;
    private int score = 0;

    void Awake()
    {
        // Singleton pattern: only one GameManager exists
        if (Instance == null)
            Instance = this;
        else
            Destroy(gameObject);
    }

    void Start()
    {
        UpdateScoreDisplay();
    }

    public void AddScore(int points)
    {
        score += points;
        UpdateScoreDisplay();
    }

    private void UpdateScoreDisplay()
    {
        scoreText.text = "Score: " + score;
    }
}
```

### Setting It Up

1. Create an empty GameObject in the Hierarchy. Name it `GameManager`.
2. Attach the `GameManager` script.
3. Drag the **Score Text** object from the Hierarchy into the **Score Text** field in the Inspector.

### Collectible Script

Create a script called `Collectible`:

```csharp
using UnityEngine;

public class Collectible : MonoBehaviour
{
    public int pointValue = 10;

    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Player"))
        {
            GameManager.Instance.AddScore(pointValue);
            Destroy(gameObject);
        }
    }
}
```

### Creating Collectible Items

1. Create a small sprite (circle or star). Name it `Coin`.
2. Add a **Circle Collider 2D**. Check **Is Trigger**.
3. Attach the `Collectible` script.
4. Tag the player object as "Player":
   - Select the player. In the Inspector, click the **Tag** dropdown > **Player**.
5. Duplicate the coin several times (Ctrl+D / Cmd+D) and scatter them around the level.
6. Press Play, collect the coins, and watch the score update.

**Student check:** Score should increase when the player touches a coin, and the coin should disappear.

---

## Part 3: Game Over Screen (20 min)

### Creating the Game Over Panel

1. Right-click the **Canvas** > **UI > Panel**. Name it `GameOverPanel`.
2. This creates a semi-transparent overlay. Set the Image color to `(0, 0, 0, 200)` for a dark overlay.
3. Right-click `GameOverPanel` > **UI > Text - TextMeshPro**. Set text to `Game Over`, font size `72`, color white, center-aligned. Position it in the upper half.
4. Right-click `GameOverPanel` > **UI > Text - TextMeshPro**. Set text to `Final Score: 0`, font size `36`, color white. Position below "Game Over".
5. Move the `Restart` button (created earlier) so it is a child of `GameOverPanel`. Position it below the score.
6. **Disable** the GameOverPanel by unchecking the checkbox at the top of the Inspector. It should be hidden at the start of the game.

### Updating GameManager for Game Over

Add the following to the `GameManager` script:

```csharp
using UnityEngine.SceneManagement;

// Add these fields at the top of the class:
public GameObject gameOverPanel;
public TextMeshProUGUI finalScoreText;

// Add this method:
public void GameOver()
{
    gameOverPanel.SetActive(true);
    finalScoreText.text = "Final Score: " + score;
    Time.timeScale = 0f; // Pause the game
}

public void RestartGame()
{
    Time.timeScale = 1f; // Unpause
    SceneManager.LoadScene(SceneManager.GetActiveScene().name);
}
```

### Wiring Up the Button

1. Drag `GameOverPanel` and the Final Score text into the corresponding Inspector fields on GameManager.
2. Select the **Restart Button**.
3. In the Inspector, find the **On Click()** section.
4. Click **+** to add a new entry.
5. Drag the `GameManager` object into the object field.
6. In the function dropdown, select **GameManager > RestartGame**.

### Triggering Game Over

Add a kill zone to the level:

```csharp
using UnityEngine;

public class KillZone : MonoBehaviour
{
    void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("Player"))
        {
            GameManager.Instance.GameOver();
        }
    }
}
```

1. Create a wide, thin box below the level where the player would fall.
2. Add a **Box Collider 2D** with **Is Trigger** checked.
3. Attach the `KillZone` script.

**Student check:** Falling off the level should show the Game Over panel with the correct score. Clicking Restart should reload the scene.

---

## Part 4: Scene Management (15 min)

### Adding Scenes to the Build

1. Go to **File > Build Settings**.
2. Click **Add Open Scenes** to add the current scene.
3. Create a new scene (File > New Scene) for a main menu. Save it as `MainMenu`.
4. Add this scene to the Build Settings as well.
5. The order matters: scene at index 0 is loaded first.

### Loading Scenes from Code

```csharp
using UnityEngine.SceneManagement;

// Load by name
SceneManager.LoadScene("MainMenu");

// Load by build index
SceneManager.LoadScene(0);

// Get current scene name
string current = SceneManager.GetActiveScene().name;
```

### Simple Main Menu

Create a `MainMenu` script:

```csharp
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenu : MonoBehaviour
{
    public void PlayGame()
    {
        SceneManager.LoadScene("GameScene");
    }

    public void QuitGame()
    {
        Debug.Log("Quit clicked");
        Application.Quit();
    }
}
```

1. In the MainMenu scene, create a Canvas with:
   - A title text ("My Platformer").
   - A **Play** button wired to `PlayGame()`.
   - A **Quit** button wired to `QuitGame()`.
2. Attach `MainMenu` to an empty GameObject.
3. Wire each button's On Click() event to the appropriate function.

**Student check:** Play button loads the game scene. Game Over > Restart reloads the game. Verify the full loop works.

---

## Wrap-Up (5 min)

### Key Vocabulary

| Term | Definition |
|------|-----------|
| **Canvas** | The root UI container; all UI elements must be children of a Canvas |
| **TextMeshPro (TMP)** | Unity's advanced text rendering system, replacing the older Text component |
| **Rect Transform** | The Transform variant used by UI elements, with anchors and pivot points |
| **Singleton** | A design pattern ensuring only one instance of a class exists |
| **Time.timeScale** | Controls the speed of time; 0 pauses, 1 is normal speed |
| **SceneManager** | Unity class for loading and managing scenes |
| **On Click()** | The Button event that fires when the player clicks the button |

### Homework

- Add a timer that counts down from 60 seconds. Display it on screen. Trigger Game Over when time runs out.
- Add a "You Win!" screen that appears when the player collects all coins.
- Challenge: Add a high-score system that persists between plays using `PlayerPrefs.SetInt("HighScore", score)`.
- Weeks 6-8: Audio/polish, final project work, and presentations. Start thinking about your final game idea.
