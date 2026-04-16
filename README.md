# claude_kit

Claude Code 커스터마이징 도구 모음입니다.

## 디렉토리 구조

```
claude_kit/
├── .claude/
│   ├── agents/
│   │   ├── researcher.md
│   │   ├── planner.md
│   │   ├── designer.md
│   │   ├── implementer.md
│   │   ├── tc-writer.md
│   │   ├── verifier.md
│   │   ├── skill-executor.md
│   │   └── translator.md
│   ├── doc/
│   │   ├── PLAN.md
│   │   ├── DESIGN.md
│   │   └── RESEARCH.md
│   └── memory/
├── custom_script/
│   ├── keybindings/
│   │   ├── keybindings.json
│   │   └── README.md
│   ├── notification/
│   │   ├── notify.sh
│   │   └── README.md
│   └── statusline/
│       ├── statusline.sh
│       └── README.md
├── custom_skills/
│   ├── add-tool/
│   │   ├── add-tool.md
│   │   └── README.md
│   ├── lessons/
│   │   ├── lessons.md
│   │   └── README.md
│   ├── review/
│   │   ├── review.md
│   │   └── README.md
│   ├── save-progress/
│   │   ├── save-progress.md
│   │   └── README.md
│   └── sync-readme/
│       ├── sync-readme.md
│       ├── check-sync.sh
│       └── README.md
└── study/
    ├── plugin.md
    └── lessons-workspace/
```

## 목록

| 경로 | 유형 | 설명 |
|------|------|------|
| [keybindings](./custom_script/keybindings) | 설정 | CLI 키바인딩 커스터마이징 (Shift+Enter 줄바꿈 등) |
| [statusline](./custom_script/statusline) | 스크립트 | Claude Code 하단 상태바 커스터마이징 |
| [notification](./custom_script/notification) | 스크립트 | 작업 완료 및 응답 필요 시 OS 네이티브 알림 전송 |
| [save-progress](./custom_skills/save-progress) | 스킬 | 세션 진행 상황을 메모리 파일에 저장해 다음 세션에서 이어받기 |
| [add-tool](./custom_skills/add-tool) | 스킬 | 스킬/에이전트/스크립트 파일을 레포에 자동 등록 |
| [lessons](./custom_skills/lessons) | 스킬 | Claude 실수를 기록하고 반복 방지 |
| [review](./custom_skills/review) | 스킬 | 작업 완료 후 변경된 코드와 파일을 자체 검토하고 문제 수정 |
| [sync-readme](./custom_skills/sync-readme) | 스킬 | 레포 유형을 분석해 변경 사항에 맞는 README 자동 업데이트 |
| [.claude/agents/researcher.md](./.claude/agents/researcher.md) | 에이전트 | 코드베이스를 분석해 구조, 동작, 아키텍처를 파악하고 .claude/doc/RESEARCH.md 작성 |
| [.claude/agents/planner.md](./.claude/agents/planner.md) | 에이전트 | 사용자 요청과 RESEARCH.md를 기반으로 구현 계획을 수립하고 .claude/doc/PLAN.md 작성 |
| [.claude/agents/designer.md](./.claude/agents/designer.md) | 에이전트 | PLAN.md를 기반으로 코드 수준의 아키텍처를 설계하고 .claude/doc/DESIGN.md 작성 |
| [.claude/agents/implementer.md](./.claude/agents/implementer.md) | 에이전트 | DESIGN.md와 PLAN.md를 기반으로 클린 아키텍처 원칙에 따라 실제 코드를 구현. 각 항목 완료 후 tc-writer를 자동 호출하고 WRITE/SKIP/DEFER 판정을 처리하며, 지연 TC 대기 큐를 관리하는 항목 단위 순차 파이프라인 실행 |
| [.claude/agents/tc-writer.md](./.claude/agents/tc-writer.md) | 에이전트 | 각 구현 항목마다 2단계 사전 평가(WRITE/SKIP/DEFER)를 수행하여 TC 필요성과 시점을 판정. WRITE인 항목의 TC를 작성하고 코드 결함을 보고 (implementer와 협업) |
| [.claude/agents/verifier.md](./.claude/agents/verifier.md) | 에이전트 | 변경 코드를 프로젝트별 빌드/린트/포매터/타입/테스트 명령으로 검증. Quick/Test/Full 3가지 모드 지원. CLAUDE.md '## 빌드 & 테스트' 섹션에서 명령을 읽고 실패 시 카테고리별로 implementer 또는 tc-writer 재호출 안내 |
| [.claude/agents/skill-executor.md](./.claude/agents/skill-executor.md) | 에이전트 | 커스텀 스킬을 서브 컨텍스트에서 실행해 메인 컨텍스트를 깨끗하게 유지 |
| [.claude/agents/translator.md](./.claude/agents/translator.md) | 에이전트 | 파일이나 텍스트를 지정한 언어로 번역 및 로컬라이즈 |

## verifier 자동 실행 훅 설치 가이드

`verifier` 에이전트는 `implementer` 가 각 구현 항목 직후(Quick 모드) 및 파이프라인 종료 시(Full 모드) 자동 호출한다. 파이프라인 밖에서 이뤄진 코드 편집(사용자 직접 수정·ad-hoc 버그픽스 등) 에도 안전망으로 자동 검증이 필요하다면, **verifier 를 사용하려는 대상 프로젝트의 `.claude/settings.json`** 에 아래 Stop 훅을 추가한다. 본 claude_kit 레포 자체에는 검증 대상 소스가 없으므로 설치하지 않는다.

### 설치 위치
대상 프로젝트 루트의 `.claude/settings.json` (팀 공유가 필요하면 커밋 대상, 개인용이면 `.claude/settings.local.json` 사용).

### 추가할 JSON
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "이번 턴(가장 최근 user 메시지 이후)에 Claude 가 직접 Edit 또는 Write 도구로 실제 코드 파일을 편집했는지 확인하세요. 실제 코드 파일 예: .py .ts .tsx .js .jsx .go .rs .java .kt .rb .php .c .cpp .h .hpp .swift .cs .scala .sh .sql 및 src/ tests/ app/ lib/ 등 프로젝트 소스 경로 아래의 파일. 다음 경우에는 이 훅을 실행하지 말고 즉시 종료를 허용합니다: (1) 이번 턴에 Edit/Write 호출이 전혀 없었다. (2) 이번 턴에 편집한 파일이 .md / README.md / 문서/설정 파일뿐이다. (3) 이번 턴에 이미 verifier 에이전트가 Agent 도구로 호출된 적이 있다(중복 방지). (4) 프로젝트 루트 CLAUDE.md 의 '## 빌드 & 테스트' 섹션이 비어있어 실행할 명령이 없고 verifier 도 추론 실패가 확실한 상황이다. 그 외의 경우에는 Agent 도구로 subagent_type=\"verifier\" 를 호출해 Full 모드 검증을 수행하세요. 호출 시 프롬프트에 '모드: Full' 과 '이번 턴에 편집된 파일 경로 목록' 을 반드시 명시하세요. verifier 가 실패를 반환하면 카테고리별 권고(implementer 또는 tc-writer 재호출) 를 사용자에게 전달하세요."
          }
        ]
      }
    ]
  }
}
```

### 사전 준비
1. 대상 프로젝트의 `.claude/agents/` 에 `verifier.md` 를 복사(또는 심볼릭 링크)한다. `implementer.md`, `tc-writer.md` 도 함께 있어야 파이프라인이 완결된다.
2. 대상 프로젝트 루트 `CLAUDE.md` 에 `## 빌드 & 테스트` 섹션을 만들고 빌드/린트/포매터/타입 체크/단위·통합 테스트 명령을 기록한다. 비어있으면 verifier 가 설정 파일을 스캔해 추론하고 이 섹션에 기록한다.
3. 훅을 추가한 뒤 Claude Code 는 시작 시점의 설정만 감시하므로 `/hooks` 로 리로드하거나 세션을 재시작한다.

### 동작 요약
- 대상 프로젝트에서 Claude 가 코드 파일(.py/.ts/.go/… 등) 을 편집하고 턴이 끝나면, 훅이 메인 Claude 에게 verifier Full 모드 호출을 지시한다.
- .md/설정 파일만 편집되었거나 이미 verifier 가 실행된 턴에서는 자동으로 건너뛴다.
- verifier 결과가 실패이면 실패 카테고리에 따라 implementer 또는 tc-writer 재호출을 안내한다.
