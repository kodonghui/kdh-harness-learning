# kdh-harness-study — Project Rules for Claude Code

> This file tells Claude Code how to behave inside this repository.
> 이 파일은 Claude Code가 이 레포 안에서 어떻게 행동할지 정의합니다.

## Project Overview / 프로젝트 개요

- **Purpose** — A non-developer-friendly curriculum for learning Agent Harnesses, with FSRS spaced repetition.
- **목적** — 비개발자를 위한 에이전트 하네스 학습 커리큘럼 (FSRS 간격 반복).
- **Primary command** — `/kdh-study` (defined in `.claude/skills/kdh-study/SKILL.md`).
- **주 명령어** — `/kdh-study` (`.claude/skills/kdh-study/SKILL.md`에 정의).

## Audience / 학습 대상

**Non-developers.** 비개발자 대상.

- ❌ **Do NOT** show code, ask the learner to write code, or use code-heavy explanations.
- ❌ **코드 금지** — 코드를 보여주거나, 학습자에게 코드를 짜라고 하거나, 코드 중심 설명 금지.
- ✅ **Do** use diagrams, analogies, flowcharts, comparison tables, and concrete examples.
- ✅ **권장** — 다이어그램, 비유, 흐름도, 비교표, 구체적 예시.
- ✅ Pseudocode and config snippets (YAML, JSON) are OK when necessary.
- ✅ 필요할 때 의사코드와 설정 스니펫(YAML, JSON)은 허용.

## Language / 언어

- Curriculum, skill definitions, and READMEs support both English and Korean.
- 커리큘럼, 스킬 정의, README는 영한 병기.
- When interacting with the learner: **match the language they use**. Default to Korean if unclear.
- 학습자와 대화할 때는 **학습자가 쓴 언어에 맞춤**. 애매하면 한국어 기본.
- Technical terms: write in the learner's language, append English in parens on first mention.
- 전문 용어: 학습자 언어로 쓰되 첫 언급 시 영어 병기 (예: "인덱스(Index)").

## Folder Structure / 폴더 구조

```
kdh-harness-study/
├── .claude/skills/kdh-study/SKILL.md   # /kdh-study command (canonical behavior)
├── curriculum/                          # Read-only curriculum content
│   ├── harness-curriculum.md            #   Master overview
│   └── modules/*.yaml                   #   21 modules (Phase 0-5 + Adv + Prac)
├── scripts/fsrs-calc.ts                 # FSRS scheduler
├── concepts/_template.yaml              # Concept card template
├── concepts/*.yaml                      # Personal FSRS cards (gitignored)
├── plans/*.md                           # Personal planning docs (gitignored)
├── notes/*.md                           # Personal study notes (gitignored)
├── sessions/                            # Personal session logs (gitignored)
├── exports/                             # Generated study guides (gitignored)
├── profile.yaml                         # Default profile template (tracked)
├── profile.local.yaml                   # Personal profile override (gitignored)
├── schema.md                            # Data schema contract
└── README.md
```

## Rules / 규칙

### File naming / 파일명
- Date-prefixed files: `MMDD-kebab-case.md` (e.g., `0410-research-agent-harness.md`)
- 날짜 접두 파일명: `MMDD-kebab-case.md`
- Concept cards: `concepts/{slug}.yaml` where slug is kebab-case English
- 개념 카드: `concepts/{slug}.yaml` (slug는 kebab-case 영문)

### Privacy / 프라이버시
- **Never commit personal learning data** (concepts, plans, notes, sessions, profile).
- **개인 학습 데이터 커밋 금지** — concepts, plans, notes, sessions, profile 모두 로컬 전용.
- `.gitignore` already blocks these paths. Do not bypass it.
- `.gitignore`가 이미 막아놓음. 우회 금지.

### Schema / 스키마
- Follow `schema.md` for concept card and module YAML formats.
- 개념 카드와 모듈 YAML 형식은 `schema.md` 준수.

### Curriculum modifications / 커리큘럼 수정
- `curriculum/` is the canonical content — changes should be deliberate and versioned.
- `curriculum/`은 정전(canonical) 콘텐츠 — 변경은 신중하게, 버전 관리.

## First-Time Greeting / 첫 진입 인사 (IMPORTANT)

When Claude Code is launched in this repo and the user's **first message** is:
- Empty, silent, or just a greeting (`안녕`, `hi`, `hello`, `hey`, `반가워`, etc.)
- A generic question like "뭐 할 수 있어?", "여기서 뭐 해?", "how do I use this?", "what is this?"
- Any signal they're a first-time user unsure how to start

→ **Always respond with this onboarding message** (match the user's language):

**English version:**
```
Welcome to the Agent Harness study curriculum. This is a non-developer-friendly,
FSRS-based spaced repetition system for learning how AI agent harnesses work.

Get started with one of these:
  /kdh-study                  — Dashboard + today's reviews
  /kdh-study [topic]          — Learn or review a topic (e.g., /kdh-study agent loop)
  /kdh-study 이거뭐야 [term]  — 30-second instant explanation

The full 23-module curriculum lives in `curriculum/`.
Your personal progress stays local (gitignored) — safe to experiment.

What would you like to learn?
```

**한국어 버전:**
```
에이전트 하네스 학습 커리큘럼에 오신 걸 환영합니다.
FSRS 기반 간격 반복으로 에이전트 하네스가 어떻게 작동하는지 배우는
비개발자용 커리큘럼입니다.

시작하는 방법:
  /kdh-study                    — 대시보드 + 오늘 복습할 것
  /kdh-study [주제]             — 특정 주제 학습/복습 (예: /kdh-study 에이전트 루프)
  /kdh-study 이거뭐야 [용어]    — 30초 즉석 설명

23개 모듈 전체 커리큘럼은 `curriculum/` 폴더에 있습니다.
개인 진도는 로컬에만 저장됩니다(gitignored) — 자유롭게 실험해도 안전.

뭘 공부하고 싶으세요?
```

Do NOT repeat this greeting if the user already got it earlier in the same session.

## When Invoked Inside This Repo / 이 레포에서 호출되었을 때

1. If the user says anything learning-related → suggest or invoke `/kdh-study`.
2. If the user asks for code → remind them this is a non-developer curriculum and offer a diagram/analogy instead.
3. If creating/modifying concept cards, always use `schema_version: 2` and follow `concepts/_template.yaml`.
4. Before any `git add` / commit, verify `.gitignore` compliance — personal files must never be staged.
