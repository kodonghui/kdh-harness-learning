---
name: kdh-study
description: "Non-developer study companion — FSRS spaced repetition + 4 quiz types (T/F, MC, fill-in, short-answer) + dashboard. Learn agent harnesses or any technical concept."
---

# /kdh-study — Study Companion for Non-Developers

A spaced-repetition study tool for technical concepts, business terms, or any knowledge you want to retain.
FSRS v6 scheduling + 4 quiz types for efficient long-term memory.

**Audience: Non-developers.** No code to write, no code to read — diagrams, analogies, and tables only.

**Paths (relative to repo root):**
- Concept cards: `./concepts/{slug}.yaml`
- Profile: `./profile.local.yaml` (fallback: `./profile.yaml`)
- FSRS calculator: `./scripts/fsrs-calc.ts`
- Curriculum modules: `./curriculum/modules/*.yaml`

## Usage

```
/kdh-study [topic]           → Learn or review
/kdh-study                   → Dashboard + review suggestions
/kdh-study 이거뭐야 [term]   → 30-second instant explanation
```

## Input Routing (priority order)

Auto-detected. No mode-selection UI.

```
1. Input contains "이거뭐야" / "이게뭐야" / "뭐야" / "what is"
   → Instant explanation mode (always highest priority)

2. Topic provided AND ./concepts/{slug}.yaml exists
   → Review quiz

3. Topic provided AND no existing card
   → New concept learning

4. No topic AND due cards exist (fsrs_card.due in the past)
   → Show dashboard + suggest "Review X?"

5. No topic AND no due cards
   → Show dashboard + ask "What would you like to study?"
```

## Topic Matching

```
1. Convert input to slug (kebab-case, Korean → English transliteration)
   예: "DB 인덱스" → db-index, "논증구조" → argumentation-structure

2. Check concepts/ for topic_key match

3. If no match, search aliases arrays for partial match

4. Low confidence match: ask "Did you mean X?"

5. No match: treat as new concept
```

## Topic Scope Limits

Too-broad topics → ask to narrow:

```
"database" → "What about databases? Indexes? Transactions? Joins?"
"AI" → "Which part of AI? LLMs? Prompting? Fine-tuning?"
"harness" → "Which aspect? Tool layer? Memory? Orchestration?"
```

Rule: category-level terms (≤2 chars OR has 5+ sub-concepts) → ask to narrow.

---

## Dashboard (when invoked without topic)

`/kdh-study` scans `./concepts/` and displays:

```
--- Study Status ---
Total: 12 | Due today: 3 | Avg mastery: 0.45

  DB Index        ████████░░ 0.8  4 days
  API             ██████░░░░ 0.6  tomorrow
  Transactions    ████░░░░░░ 0.4  today ←
  Argumentation   ██░░░░░░░░ 0.2  today ←

Review now? (review / new topic / later)
```

- Bars: mastery 0.0–1.0 as 10 cells (█ = filled, ░ = empty)
- "today ←" = fsrs_card.due before now
- If concepts/ is empty: skip dashboard → "What would you like to study?"

---

## Instant Explanation Mode ("이거뭐야")

**30 seconds, no more.**

Structure:
```
1. One-line definition
2. One analogy (something familiar from daily life)
3. One line of practical connection ("In practice..." or "For example...")
```

- Logs to `./concepts/{slug}.yaml` (mastery 0.1, fsrs_card = new)
- FSRS: `bun run ./scripts/fsrs-calc.ts new` → initial fsrs_card
- If there are follow-up questions, continue the conversation naturally

---

## New Concept Learning (4 steps — progressive disclosure)

### Step 1: Question
```
"What happens if there's no DB index?"
```
- Prompt the learner to try
- Don't force it — "I don't know" is fine immediately

### Step 2: Hint
```
"Think about finding a book in a library. If there's a catalog card..."
```
- One analogy or clue

### Step 3: Answer
```
Index = library catalog card.
Without it: scan all 100k books from start (Full Table Scan).
With it: jump directly to the right shelf (Index Scan).
```

**Presentation variety** (don't repeat the same format every time):
- Abstract concept → analogy
- Technical structure → diagram or table
- Comparable things → comparison table
- Process/flow → numbered steps
- Numbers/data → concrete example numbers

### Step 4: Practical Connection
```
In real services like e-commerce, the `orders` table has an index on `user_id`.
Without it, "show this user's orders" would scan the entire orders table.
```
- Connect to real-world services (familiar brands, well-known patterns)
- If not possible, use a simple made-up scenario

### Completion Handling
1. Create `./concepts/{slug}.yaml` (schema_version: 2)
2. `bun run ./scripts/fsrs-calc.ts new` → initial fsrs_card
3. mastery: 0.1
4. Add first entry to review_log

### Escape Hatches (required)

```
"I don't know" / "answer me" / "skip" / "모르겠어"
  → Jump directly to Step 3 (answer)

"simpler" / "easier" / "더 쉽게"
  → Drop difficulty by one level (remove jargon, add analogy)

Two consecutive "I don't know" in a session
  → Skip Step 1 (question) going forward, go straight to explanation mode
```

**Never keep pinging the learner with questions. If they're stuck, answer immediately.**

---

## Review Quizzes

### Quiz Type Selection (mastery-based)

```
mastery < 0.3  → T/F (50%) + Multiple Choice (50%)
mastery 0.3~0.6 → MC (40%) + Fill-in (40%) + Short-answer (20%)
mastery > 0.6  → Fill-in (30%) + Short-answer (70%)
```

### Quiz Formats

**True/False:**
```
"A DB index is only stored in memory. True or False?"
→ False
```
- Keep T/F balanced (not always True)
- Verify exactly one core concept

**Multiple Choice:**
```
"The default data structure for an index is:
A) B-tree  B) Hash Table  C) Array  D) Stack"
→ A
```
- 4 options
- Plausible distractors (no "banana" nonsense answers)
- Randomize correct answer position (not always A)

**Fill-in-the-blank:**
```
"Without an index, a _____ Scan occurs."
→ Full Table
```
- One key term blanked
- Context must allow inference

**Short-answer:**
```
"What problem occurs without a DB index?"
```
- Prioritize weak_points from the card
- Claude judges the answer (correct / incorrect)

### Rating Mapping

```
T/F, MC, Fill-in:
  correct → "good"
  incorrect → "again"

Short-answer:
  covers key points → "good"
  misses core or wrong → "again"

"I don't know" → "again"
```

### After Grading

1. **Call FSRS:**
   ```bash
   bun run ./scripts/fsrs-calc.ts review '{"card":<current fsrs_card>,"rating":"good|again"}'
   ```
   → Update fsrs_card with returned card

2. **Update mastery:**
   - good: mastery += 0.1 (max 1.0)
   - again: mastery -= 0.05 (min 0.0)

3. **Append to review_log:**
   ```yaml
   - date: "2026-04-08T13:00:00+09:00"
     rating: good
     quiz_type: ox
     elapsed_days: 3
     scheduled_days: 7
   ```
   Keep last 20 entries. Drop oldest beyond that.

4. **Display result:**
   - Correct: "Correct! + one-line reinforcement + next review in N days"
   - Wrong: "Not quite. The answer is... + explanation + next review in N days"
   - "I don't know": reveal answer (count as wrong)

5. **If fsrs-calc fails:**
   - Print "FSRS calc failed. Defaulting to review in 1 day."
   - Set fsrs_card.due = tomorrow (fallback)
   - Report error to user

---

## YAML Schema v2

### concepts/{slug}.yaml

```yaml
schema_version: 2
topic_key: db-index
display_name: "DB Index"
aliases:
  - "Database Index"
  - "index"
category: db

fsrs_card:
  due: "2026-04-10T09:00:00+09:00"
  stability: 4.2
  difficulty: 5.7
  elapsed_days: 3
  scheduled_days: 7
  reps: 5
  lapses: 1
  state: 2
  last_review: "2026-04-07T09:00:00+09:00"

review_log:
  - date: "2026-04-07T09:00:00+09:00"
    rating: good
    quiz_type: ox
    elapsed_days: 3
    scheduled_days: 7

mastery: 0.3
review_count: 5
weak_points: []
last_studied: "2026-04-07"
```

### profile.yaml / profile.local.yaml

```yaml
level: beginner
interests:
  - agent-harness
session_length: 5min
total_sessions: 0
total_concepts_learned: 0
created: "2026-04-17"
```

Read order: `./profile.local.yaml` first (personal override), fall back to `./profile.yaml` (template default). Write changes to `./profile.local.yaml` only — never modify the tracked template.

### v1 → v2 migration (automatic)

v1 detection: missing `schema_version` field.

Steps:
```
1. Backup: cp {slug}.yaml {slug}.yaml.v1bak
2. bun run ./scripts/fsrs-calc.ts migrate '{"correct_streak":N,"next_review":"ISO"}'
   → generates fsrs_card
3. Add schema_version: 2
4. Initialize review_log: []
5. Remove correct_streak, next_review fields
6. Keep mastery, weak_points, review_count
```

---

## Session Flow

### Start
```
1. Read ./profile.local.yaml (fall back to ./profile.yaml; create ./profile.local.yaml if missing)
2. Create ./concepts/ if missing (mkdir -p)
3. Scan ./concepts/:
   - Files without schema_version → auto-migrate
   - YAML parse failure → exclude + report "file X corrupted"
   - fsrs_card.due in the past → add to review queue
4. Route input (per priority rules above)
```

### End
```
On learning completion:
"Today's concept: DB Index.
Next review: tomorrow. See you before you forget!"

Update ./profile.local.yaml:
  total_sessions += 1
  total_concepts_learned = count of files in ./concepts/
```

---

## Non-Developer Rules (CRITICAL)

1. **No coding tasks** — never say "write this code" or "try implementing..."
2. **Language matching** — respond in the learner's language. Korean: append English term in parens on first mention.
3. **Concise** — one concept = one screen max
4. **Real-world connection** — connect to familiar services/patterns when possible
5. **Numbered sections** — long explanations use I. II. III. structure
6. **Polite tone** — maintain politeness even in study mode
7. **Domain-agnostic** — tech, business, humanities — same method

---

## Error Handling

```
./concepts/ missing → mkdir -p automatically
./profile.local.yaml missing → create from ./profile.yaml defaults
./concepts/{slug}.yaml parse fail → exclude that file, report "file X corrupted"
./concepts/ empty → skip dashboard, ask "What would you like to study?"
./scripts/fsrs-calc.ts execution fail → fallback to "review in 1 day" + report error
bun not installed → "bun is required" message + continue study (scheduling uses fallback)
```
