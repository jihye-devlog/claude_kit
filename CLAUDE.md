## 세션 시작
새 세션이 시작되면 .claude/memory/MEMORY.md 를 읽고 링크된 메모리 파일을 모두 읽어 이전 진행 상황을 파악한다.
메모리를 업데이트할 때는 .claude/memory/ 디렉토리의 파일을 수정한다.
~/.claude/mistakes.md 가 존재하면 읽고 과거 실수 패턴을 파악한다. 현재 작업과 관련된 항목이 있으면 같은 실수를 반복하지 않도록 주의한다.

## 워크 플로우
모든 md 파일을 작성할때엔 특수 기호를 사용하지 않으나 제목, 표 등 보기좋게 시각화하여 작성한다.
모든 파일의 수정 및 추가, 탐색 등의 작업 시 진행 여부를 묻지 않고 바로 진행한다.

## 에이전트 파이프라인

### 개요
표준 기능 개발 흐름은 5단계 파이프라인이다.
researcher → planner → designer → implementer → tc-writer

각 단계의 산출물은 다음 단계의 입력이다.
- researcher : .claude/doc/RESEARCH.md
- planner : .claude/doc/PLAN.md
- designer : .claude/doc/DESIGN.md
- implementer : 실제 소스 코드 + PLAN.md 체크박스 갱신
- tc-writer : test/ 디렉토리의 TC 파일

### 호출 트리거
다음 상황에서 해당 에이전트를 호출한다.

| 사용자 신호 | 호출 에이전트 |
| --- | --- |
| "코드베이스 분석해줘", "구조 파악해줘" | researcher |
| 신규 기능/리팩토링/API 요청 | planner |
| "PLAN.md 완료, 설계 시작", "설계해줘" | designer |
| "구현해줘", "implement" | implementer |
| "TC 작성해줘", "테스트 보강해줘" | tc-writer |

implementer 는 각 PLAN.md 항목 구현 직후 tc-writer 를 자동 호출한다(사용자 재지시 불필요).

### 선행 조건
다음 조건이 만족되지 않으면 해당 에이전트를 호출하지 않고 선행 단계를 먼저 안내한다.
- planner 호출 전 : 기존 코드베이스 작업이면 RESEARCH.md 필요. 없으면 researcher 먼저.
- designer 호출 전 : PLAN.md 필요. 없으면 planner 먼저.
- implementer 호출 전 : PLAN.md 와 DESIGN.md 필요. 사용자가 "구현해줘" 를 명시적으로 말할 때까지 대기.
- tc-writer 호출 전 (스코프 모드) : implementer 가 해당 항목 구현 및 체크박스 갱신 완료.

### 건너뛰기 조건
- 완전 신규 프로젝트라 분석할 기존 코드가 없음 → researcher 생략
- 요구사항이 단순하고 구조적 설계가 불필요함 → designer 생략(단, PLAN.md 만으로 implementer 가 모호함 없이 진행 가능해야 함)
- 문서/설정 변경처럼 테스트할 동작이 없음 → tc-writer 의 해당 항목 SKIP 판정

### 사용자 승인 지점
단계 간 자동 체이닝을 금지한다. 다음 전이는 사용자가 명시적으로 지시할 때만 진행한다.
- researcher 완료 → planner 시작
- planner 완료 → designer 시작
- designer 완료 → implementer 시작

implementer 내부의 "항목 단위 파이프라인(구현 → tc-writer 위임)" 은 자동이지만, implementer 전체를 종료하고 다음 작업으로 넘어가는 판단은 사용자 몫이다.

### 결함 루프
각 에이전트가 상류 문서 결함을 발견하면 해당 단계 재실행을 사용자에게 안내한다.
- 요구사항/범위 결함 → planner 재실행
- 아키텍처/인터페이스 결함 → designer 재실행
- 기존 코드베이스 이해 부족 → researcher 재실행
- 코드 결함(tc-writer 발견) → implementer 가 같은 항목에서 수정 후 tc-writer 재호출

## 빌드 & 테스트
