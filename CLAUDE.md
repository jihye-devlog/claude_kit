## 세션 시작
새 세션이 시작되면 .claude/memory/MEMORY.md 를 읽고 링크된 메모리 파일을 모두 읽어 이전 진행 상황을 파악한다. 메모리 업데이트는 .claude/memory/ 의 파일을 수정한다. ~/.claude/mistakes.md 가 존재하면 읽고 과거 실수 패턴을 피한다.

## 워크 플로우
모든 md 파일은 특수 기호 없이 제목·표로 시각화해 작성한다. 파일 수정·추가·탐색은 진행 여부를 묻지 않고 바로 진행한다.

## 에이전트 파이프라인
5단계 순차: researcher → planner → designer → implementer → tc-writer. 산출 문서는 `.claude/doc/` 아래(RESEARCH/PLAN/DESIGN.md). implementer 는 항목별로 verifier(Quick) → tc-writer 를 자동 체이닝하고, 파이프라인 종료 시 verifier(Full) 로 마감한다. 각 에이전트 내부 동작은 `.claude/agents/<name>.md` 참고.

### 호출 트리거
| 사용자 신호 | 에이전트 |
| --- | --- |
| "분석해줘", "구조 파악" | researcher |
| 신규 기능/리팩토링/API 요청 | planner |
| "설계해줘", "DESIGN.md 작성" | designer |
| "구현해줘", "implement" | implementer |
| "TC 작성", "테스트 보강" | tc-writer |
| "검증해줘", "빌드/테스트 실행" | verifier |

### 규칙
- **선행 조건**: planner 전 RESEARCH.md(기존 코드베이스), designer 전 PLAN.md, implementer 전 PLAN.md + DESIGN.md 및 명시적 "구현해줘".
- **건너뛰기**: 신규 프로젝트는 researcher 생략 가능. 단순 요구사항은 designer 생략 가능(PLAN.md 만으로 구현 모호하지 않을 때).
- **자동 체이닝 금지**: researcher→planner, planner→designer, designer→implementer 전이는 사용자 지시 있을 때만.
- **결함 루프**: 하류 에이전트가 결함 발견 시 해당 단계 재실행을 안내. 요구사항→planner, 설계→designer, 리서치→researcher, 코드→implementer, TC→tc-writer, 빌드/린트/타입/테스트 실패(verifier)→카테고리에 따라 implementer 또는 tc-writer.

## 빌드 & 테스트
verifier 가 이 섹션의 명령을 읽어 실행한다. 프로젝트 특성에 맞게 항목별로 `명령:` 뒤에 한 줄씩 기록한다. 비어있으면 verifier 가 설정 파일(package.json, pyproject.toml, Makefile, go.mod 등) 을 스캔해 추론하고 이 섹션에 기록한다. 해당 없는 항목은 "N/A".

- 빌드 :
- 린트 :
- 포매터 :
- 타입 체크 :
- 단위 테스트 :
- 통합 테스트 :
