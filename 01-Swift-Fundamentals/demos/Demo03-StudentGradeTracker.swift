// =============================================================
// Demo 03: Student Grade Tracker
// Module: Swift Fundamentals
// Topics: Arrays, dictionaries, functions, closures (map,
//         filter, reduce), optionals, string formatting
//
// TEACHER NOTES:
// - This demo synthesizes concepts from Weeks 1-5.
// - Best used during or after Week 4 (Collections).
// - Walk through each section, pausing to ask students to
//   predict output before running.
// - The closure syntax progresses from verbose to shorthand --
//   show each step of the simplification process.
// =============================================================

import Foundation

// -------------------------------------------------------------
// SECTION 1: Data Setup
// TEACHER: We use a dictionary of [String: [Int]] to map each
// student's name to an array of their test scores.
// Ask: "Why is an array good for storing multiple scores?"
// -------------------------------------------------------------

var gradeBook: [String: [Int]] = [
    "Alex":    [88, 92, 79, 95, 84],
    "Jordan":  [72, 68, 75, 80, 71],
    "Sam":     [95, 98, 92, 97, 100],
    "Taylor":  [60, 55, 63, 58, 70],
    "Morgan":  [85, 88, 82, 90, 86],
    "Casey":   [78, 82, 74, 69, 80]
]

print("===========================================")
print("       STUDENT GRADE TRACKER")
print("===========================================\n")

// -------------------------------------------------------------
// SECTION 2: Basic Functions
// TEACHER: Start with straightforward functions that use
// loops. Students should be comfortable with this from Week 3.
// -------------------------------------------------------------

/// Calculates the average of an array of integers.
/// Returns a Double for precision.
func average(of scores: [Int]) -> Double {
    // TEACHER: Ask students why we convert to Double here.
    let total = scores.reduce(0, +)
    return Double(total) / Double(scores.count)
}

/// Converts a numeric average to a letter grade.
func letterGrade(for average: Double) -> String {
    switch average {
    case 90...100:
        return "A"
    case 80..<90:
        return "B"
    case 70..<80:
        return "C"
    case 60..<70:
        return "D"
    default:
        return "F"
    }
}

// -------------------------------------------------------------
// SECTION 3: Print All Student Averages
// TEACHER: Iterate over the dictionary. Note that dictionary
// order is not guaranteed -- the output order may differ each run.
// -------------------------------------------------------------

print("--- Individual Student Reports ---\n")

// TEACHER: sorted(by:) is used here so the output is alphabetical.
// This is a closure! Point out the shorthand $0 and $1 syntax.
for (name, scores) in gradeBook.sorted(by: { $0.key < $1.key }) {
    let avg = average(of: scores)
    let grade = letterGrade(for: avg)
    let scoreList = scores.map { String($0) }.joined(separator: ", ")
    print("  \(name)")
    print("    Scores: \(scoreList)")
    print("    Average: \(String(format: "%.1f", avg)) (\(grade))")
    print()
}

// -------------------------------------------------------------
// SECTION 4: Using map -- Transform Data
// TEACHER: Demonstrate map step by step.
// Start with the full closure syntax and simplify.
// -------------------------------------------------------------

print("--- Using map: Student Averages ---\n")

// Full closure syntax (verbose)
let averages1 = gradeBook.map({ (entry: (key: String, value: [Int])) -> String in
    let avg = average(of: entry.value)
    return "\(entry.key): \(String(format: "%.1f", avg))"
})

// TEACHER: Now show the simplified version -- same result, less code.
let averages = gradeBook
    .sorted { $0.key < $1.key }
    .map { "\($0.key): \(String(format: "%.1f", average(of: $0.value)))" }

for entry in averages {
    print("  \(entry)")
}
print()

// -------------------------------------------------------------
// SECTION 5: Using filter -- Select Data
// TEACHER: filter keeps only elements where the closure returns true.
// Ask: "What does 'passing' mean here? How would you change the threshold?"
// -------------------------------------------------------------

print("--- Using filter: Honor Roll (Average >= 85) ---\n")

let honorRoll = gradeBook
    .filter { average(of: $0.value) >= 85.0 }
    .sorted { $0.key < $1.key }

if honorRoll.isEmpty {
    print("  No students on the honor roll.")
} else {
    for (name, scores) in honorRoll {
        print("  \(name) -- Average: \(String(format: "%.1f", average(of: scores)))")
    }
}
print()

// TEACHER: Now filter for students who need extra help.
print("--- Using filter: Students Needing Support (Average < 75) ---\n")

let needsSupport = gradeBook
    .filter { average(of: $0.value) < 75.0 }
    .sorted { $0.key < $1.key }

if needsSupport.isEmpty {
    print("  All students are above 75. Great job!")
} else {
    for (name, scores) in needsSupport {
        print("  \(name) -- Average: \(String(format: "%.1f", average(of: scores)))")
    }
}
print()

// -------------------------------------------------------------
// SECTION 6: Using reduce -- Aggregate Data
// TEACHER: reduce combines all elements into a single value.
// Walk through how the accumulator works step by step.
// -------------------------------------------------------------

print("--- Using reduce: Class Statistics ---\n")

// Collect all scores into one flat array
// TEACHER: flatMap flattens [[Int]] into [Int]
let allScores = gradeBook.values.flatMap { $0 }

// Total points across all students
let totalPoints = allScores.reduce(0, +)
print("  Total points earned (all students): \(totalPoints)")

// Class average
let classAverage = Double(totalPoints) / Double(allScores.count)
print("  Class average: \(String(format: "%.1f", classAverage))")

// Highest and lowest scores
// TEACHER: Show that reduce can do more than just sum.
let highest = allScores.reduce(Int.min) { max($0, $1) }
let lowest = allScores.reduce(Int.max) { min($0, $1) }
print("  Highest score: \(highest)")
print("  Lowest score: \(lowest)")

// Count of passing scores (>= 70)
let passingCount = allScores.filter { $0 >= 70 }.count
let passingPercent = Double(passingCount) / Double(allScores.count) * 100
print("  Passing scores (>= 70): \(passingCount)/\(allScores.count) (\(String(format: "%.0f", passingPercent))%)")
print()

// -------------------------------------------------------------
// SECTION 7: Chaining map, filter, and reduce
// TEACHER: This is the power of functional programming.
// Show how you can chain operations for complex transformations
// in a readable way.
// -------------------------------------------------------------

print("--- Chaining: Top Scores Summary ---\n")

// Get the names and averages of students with A grades, sorted by average descending
let topStudents = gradeBook
    .map { (name: $0.key, avg: average(of: $0.value)) }       // Transform to tuples
    .filter { $0.avg >= 90 }                                    // Keep only A students
    .sorted { $0.avg > $1.avg }                                 // Sort by average, highest first

if topStudents.isEmpty {
    print("  No students with an A average.")
} else {
    print("  Students with A averages:")
    for student in topStudents {
        print("    \(student.name): \(String(format: "%.1f", student.avg))")
    }
}
print()

// -------------------------------------------------------------
// SECTION 8: Adding New Data
// TEACHER: Show mutating the dictionary -- adding a new student
// and appending a score to an existing student.
// Preview of optionals: gradeBook["NewStudent"] might be nil.
// -------------------------------------------------------------

print("--- Updating the Grade Book ---\n")

// Add a new student
gradeBook["Riley"] = [91, 87, 93, 89, 95]
print("  Added Riley to the grade book.")

// Add a new score to an existing student
// TEACHER: Explain why we use optional chaining here.
// If the student does not exist, nothing happens (no crash).
gradeBook["Alex"]?.append(91)
print("  Added a new score for Alex.")

// Try to add to a non-existent student (demonstrates optionals)
gradeBook["Unknown"]?.append(50)  // Does nothing -- "Unknown" is nil
print("  Tried to add score for 'Unknown' -- nothing happened (nil).")

// Print updated info
if let alexScores = gradeBook["Alex"] {
    print("  Alex's updated scores: \(alexScores)")
    print("  Alex's new average: \(String(format: "%.1f", average(of: alexScores)))")
}

print("\n===========================================")
print("       END OF GRADE TRACKER DEMO")
print("===========================================")

// =============================================================
// CHALLENGE FOR STUDENTS:
// 1. Add a function that finds the most improved student
//    (biggest difference between first and last score)
// 2. Add a function that drops the lowest score for each student
//    before calculating the average
// 3. Create a "report card" function that prints a formatted
//    summary for a single student
// 4. Add letter grade distribution (how many As, Bs, Cs, etc.)
//    using reduce with a dictionary accumulator
// =============================================================
