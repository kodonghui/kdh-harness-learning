# Agent Harness Curriculum (Non-Developer Edition)

> **Audience:** Non-developers who use AI agents but don't write code.
> **Method:** Diagrams, analogies, comparisons, concrete scenarios — no code required.
> **Goal:** Understand, judge, and diagnose agent harnesses.
>
> **대상:** AI 에이전트를 쓰지만 직접 코드는 안 짜는 비개발자.
> **방식:** 다이어그램, 비유, 비교, 구체적 시나리오 — 코드 불필요.
> **목표:** 하네스를 이해하고, 판단하고, 진단할 수 있게.

---

## Overview / 개요

```
Core (6 Phases, 25 modules)       ── "Understand + judge + diagnose"
  ├── Phase 0: Foundations              (agent, harness, agent loop)                     [3]
  ├── Phase 1: Tools & Connectivity     (tool layer, protocols, auth)                    [3]
  ├── Phase 2: Context & Memory         (context, memory, prompts, RAG, determinism)     [5]
  ├── Phase 3: Execution & Workflow     (patterns, multi-agent, hooks,                   [6]
  │                                      reasoning models, worktrees, streaming)
  ├── Phase 4: Safety & Verification    (state/safety, failure, security)                [3]
  └── Phase 5: Observation & Ops        (observability, cost/perf, evaluation,           [5]
                                         prompt caching, model selection)

Advanced (2 modules, optional)    ── "Compare + design"
Practical (3 modules)             ── "Build your own pipeline"

Total: 30 modules
```

## Learning Principles / 학습 원칙

1. **Harness knowledge is central** — not about operations or management skills.
   하네스 지식이 중심 — 운영 스킬/매니지먼트 교육 아님.
2. **No code reading** — config files, logs, pseudocode are OK; actual code is not required.
   코드 읽기 불필요 — 설정 파일, 로그, 의사코드는 OK.
3. **Diagram required** — every module has at least one Mermaid or ASCII diagram.
   모든 모듈에 다이어그램 하나 이상.
4. **"6 layers" as a working lens** — a tool for viewing harnesses, not the only correct view.
   "6계층"은 정답이 아니라 하네스를 바라보는 작업용 렌즈.
5. **Verdict sentence per module** — "After this module you can explain/distinguish ___."
   모듈마다 판정 문장 — "이 모듈 후 ~를 설명/판별 가능".
6. **Concrete, not over-analogized** — analogies help, but don't bury the real concept.
   구체적이고 자세하게, 과한 비유 지양.
7. **Real-world connection when natural** — no forced mapping to a specific product.
   실무 연결은 자연스러운 곳에만 — 억지 매핑 금지.

## Verdict Rules / 판정 규칙

- **Format** — "Can explain ___" / "Can distinguish ___" / "Can illustrate ___ with an example"
  형식 — "~를 설명 가능" / "~를 판별 가능" / "~를 사례로 설명 가능"
- **Verification** — Learner can state it in their own language without AI assistance.
  검증 — 학습자가 AI 없이 자기 언어로 말할 수 있으면 통과.
- **On failure** — Re-review the module and retry.
  실패 시 — 해당 모듈 복습 후 재시도.

---

## Module Index / 모듈 인덱스

### Phase 0 — Foundations / 기초 (3 modules)

| # | Module | Title | Duration |
|---|--------|-------|---------|
| 0 | `p0-m0-agent` | 에이전트란 뭔가 / What is an agent | 20 min |
| 1 | `p0-harness-overview` | 하네스 전체 그림 / Harness overview | 30 min |
| 2 | `p0-m2-agent-loop` | 에이전트 루프 / Agent loop | 20 min |

### Phase 1 — Tools & Connectivity / 도구와 연결 (3 modules)

| # | Module | Title | Duration |
|---|--------|-------|---------|
| 3 | `p1-m1-tools` | 도구 계층 / Tool layer | 30 min |
| 4 | `p1-m2-protocols` | 프로토콜 / Protocols (API, MCP, A2A) | 25 min |
| 5 | `p1-m3-auth-connect` | 인증과 연결 / Auth & connectivity | 25 min |

### Phase 2 — Context & Memory / 컨텍스트와 메모리 (5 modules)

| # | Module | Title | Duration |
|---|--------|-------|---------|
| 6  | `p2-m1-context` | 컨텍스트 윈도우 심화 / Context window deep-dive | 25 min |
| 7  | `p2-m2-memory` | 메모리 시스템 / Memory systems | 25 min |
| 8  | `p2-m3-prompt` | 프롬프트와 지시 / Prompts & instructions | 25 min |
| 9  | `p2-m4-rag` | RAG 심화 / RAG deep dive | 30 min |
| 10 | `p2-m5-determinism` | 결정론 vs 창의성 / Determinism vs creativity | 25 min |

### Phase 3 — Execution & Workflow / 실행과 워크플로우 (6 modules)

| # | Module | Title | Duration |
|---|--------|-------|---------|
| 11 | `p3-m1-patterns` | 실행 패턴 / Execution patterns (ReAct, Plan-and-Execute) | 25 min |
| 12 | `p3-m2-multi-agent` | 서브에이전트와 멀티에이전트 / Sub-agents & multi-agent | 25 min |
| 13 | `p3-m3-hooks` | 훅과 자동화 / Hooks & automation | 25 min |
| 14 | `p3-m4-reasoning` | 추론 모델 / Reasoning models (o1, Extended Thinking) | 30 min |
| 15 | `p3-m5-worktree` | Worktree 격리 / Worktree isolation for parallel agents | 30 min |
| 16 | `p3-m6-streaming` | 스트리밍 vs 배치 / Streaming vs batch responses | 20 min |

### Phase 4 — Safety & Verification / 안전과 검증 (3 modules)

| # | Module | Title | Duration |
|---|--------|-------|---------|
| 17 | `p4-m1-state-safety` | 상태 관리와 안전장치 / State management & safety | 30 min |
| 18 | `p4-m2-failure` | 실패감지와 복구 / Failure detection & recovery | 25 min |
| 19 | `p4-m3-security` | 보안 / Security (prompt injection, sandbox, secrets) | 25 min |

### Phase 5 — Observation & Ops / 관측과 운영 (5 modules)

| # | Module | Title | Duration |
|---|--------|-------|---------|
| 20 | `p5-m1-observability` | 관측성 / Observability (logs, tracing, monitoring) | 25 min |
| 21 | `p5-m2-cost-perf` | 비용과 성능 / Cost & performance | 25 min |
| 22 | `p5-m3-evaluation` | 평가와 벤치마크 / Evaluation & benchmarks | 20 min |
| 23 | `p5-m4-caching` | 프롬프트 캐싱 / Prompt caching (90% cost savings) | 25 min |
| 24 | `p5-m5-model-selection` | 모델 선택 전략 / Model tier selection (Haiku/Sonnet/Opus) | 25 min |

### Advanced / 심화 (2 modules, optional)

| # | Module | Title | Duration |
|---|--------|-------|---------|
| 25 | `adv-m1-comparison` | 하네스 공통 패턴 비교 / Compare real harnesses | 30 min |
| 26 | `adv-m2-design` | 하네스 설계 실습 / Design your own harness | 30 min |

### Practical / 실전 (3 modules)

| # | Module | Title | Duration |
|---|--------|-------|---------|
| 27 | `prac-m1-design` | 파이프라인 설계 / Pipeline design | 45 min |
| 28 | `prac-m2-build` | 파이프라인 구현 / Pipeline build | 60+ min |
| 29 | `prac-m3-operate` | 파이프라인 운영 / Pipeline operate & compare | 45 min |

---

## How to Use / 사용법

1. Open Claude Code in this repo.
2. Run `/kdh-study [topic]` to start any module.
3. Each module YAML under `curriculum/modules/` is the canonical spec.
4. Your personal progress, FSRS cards, and notes stay local (gitignored).

1. 이 레포에서 Claude Code를 엽니다.
2. `/kdh-study [주제]`로 모듈 시작.
3. `curriculum/modules/` 아래 각 YAML이 정전(canonical) 스펙.
4. 개인 진도, FSRS 카드, 노트는 전부 로컬 전용(gitignore).

## Module YAML Schema

```yaml
title: "Module title"
phase: 0-5 | advanced | practical
module: 0-3
track: basic | advanced | practical
duration: "30min"
objective: "One-sentence learning goal"

key_concepts: [...]
concept_pairs: [["A", "B"], ...]

diagram_type: flowchart | sequence | structure | state | comparison | none
diagram_title: "..."
diagram_description: |
  (Mermaid or ASCII diagram description)

exercise:
  type: 구분 | 설명 | 진단 | 설계
  description: "..."

concepts:                  # slugs of related concept cards
  - agent
  - agent-loop

verdict: "After this module, the learner can ___"
```

See `../schema.md` for the full contract, including concept card and profile schemas.
