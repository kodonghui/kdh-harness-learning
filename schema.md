# Study-Log Schema Contract v1
> Created: 2026-04-10

## 디렉토리 구조

```
~/.claude/study-log/
├── schema.md                          ← 이 파일 (계약)
├── profile.yaml                       ← 학습자 프로필
├── concepts/{slug}.yaml               ← FSRS 카드 (기존, 변경 없음)
├── notes/{slug}.md                    ← 학습 노트 (신규)
├── curriculum/
│   ├── harness-curriculum.md          ← 마스터 교육과정
│   └── modules/{track}-{phase}-{id}.yaml  ← Module 스펙
└── exports/
    └── MMDD-{topic}-study-guide.md    ← export 산출물
```

## Slug 규칙

- kebab-case, 소문자
- 한글은 영문 변환: "에이전트 하네스" → agent-harness
- concepts/ slug와 notes/ slug는 동일해야 함 (1:1 매핑)
- notes/에는 날짜 prefix 없음 (slug 기반)
- exports/에는 MMDD prefix 필수 (CLAUDE.md 규칙 준수)

## notes/{slug}.md Frontmatter

```yaml
---
title: "에이전트 하네스"
track: basic | advanced | practice | benchmark | general
phase: 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | null
module: "phase0-prep" | null
created: "2026-04-10"
updated: "2026-04-10"
---
```

## notes/{slug}.md Body 섹션

```markdown
## 한줄 정의
## 상세 설명
## 다이어그램
## 예시
## 실무 연결
## 복습 기록
| 날짜 | 퀴즈 유형 | 결과 | 메모 |
|------|----------|------|------|
```

## Module YAML 필수 필드

```yaml
id: "basic-phase1-flow"
title: "요청 1개의 전체 여정"
track: basic | advanced | practice | benchmark
phase: 0-7
objective: "학습 후 달성 목표 (1문장)"
diagram_type: flowchart | sequence | class | state | none
diagram: |
  (mermaid 코드 또는 null)
exercise: "실습 과제 설명"
verification: "이 Module을 이해했다는 검증 방법"
duration_min: 30
prerequisites: []
concepts: ["agent-harness", "context-window"]  # 연결된 study concepts
```

## Export 규칙

- 입력: notes/*.md (read-only, 원본 수정 금지)
- 출력: exports/MMDD-{topic}-study-guide.md
- 정렬: track 순서(basic→advanced→practice→benchmark) > created 날짜순
- 목차: 자동 생성
- 기존 export 파일이 있으면: 새 파일 생성 (덮어쓰기 아님)

## Idempotency 규칙

- notes/{slug}.md가 이미 존재하면: 복습 기록 테이블에만 append
- 기존 내용(한줄 정의, 상세 설명 등)은 수정하지 않음
- 사용자가 수동 편집한 내용 보존
