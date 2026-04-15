# Prompt Engineering Basics

> The model is only as good as the question you ask.

"Prompt engineering" is a fancy term for **writing clear instructions to an AI.** The rules are basically the rules of good writing, plus a few AI-specific tricks.

---

## 1. Be Specific About the Output

**Vague:** "Help me with my essay."

**Clear:** "Improve the grammar of the paragraph below. Keep the meaning and tone identical. Respond with only the revised paragraph — no explanation."

---

## 2. Show, Don't Just Tell (Few-Shot)

Give the model examples of what you want.

```
Convert these sentences to past tense.

Input: I eat lunch.
Output: I ate lunch.

Input: She writes a letter.
Output: She wrote a letter.

Input: We run every morning.
Output:
```

Models imitate the pattern.

---

## 3. Use Structure

Headings, numbered lists, and XML-style tags help the model separate parts of your prompt.

```
You are a grading assistant.

<rubric>
- Clarity: 5 pts
- Accuracy: 5 pts
</rubric>

<student_answer>
{the student's text}
</student_answer>

Return JSON: { "clarity": n, "accuracy": n, "feedback": "..." }
```

---

## 4. Ask for a Format You Can Parse

For apps, ask for JSON or a fixed shape:

```
Respond ONLY with valid JSON of this shape:
{ "summary": "...", "sentiment": "positive" | "neutral" | "negative" }
```

Don't forget to actually `JSONDecoder().decode(...)` it in Swift.

---

## 5. Give a Persona

> "You are a patient 5th-grade math tutor. Use simple words and lots of encouragement."

Personas bias the model toward the right style in one line.

---

## 6. Think Step-by-Step

For reasoning problems, say so:

> "Think step by step, then give the final answer on a new line that starts with `Answer:`"

For Claude, `<thinking>` blocks also work well:

> "Use a `<thinking>` block to reason, then give the final answer after `</thinking>`."

---

## 7. Iterate

Your first prompt is never your best one. When a response disappoints:

1. Add a constraint ("in under 100 words").
2. Add an example of what *good* looks like.
3. Tell it what **not** to do.
4. Move important instructions to the end — they get the most attention.

---

## Bad vs Good: Worked Examples

### Translation app

- ❌ "Translate this." (to what?)
- ✅ "Translate the following English text to Japanese. Preserve the original tone and formatting. If names or brand terms appear, leave them in English."

### Recipe generator

- ❌ "Give me a recipe."
- ✅ "Given the ingredients below, suggest one dinner recipe that uses at least 80% of them. Output: Title, 3-sentence description, ingredient list with quantities, numbered steps. Under 200 words total."

### Homework helper

- ❌ "Is this right?"
- ✅ "I solved this problem: `[problem]`. My answer: `[answer]`. Check whether my answer is correct. Do NOT give me the correct answer. Only tell me if I'm right, and if not, point out which step contains the mistake."

---

## Safety Prompts for Student-Facing Apps

Add a system prompt like:

> "You are speaking to a middle-school student. Do not produce adult content, insults, or instructions for anything dangerous. If the student asks about something unsafe, gently redirect them to ask a parent or teacher."

---

## Exercise

Take one app idea. Write **three different prompts** for the same task:

1. Minimal (one sentence).
2. Structured (with examples and format).
3. Strict (with output format and safety rules).

Run all three. Which one is best? Why?
