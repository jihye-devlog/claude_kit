# save-progress

현재 세션의 진행 상황을 정리하여 레포의 `.claude/memory/` 에 저장한다.
저장된 파일은 git으로 관리되므로 다른 PC에서 새 세션을 열어도 동일한 작업을 이어나갈 수 있다.

## 실행 절차

### 1단계: 현재 상태 파악

대화 히스토리와 프로젝트 파일을 바탕으로 다음을 파악한다.
- 완료된 작업 목록
- 현재 단계 (어디까지 왔는지)
- 다음에 해야 할 작업
- 미결 사항 (결정이 필요하거나 불확실한 항목)

### 2단계: .claude/memory/ 디렉토리 준비

프로젝트 루트의 `.claude/memory/` 디렉토리가 없으면 생성한다.

### 3단계: 메모리 파일 작성 및 업데이트

아래 파일들을 작성하거나 기존 내용을 최신 상태로 업데이트한다.
기존 파일이 있으면 덮어쓴다.

#### .claude/memory/project_progress.md

```
---
name: 진행 상태
description: 현재 진행 단계, 완료된 작업, 다음 할 일, 미결 사항
type: project
---

## 완료된 작업
(완료된 항목 목록)

## 현재 단계
(지금 어디에 있는지 한 줄 요약)

**Why:** (이 단계에 있는 이유)

## 다음 할 일
(번호 순서대로 실행 가능한 다음 작업 목록)

## 미결 사항
(표 형태로 정리: 번호, 항목, 기본값 또는 확인 필요 여부)

**How to apply:** (새 세션 시작 시 이 정보를 어떻게 활용할지)
```

#### .claude/memory/project_context.md

```
---
name: 프로젝트 컨텍스트
description: 프로젝트 개요, 확정된 기술 스택, 핵심 설계 결정사항
type: project
---

(프로젝트 개요, 확정된 기술 선택, 설계 결정사항, 모듈 구조 등 새 세션에서 배경으로 필요한 정보)
```

#### .claude/memory/feedback_workflow.md

이 파일은 최초 생성 시에만 작성한다. 이미 존재하면 건드리지 않는다.

```
---
name: 작업 방식 피드백
description: 이 프로젝트에서 사용자가 확인한 작업 방식 및 규칙
type: feedback
---

(대화 중 사용자가 확인하거나 수정한 작업 방식 규칙을 기록한다)
```

#### .claude/memory/MEMORY.md

```
# MEMORY INDEX

## 프로젝트 진행 상태
- [project_progress.md](project_progress.md) - (한 줄 설명)

## 프로젝트 컨텍스트
- [project_context.md](project_context.md) - (한 줄 설명)

## 작업 방식 피드백
- [feedback_workflow.md](feedback_workflow.md) - (한 줄 설명)
```

### 4단계: CLAUDE.md 세션 시작 규칙 확인

프로젝트 루트의 `CLAUDE.md` 에 아래 내용이 없으면 파일 맨 앞에 추가한다.
이미 있으면 추가하지 않는다.

```
## 세션 시작
새 세션이 시작되면 .claude/memory/MEMORY.md 를 읽고 링크된 메모리 파일을 모두 읽어 이전 진행 상황을 파악한다.
메모리를 업데이트할 때는 .claude/memory/ 디렉토리의 파일을 수정한다.
```

### 5단계: 완료 보고

저장이 완료되면 다음을 사용자에게 출력한다.
- 저장된 파일 목록
- 현재 단계 한 줄 요약
- 다음에 할 작업 요약
- 미결 사항이 있으면 목록 출력
