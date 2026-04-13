# kdh-harness-study

## 사용자
- 이름: 고동희
- 한국어로 대화

## 프로젝트 개요
- 에이전트 하네스(Agent Harness) 개념 학습
- FSRS 기반 간격 반복 학습 시스템 사용
- 커리큘럼 v2 (6 Phase + Advanced + Practical = 21 모듈):
  - Phase 0: 기초 (에이전트, 하네스 전체 그림, 에이전트 루프)
  - Phase 1: 도구와 연결 (도구 계층, 프로토콜, 인증)
  - Phase 2: 컨텍스트와 메모리 (토큰/압축, 메모리 시스템, 프롬프트)
  - Phase 3: 실행과 워크플로우 (실행 패턴, 멀티에이전트, 훅)
  - Phase 4: 안전과 검증 (상태/안전, 실패/복구, 보안)
  - Phase 5: 관측과 운영 (관측성, 비용/성능, 평가)
  - Advanced: 비교 + 설계 실습
  - Practical: 미니 하네스 설계 → 구현 → 운영

## 학습 현황
- Phase 0 판정 통과 (2026-04-13)
- 학습 개념 5개: agent-harness(0.3), tool(0.2), context-window(0.2), failure-detection(0.05), agent-vs-harness-responsibility(0.2)
- 다음 단계: Phase 1 M1 진입

## 폴더 구조

```
kdh-harness-study/
├── CLAUDE.md / INDEX.md
├── profile.yaml          ← 학습 프로필 (레벨, 세션 수, 개념 수)
├── schema.md             ← YAML 스키마 정의
├── concepts/             ← FSRS 개념 카드 (YAML)
├── curriculum/           ← 커리큘럼 v2 (21 모듈)
│   └── modules/
├── plans/                ← 학습 계획/리서치/분석
├── exports/              ← 내보내기 자료
└── notes/                ← 학습 노트
```

## 규칙
- 파일명: MMDD prefix + kebab-case
- 개념 카드: `concepts/` 폴더에 YAML 형식
- 학습 계획: `plans/` 폴더에 md 형식
