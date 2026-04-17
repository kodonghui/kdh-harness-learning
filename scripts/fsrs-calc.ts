#!/usr/bin/env bun
/**
 * fsrs-calc.ts — FSRS v6 scheduler for /kdh-study
 *
 * Called by the /kdh-study skill to compute review intervals using the
 * Free Spaced Repetition Scheduler (FSRS) algorithm via `ts-fsrs`.
 *
 * Usage:
 *   bun run scripts/fsrs-calc.ts new
 *     → Returns a fresh fsrs_card (state: 0, due: now)
 *
 *   bun run scripts/fsrs-calc.ts review '{"card":<fsrs_card>,"rating":"good|again|hard|easy"}'
 *     → Returns the updated fsrs_card after applying the rating
 *
 *   bun run scripts/fsrs-calc.ts migrate '{"correct_streak":N,"next_review":"ISO"}'
 *     → Converts a v1 schema card (correct_streak + next_review) into a v2 fsrs_card
 *
 * Output: single JSON line on stdout. Errors go to stderr with exit code 1.
 */

import {
  createEmptyCard,
  fsrs,
  generatorParameters,
  Rating,
  State,
  type Card,
} from "ts-fsrs";

const f = fsrs(generatorParameters({ enable_fuzz: true, enable_short_term: true }));

type CardJSON = {
  due: string;
  stability: number;
  difficulty: number;
  elapsed_days: number;
  scheduled_days: number;
  reps: number;
  lapses: number;
  state: number;
  last_review?: string | null;
};

function toJSON(card: Card): CardJSON {
  return {
    due: card.due.toISOString(),
    stability: card.stability,
    difficulty: card.difficulty,
    elapsed_days: card.elapsed_days,
    scheduled_days: card.scheduled_days,
    reps: card.reps,
    lapses: card.lapses,
    state: card.state,
    last_review: card.last_review ? card.last_review.toISOString() : null,
  };
}

function fromJSON(json: CardJSON): Card {
  return {
    due: new Date(json.due),
    stability: json.stability,
    difficulty: json.difficulty,
    elapsed_days: json.elapsed_days,
    scheduled_days: json.scheduled_days,
    reps: json.reps,
    lapses: json.lapses,
    state: json.state as State,
    last_review: json.last_review ? new Date(json.last_review) : undefined,
    learning_steps: 0,
  };
}

function ratingFromString(s: string): Rating {
  switch (s.toLowerCase()) {
    case "again": return Rating.Again;
    case "hard":  return Rating.Hard;
    case "good":  return Rating.Good;
    case "easy":  return Rating.Easy;
    default:
      throw new Error(`Invalid rating: ${s}. Use one of: again | hard | good | easy`);
  }
}

function cmdNew(): CardJSON {
  return toJSON(createEmptyCard(new Date()));
}

function cmdReview(payload: string): CardJSON {
  const parsed = JSON.parse(payload) as { card: CardJSON; rating: string };
  if (!parsed.card || !parsed.rating) {
    throw new Error('review payload must be {"card": <fsrs_card>, "rating": "good|again|hard|easy"}');
  }
  const card = fromJSON(parsed.card);
  const rating = ratingFromString(parsed.rating);
  const now = new Date();
  const result = f.next(card, now, rating);
  return toJSON(result.card);
}

/**
 * Migrate v1 cards (correct_streak + next_review) → v2 fsrs_card.
 * Heuristic: each correct streak rep = one Good rating at the scheduled interval.
 */
function cmdMigrate(payload: string): CardJSON {
  const parsed = JSON.parse(payload) as { correct_streak?: number; next_review?: string };
  const streak = Math.max(0, Math.min(parsed.correct_streak ?? 0, 20));
  let card = createEmptyCard(new Date());
  let t = new Date();

  for (let i = 0; i < streak; i++) {
    const result = f.next(card, t, Rating.Good);
    card = result.card;
    t = card.due;
  }

  if (parsed.next_review) {
    card.due = new Date(parsed.next_review);
  }

  return toJSON(card);
}

function main() {
  const [cmd, payload] = process.argv.slice(2);
  if (!cmd) {
    console.error("Usage: fsrs-calc.ts <new | review <json> | migrate <json>>");
    process.exit(1);
  }

  try {
    let result: CardJSON;
    switch (cmd) {
      case "new":     result = cmdNew(); break;
      case "review":  result = cmdReview(payload ?? ""); break;
      case "migrate": result = cmdMigrate(payload ?? "{}"); break;
      default:
        throw new Error(`Unknown command: ${cmd}. Use: new | review | migrate`);
    }
    console.log(JSON.stringify(result));
  } catch (err) {
    const msg = err instanceof Error ? err.message : String(err);
    console.error(`fsrs-calc error: ${msg}`);
    process.exit(1);
  }
}

main();
