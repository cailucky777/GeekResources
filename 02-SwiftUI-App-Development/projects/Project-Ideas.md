# SwiftUI Student Project Ideas

15 project ideas organized by difficulty. Each project is designed to be completed in 1-2 weeks and demonstrates core SwiftUI skills learned throughout the module.

---

## Easy (Beginner-Friendly)

These projects focus on views, layout, @State, and simple navigation. Suitable for students who have completed Weeks 1-3.

---

### 1. Digital Business Card

**Description:** A personal business card app with multiple pages -- one for contact info, one for skills, and one for a portfolio or photo gallery.

**Key Concepts Practiced:**
- VStack, HStack, ZStack layout
- Text and Image views with modifiers
- TabView for switching between pages
- SF Symbols

**Suggested Features:**
- Profile photo (or SF Symbol placeholder)
- Name, title, and short bio
- Contact row with email, phone, and website icons
- A "Skills" page with a list of skills and proficiency indicators
- A color theme toggle (light/dark)

**Extension Challenges:**
- Add a share button that copies contact info to the clipboard.
- Animate the profile photo on appear.
- Let the user edit their info with a form.

---

### 2. Tip Calculator

**Description:** An app that calculates the tip and total for a restaurant bill. The user enters the bill amount, selects a tip percentage, and sees the results update in real time.

**Key Concepts Practiced:**
- @State for reactive updates
- TextField with number formatting
- Picker (segmented) for tip percentage
- Computed properties

**Suggested Features:**
- Bill amount input field
- Tip percentage picker (10%, 15%, 18%, 20%, 25%, custom)
- Tip amount and total amount display
- Split-the-bill feature: divide by number of people

**Extension Challenges:**
- Save the most recent calculation using UserDefaults.
- Add a currency selector.
- Animate the total when it changes.

---

### 3. Flashcard Study App

**Description:** A simple flashcard app where students can tap a card to flip it and reveal the answer, then swipe to the next card.

**Key Concepts Practiced:**
- @State and conditional rendering
- Tap gestures
- TabView with .page style for swiping
- Rotation3DEffect for flip animation

**Suggested Features:**
- A deck of at least 10 flashcards (hardcoded)
- Tap a card to flip between question and answer
- Swipe left/right to move between cards
- A progress indicator (e.g., "Card 3 of 10")

**Extension Challenges:**
- Let users mark cards as "known" or "needs review."
- Add a shuffle button.
- Allow users to create their own cards via a form.

---

### 4. Color Palette Generator

**Description:** An app that displays random color palettes. The user taps a button to generate a new set of 5 colors, and can tap any color to copy its hex code.

**Key Concepts Practiced:**
- @State for dynamic data
- Color creation from RGB values
- HStack/VStack layout
- Button actions and random number generation

**Suggested Features:**
- Display 5 color swatches filling the screen vertically
- Each swatch shows its hex code
- A "Generate" button to create a new palette
- Tap a color to select it and see it enlarged

**Extension Challenges:**
- Add a "favorites" list that saves palettes.
- Add a lock icon on individual colors so they persist across generations.
- Show complementary color suggestions.

---

### 5. Daily Quote App

**Description:** An app that displays an inspirational quote each day, selected from a hardcoded collection. Includes a favorites feature.

**Key Concepts Practiced:**
- Structs as data models
- List and NavigationStack
- @State for favorites toggling
- Date-based logic

**Suggested Features:**
- A "Quote of the Day" main screen with large, styled text
- Attribution to the author below the quote
- A heart button to save to favorites
- A "Favorites" tab showing saved quotes
- A "Random" button for a surprise quote

**Extension Challenges:**
- Add a share sheet to share quotes as text.
- Animate the quote transition when tapping "Random."
- Categorize quotes by theme (motivation, humor, wisdom) with filtering.

---

## Medium (Intermediate)

These projects add data models, @Observable, CRUD operations, and more complex navigation. Suitable for students who have completed Weeks 1-5.

---

### 6. Recipe Book

**Description:** A recipe browsing app with categories, a recipe list, and detailed recipe views showing ingredients and step-by-step instructions.

**Key Concepts Practiced:**
- Nested NavigationStack and NavigationLink
- Structs for Recipe, Ingredient, Category models
- List with sections
- @Observable for a recipe store

**Suggested Features:**
- At least 3 categories (Breakfast, Lunch, Dinner) with 3+ recipes each
- Recipe detail view with ingredients list, instructions, and cook time
- A "Favorites" feature
- Search by recipe name

**Extension Challenges:**
- Add a "Shopping List" that aggregates ingredients from selected recipes.
- Let users add their own recipes via a form.
- Add a difficulty rating and filter by difficulty.

---

### 7. Habit Tracker

**Description:** An app to track daily habits. Users create habits, check them off each day, and see streaks and completion percentages.

**Key Concepts Practiced:**
- @Observable for shared state
- CRUD operations (create, read, update, delete habits)
- Date handling
- Progress indicators (ProgressView, custom bars)

**Suggested Features:**
- Add/edit/delete habits with name, icon (SF Symbol), and color
- Daily checklist view showing today's habits
- Streak counter for each habit
- Overall completion percentage for the day

**Extension Challenges:**
- Add a weekly calendar view showing completion history.
- Persist data with UserDefaults or JSON file storage.
- Add reminder notifications (local notifications).

---

### 8. Bookshelf / Reading List

**Description:** A personal library app where users can add books, track their reading status (want to read, reading, finished), and rate/review books.

**Key Concepts Practiced:**
- Enum for reading status
- @Observable data store
- Forms for data entry
- Segmented filtering

**Suggested Features:**
- Add books with title, author, genre, and cover color
- Three-tab filter: Want to Read, Currently Reading, Finished
- Detail view with notes and star rating (1-5)
- Swipe to delete

**Extension Challenges:**
- Add a search bar to find books by title or author.
- Show reading statistics (total books read, average rating).
- Sort by date added, title, or rating.

---

### 9. Workout Timer

**Description:** A fitness timer app for interval training. Users define exercises with work/rest periods, and the app counts down through each interval with visual and color cues.

**Key Concepts Practiced:**
- Timer and @State for countdown logic
- @Observable for workout configuration
- Color changes and animations for state transitions
- List for exercise management

**Suggested Features:**
- Create a workout with named exercises, work duration, and rest duration
- Large countdown timer display
- Green/red color coding for work/rest phases
- Audio or haptic feedback at transitions (optional)
- Pause and reset controls

**Extension Challenges:**
- Save custom workouts for reuse.
- Add a history log of completed workouts.
- Display total workout time and calories (estimated).

---

### 10. Mini Social Feed

**Description:** A mock social media feed (no networking) where users can create posts with text and emoji reactions, browse a feed, and view profiles.

**Key Concepts Practiced:**
- Multiple data models (User, Post, Comment)
- @Observable for a shared data store
- Complex list layouts with custom row views
- Sheet presentation for composing posts

**Suggested Features:**
- A scrollable feed of posts with author, timestamp, and content
- A "New Post" button that opens a compose sheet
- Like/heart button with animated count
- Profile view showing a user's posts
- At least 10 sample posts preloaded

**Extension Challenges:**
- Add comments to posts.
- Add image placeholders (colored rectangles) to posts.
- Implement pull-to-refresh that adds a random new post.

---

## Hard (Advanced)

These projects require combining many concepts, managing complex state, and building polished, multi-screen apps. Suitable for students who have completed the full module.

---

### 11. Personal Finance Tracker

**Description:** An app to log income and expenses, categorize transactions, and display spending summaries with charts.

**Key Concepts Practiced:**
- Complex data models (Transaction, Category, Budget)
- @Observable with computed properties for totals and summaries
- Forms with pickers, date pickers, and text fields
- Charts framework (Swift Charts) for visualization

**Suggested Features:**
- Add transactions with amount, category, date, and notes
- Dashboard showing balance, total income, and total expenses
- Bar or pie chart of spending by category
- Monthly/weekly date range filtering
- Category management (add/edit categories with colors and icons)

**Extension Challenges:**
- Set monthly budgets per category and show progress bars.
- Export transaction data as CSV.
- Add recurring transactions.

---

### 12. Pomodoro Study App

**Description:** A full-featured Pomodoro timer with task management, session tracking, and statistics.

**Key Concepts Practiced:**
- Timer, @State, @Observable
- App lifecycle events (background/foreground)
- Complex navigation (tabs + stack)
- Data persistence with JSON encoding/decoding

**Suggested Features:**
- Configurable work/break durations (default 25/5)
- Task list: assign Pomodoro sessions to specific tasks
- Session counter (how many Pomodoros completed today)
- Statistics view showing daily/weekly study time
- Ambient sound or visual themes during focus sessions

**Extension Challenges:**
- Persist session history across app launches.
- Add a "Focus Mode" that dims the screen to a minimal view.
- Implement long break logic (every 4 Pomodoros).

---

### 13. Travel Planner

**Description:** An app for planning trips with itineraries, packing lists, and destination information organized by day.

**Key Concepts Practiced:**
- Multiple related data models (Trip, Day, Activity, PackingItem)
- Deep navigation hierarchies
- Forms and date pickers
- Drag-to-reorder with .onMove

**Suggested Features:**
- Create trips with destination, date range, and cover color
- Day-by-day itinerary with time-slotted activities
- Packing checklist with check-off functionality
- Trip overview dashboard showing days until departure
- Edit and delete trips, days, and activities

**Extension Challenges:**
- Add a map placeholder for each destination.
- Share trip itinerary as formatted text.
- Add a budget tracker within each trip.

---

### 14. Music Playlist Manager

**Description:** A playlist management app (no audio playback required) with song browsing, playlist creation, drag-to-reorder, and a mock "Now Playing" screen with controls and animations.

**Key Concepts Practiced:**
- Multiple data models (Song, Playlist, Artist)
- Drag-and-drop reordering
- Complex animations (spinning album art, progress bar)
- Sheet and fullScreenCover presentations
- Search and filtering

**Suggested Features:**
- Browse a library of hardcoded songs organized by artist/album
- Create, rename, and delete playlists
- Add/remove songs from playlists
- Mock "Now Playing" screen with album art, play/pause button, and scrubber
- Search across all songs

**Extension Challenges:**
- Add genre-based filtering and sorting options.
- Animate transitions between the mini player and full-screen player.
- Create an "auto-playlist" feature that generates a playlist based on a selected genre.

---

### 15. Class Schedule and Assignment Tracker

**Description:** A school organizer app where students can manage their class schedule, log assignments with due dates, and track their grades.

**Key Concepts Practiced:**
- Complex interrelated models (Course, Assignment, Grade)
- @Observable with multiple stores
- Date handling and relative date formatting
- Conditional styling (overdue items, grade colors)
- Tab-based navigation with deep linking

**Suggested Features:**
- Weekly class schedule grid view
- Assignment list filtered by course, due date, or status
- Add assignments with title, description, due date, and course
- Grade tracker showing current grade per course
- Dashboard showing upcoming assignments and today's classes

**Extension Challenges:**
- Add push notification reminders for upcoming due dates.
- Calculate weighted GPA from course grades.
- Add a "Study Timer" that logs study time per course (integrating the Pomodoro concept).

---

## Choosing Your Project

Use these questions to help pick the right project:

1. **What interests you?** You will spend 1-2 weeks on this. Pick something you care about.
2. **What difficulty matches your skill level?** Be honest. It is better to finish a polished easy project than to struggle with an incomplete hard one.
3. **Can you define 3-5 core features?** If yes, you have a clear enough scope. If not, narrow it down.
4. **What will you learn?** Pick a project that stretches you in at least one new direction (animations, charts, complex navigation, etc.).

You are also welcome to propose your own project idea. Discuss it with your instructor to make sure the scope is appropriate.
