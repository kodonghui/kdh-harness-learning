# kdh-harness-study

> **A non-developer-friendly curriculum for learning Agent Harnesses, powered by spaced repetition (FSRS).**
> **비개발자를 위한 에이전트 하네스 학습 커리큘럼 — 간격 반복(FSRS) 기반.**

---

## 🇬🇧 English

### What is this?

A self-study curriculum for understanding **Agent Harnesses** (the scaffolding around LLMs that turns a chatbot into a usable agent — tools, context, memory, safety, observability). Designed for **non-developers** who use Claude Code but don't write code themselves.

- **30 modules** across 6 Phases + Advanced + Practical tracks
- **Diagrams & analogies** instead of code
- **Spaced repetition (FSRS v6)** keeps concepts in long-term memory
- **4 quiz types** — True/False, Multiple Choice, Fill-in-the-blank, Short-answer
- **Runs inside Claude Code** via the `/kdh-study` slash command

### Who is this for?

- Managers, PMs, founders, CEOs who work with AI agents but don't code
- Anyone who wants to understand *how* Claude Code / Cursor / Codex work underneath
- Self-learners who need structure, not a firehose of blog posts

**Not for:** People looking for code-heavy tutorials or framework deep-dives.

### Requirements

- [Claude Code](https://claude.com/claude-code) — the CLI/desktop agent
- [Bun](https://bun.sh) — JavaScript runtime (for FSRS scheduling)

### Install

```bash
git clone https://github.com/kodonghui/kdh-harness-learning.git
cd kdh-harness-learning
bun install
```

That's it. Claude Code auto-detects `.claude/skills/kdh-study/` and registers the `/kdh-study` command.

### Usage

Open Claude Code inside this folder, then:

```
/kdh-study                   → Dashboard + today's reviews
/kdh-study [topic]           → Learn a new topic or review it
/kdh-study 이거뭐야 [term]    → 30-second instant explanation
```

Examples:
- `/kdh-study agent loop` — learn the agent loop concept
- `/kdh-study` — see what's due today, get recommendations
- `/kdh-study 이거뭐야 MCP` — quick "what is MCP?" answer

### Folder Structure

```
kdh-harness-study/
├── .claude/skills/kdh-study/SKILL.md   # The /kdh-study command definition
├── curriculum/                          # 21-module curriculum (read-only content)
│   ├── harness-curriculum.md            #   Master overview
│   └── modules/*.yaml                   #   Per-module specs
├── scripts/fsrs-calc.ts                 # FSRS scheduler (called by /kdh-study)
├── concepts/_template.yaml              # Template for new concept cards
├── schema.md                            # Data schema contract
├── profile.yaml                         # Default learner profile (template)
├── package.json                         # Bun dependencies
├── LICENSE                              # MIT
└── README.md                            # This file

# Created at runtime (gitignored — your personal data stays local):
# ├── concepts/*.yaml                    # Your FSRS cards
# ├── plans/                             # Your notes
# ├── notes/                             # Your study notes
# ├── sessions/                          # Session logs
# └── exports/                           # Generated study guides
```

### How FSRS works (30-second version)

FSRS decides **when to review each concept** based on how well you remembered it last time:

- Got it right easily? → Next review in a week
- Got it right with effort? → Next review in 3 days
- Got it wrong? → Review tomorrow

Over time, intervals grow (1d → 3d → 7d → 2w → 1mo → ...) until concepts stick permanently. This is the same algorithm behind [Anki](https://apps.ankiweb.net/) and modern spaced-repetition apps.

### Curriculum Overview

| Phase | Focus | Modules |
|-------|-------|---------|
| Phase 0 | Foundations — agent, harness, agent loop | 3 |
| Phase 1 | Tools & Connectivity — tool layer, protocols, auth | 3 |
| Phase 2 | Context & Memory — context, memory, prompts, RAG, determinism | 5 |
| Phase 3 | Execution — patterns, multi-agent, hooks, reasoning models, worktrees, streaming | 6 |
| Phase 4 | Safety — state, failure/recovery, security | 3 |
| Phase 5 | Ops — observability, cost/perf, evaluation, prompt caching, model selection | 5 |
| Advanced | Compare real harnesses (ECC, Superpowers, etc.) | 2 |
| Practical | Build your own pipeline | 3 |

### License

MIT — see [LICENSE](LICENSE). You can fork, modify, and redistribute freely.

### Contributing

Issues and PRs welcome — especially for curriculum corrections and translation improvements.

---

## 🇰🇷 한국어

### 이게 뭔가요?

**에이전트 하네스(Agent Harness)** — LLM을 둘러싸고 있는 틀(도구, 컨텍스트, 메모리, 안전장치, 관측) — 을 이해하기 위한 **비개발자용 자습 커리큘럼**입니다. Claude Code를 쓰지만 직접 코드는 안 짜는 분들을 위해 만들었습니다.

- **30개 모듈** — Phase 0~5 + 심화 + 실전
- **코드 대신 다이어그램과 비유** 중심
- **FSRS v6 간격 반복**으로 장기 기억 형성
- **4종 퀴즈** — OX / 선택형 / 빈칸 / 서술형
- Claude Code 안에서 **`/kdh-study` 명령어**로 바로 실행

### 누구를 위한 건가요?

- AI 에이전트를 업무에 쓰는데 코드는 안 짜는 매니저/PM/대표
- Claude Code / Cursor / Codex 같은 도구가 **내부에서 어떻게 돌아가는지** 이해하고 싶은 분
- 블로그 글 조각들 대신 **체계적 학습**이 필요한 분

**대상 아님:** 코드 중심 튜토리얼이나 프레임워크 심화 자료를 찾는 분.

### 요구사항

- [Claude Code](https://claude.com/claude-code) — CLI/데스크탑 에이전트
- [Bun](https://bun.sh) — JavaScript 런타임 (FSRS 스케줄 계산용)

### 설치

```bash
git clone https://github.com/kodonghui/kdh-harness-learning.git
cd kdh-harness-learning
bun install
```

끝. Claude Code가 `.claude/skills/kdh-study/`를 자동 인식해서 `/kdh-study` 명령어가 바로 등록됩니다.

### 사용법

이 폴더에서 Claude Code 열고:

```
/kdh-study                    → 대시보드 + 오늘 복습할 것
/kdh-study [주제]              → 새 개념 학습 또는 복습
/kdh-study 이거뭐야 [용어]     → 30초 즉석 설명
```

예시:
- `/kdh-study 에이전트 루프` — "에이전트 루프" 개념 학습
- `/kdh-study` — 오늘 뭐 복습할지 추천받기
- `/kdh-study 이거뭐야 MCP` — MCP가 뭔지 짧게 설명

### 폴더 구조

```
kdh-harness-study/
├── .claude/skills/kdh-study/SKILL.md   # /kdh-study 명령어 정의
├── curriculum/                          # 21모듈 커리큘럼 (본문, 수정X)
│   ├── harness-curriculum.md            #   전체 개요
│   └── modules/*.yaml                   #   모듈별 스펙
├── scripts/fsrs-calc.ts                 # FSRS 스케줄러 (/kdh-study가 호출)
├── concepts/_template.yaml              # 개념 카드 템플릿
├── schema.md                            # 데이터 스키마 계약
├── profile.yaml                         # 기본 학습 프로필 (템플릿)
├── package.json                         # Bun 의존성
├── LICENSE                              # MIT
└── README.md                            # 이 파일

# 실행 중 생성 (.gitignore에 포함 — 개인 데이터는 로컬에만):
# ├── concepts/*.yaml                    # 내 FSRS 카드
# ├── plans/                             # 내 플랜
# ├── notes/                             # 내 학습 노트
# ├── sessions/                          # 세션 로그
# └── exports/                           # 생성된 스터디 가이드
```

### FSRS가 뭔가요 (30초 요약)

FSRS는 **"언제 복습할지"** 자동으로 정해주는 알고리즘입니다:

- 쉽게 맞췄음 → 일주일 뒤에 다시 물어봄
- 겨우 맞췄음 → 3일 뒤에 다시
- 틀렸음 → 내일 다시

시간이 지나면서 복습 간격이 늘어나고(1일 → 3일 → 7일 → 2주 → 1달 → ...), 결국 기억에 영구 정착됩니다. [Anki](https://apps.ankiweb.net/)나 현대적인 간격 반복 앱의 핵심 알고리즘입니다.

### 커리큘럼 개요

| Phase | 주제 | 모듈 수 |
|-------|-----|--------|
| Phase 0 | 기초 — 에이전트, 하네스, 에이전트 루프 | 3 |
| Phase 1 | 도구와 연결 — 도구 계층, 프로토콜, 인증 | 3 |
| Phase 2 | 컨텍스트와 메모리 — 컨텍스트, 메모리, 프롬프트, RAG, 결정론 | 5 |
| Phase 3 | 실행 — 패턴, 멀티에이전트, 훅, 추론 모델, worktree, 스트리밍 | 6 |
| Phase 4 | 안전 — 상태, 실패/복구, 보안 | 3 |
| Phase 5 | 운영 — 관측성, 비용/성능, 평가, 프롬프트 캐싱, 모델 선택 | 5 |
| 심화 | 실제 하네스 비교 (ECC, Superpowers 등) | 2 |
| 실전 | 내 파이프라인 만들기 | 3 |

### 라이선스

MIT — [LICENSE](LICENSE) 참조. 자유롭게 fork, 수정, 재배포 가능합니다.

### 기여

이슈와 PR 환영 — 커리큘럼 정정, 번역 개선 등.
