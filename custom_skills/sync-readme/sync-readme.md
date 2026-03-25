---
name: sync-readme
description: Automatically keeps README.md files up to date when the codebase changes. ALWAYS invoke this skill — without being asked — when any of the following occur: (1) a feature or code implementation is completed, (2) files or directories are added or deleted, (3) functionality or behavior is changed, (4) installation or setup steps change, (5) agents, skills, or tools are added or modified. Also invoke when the user explicitly asks to update documentation or README. This skill analyzes the repo type first, then determines the exact scope and style of updates needed.
---

## 개요

이 스킬은 아래 순서로 README 파일을 정확하게 최신 상태로 유지한다.

1. 레포를 분석해 유형과 문서화 패턴 파악
2. 기존 README 를 읽어 현재 스타일과 구조 추출
3. 변경된 내용 감지 및 영향받는 README 특정
4. 나머지는 그대로 두고 필요한 섹션만 수정

---

## 1단계: 레포 분석

파일을 수정하기 전에 먼저 레포를 이해한다.

**레포 유형 판별** - 아래 파일/디렉토리 존재 여부 확인:
- `package.json` / `pyproject.toml` / `Cargo.toml` / `go.mod` → 라이브러리 또는 앱
- `.claude/agents/`, 스킬/커맨드 디렉토리, 스크립트 모음 → 도구·스킬 모음
- `src/`, `lib/`, `app/` 등 구현 코드 → 앱·서비스
- 각각 패키지 파일을 가진 `packages/`, `apps/` → 모노레포

**기존 README 읽기** - 아래 항목 파악:
- 현재 섹션 구성과 순서
- 작성 스타일과 톤 (격식체/비격식체, 언어)
- 프로젝트와 구성 요소를 설명하는 방식
- 표 형식, 헤더 레벨, 코드 블록 사용 방식

**변경 사항 파악** - 대화 맥락에서 방금 구현·추가·삭제된 것을 확인한다. 불명확하면 `git status` 또는 `git diff --name-only HEAD` 로 최근 변경 파일을 확인한다.

---

## 2단계: 업데이트 범위 결정

레포 유형과 변경 사항을 기준으로 어떤 README 의 어떤 섹션을 수정할지 결정한다.

### 도구·스킬 모음

| 변경 사항 | 업데이트 대상 | 수정할 섹션 |
|-----------|--------------|-------------|
| 도구·스크립트·스킬 추가 또는 삭제 | 루트 README + 해당 도구 README | 디렉토리 트리, 도구 목록 |
| 도구 동작 또는 사용법 변경 | 해당 도구 README | 사용 방법, 동작 방식, 옵션 |
| 에이전트·스킬 추가 또는 수정 | 루트 README | 도구 목록 테이블 |
| 설치 방법 변경 | 해당 도구 README | 설치 방법 섹션 |

### 앱·서비스

| 변경 사항 | 업데이트 대상 | 수정할 섹션 |
|-----------|--------------|-------------|
| 기능 구현 완료 | 루트 README + 기능 README | 기능 목록, 사용 방법 |
| API 또는 인터페이스 변경 | 관련 README | API 레퍼런스, 사용 예시 |
| 설정·환경 변수 변경 | 루트 README | 설정, 환경 설정 |
| 새 의존성 추가 | 루트 README | 설치 방법, 요구 사항 |

### 라이브러리·패키지

| 변경 사항 | 업데이트 대상 | 수정할 섹션 |
|-----------|--------------|-------------|
| 새 함수·클래스 추가 | 루트 README | API 레퍼런스, 예시 |
| 브레이킹 체인지 | 루트 README | 마이그레이션 안내, 변경 이력 |
| 새 설치 옵션 추가 | 루트 README | 설치 방법 섹션 |

### 모노레포

각 서브 패키지에 위의 규칙을 적용한 뒤, 패키지 간 변경 사항이 있으면 루트 README 도 업데이트한다.

---

## 3단계: README 업데이트

업데이트할 README 각각에 대해:

1. **수정 전 전체 README 를 읽는다** - 구조와 스타일을 파악하기 위해
2. **변경이 필요한 섹션만 특정한다** - 최소한의 정확한 수정이 목표
3. **기존 스타일을 그대로 따른다** - 톤, 언어, 표 형식, 헤더 스타일, 섹션 순서
4. **파일이 변경됐으면 디렉토리 트리를 재생성한다** - 트리는 항상 실제 구조와 일치해야 함
5. **새 섹션을 추가하지 않는다** - 명백히 누락되어 필요한 경우에만 예외

### 스타일 보존 규칙

일관성 없는 README 는 문서에 대한 신뢰를 낮춘다. 확신이 없을 때는 주변 스타일을 따른다.

- 기존 README 의 언어를 유지한다 (한국어면 한국어, 영어면 영어)
- 표의 컬럼명과 순서를 그대로 유지한다
- 헤더와 목록의 이모지 사용 여부를 그대로 따른다
- 섹션 순서를 바꾸지 않는다
- 상세함의 수준을 맞춘다 - 간결한 문서를 장문으로 늘리거나, 상세한 문서를 압축하지 않는다
- 디렉토리 트리가 있으면 직접 편집하지 않고 실제 파일 구조를 스캔해서 재생성한다

---

## 트리거 대상 상황

아래 상황이 발생했을 때 이 스킬을 실행한다.

- 코드 또는 기능 구현 완료
- 파일 또는 디렉토리 추가·삭제
- 기능 동작 변경
- 에이전트·스킬·도구 추가 또는 수정
- 설치·설정 방법 변경

README 자체만 수정된 경우나, 주석·포매팅만 변경된 경우에는 실행하지 않는다.

---

## 완료 보고

업데이트 후 아래 내용을 간략히 보고한다.

- 수정된 README 파일 목록
- 수정된 섹션과 수정 이유
- 오래된 것으로 보이지만 수정하지 않은 항목 (사용자에게 플래그)
