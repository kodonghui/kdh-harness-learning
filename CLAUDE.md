# kdh-harness-study

## 사용자
- 이름: 고동희
- 한국어로 대화

## 프로젝트 개요
- 에이전트 하네스(Agent Harness) 개념 학습
- FSRS 기반 간격 반복 학습 시스템 사용
- 커리큘럼: Phase 0(개요) → Phase 1(도구/컨텍스트/상태) → Phase 2(실패/복구/관측) → Advanced → Practical

## 학습 현황
- Phase 0 진행 중 (mastery 0.1~0.2)
- 학습 개념 5개: agent-harness, tool, context-window, failure-detection, agent-vs-harness-responsibility
- 다음 단계: Phase 0 판정 → Phase 1 M1 진입

## 폴더 구조

```
kdh-harness-study/
├── CLAUDE.md / INDEX.md
├── profile.yaml          ← 학습 프로필 (레벨, 세션 수, 개념 수)
├── schema.md             ← YAML 스키마 정의
├── concepts/             ← FSRS 개념 카드 (YAML)
├── curriculum/           ← 커리큘럼 개요 + 모듈 12개
│   └── modules/
├── plans/                ← 학습 계획/리서치/분석
├── exports/              ← 내보내기 자료
└── notes/                ← 학습 노트
```

## 규칙
- 파일명: MMDD prefix + kebab-case
- 개념 카드: `concepts/` 폴더에 YAML 형식
- 학습 계획: `plans/` 폴더에 md 형식
