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
| [.claude/agents/skill-executor.md](./.claude/agents/skill-executor.md) | 에이전트 | 커스텀 스킬을 서브 컨텍스트에서 실행해 메인 컨텍스트를 깨끗하게 유지 |
| [.claude/agents/translator.md](./.claude/agents/translator.md) | 에이전트 | 파일이나 텍스트를 지정한 언어로 번역 및 로컬라이즈 |
