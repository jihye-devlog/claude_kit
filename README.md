# claude_kit

Claude Code 커스터마이징 도구 모음입니다.

## 디렉토리 구조

```
claude_kit/
├── .claude/
│   └── agents/
│       ├── code-researcher.md
│       ├── planner.md
│       ├── design-architect.md
│       ├── senior-clean-architect.md
│       ├── skill-executor.md
│       └── translator.md
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
| [.claude/agents/code-researcher.md](./.claude/agents/code-researcher.md) | 에이전트 | 코드베이스를 분석해 구조, 동작, 아키텍처를 파악하고 RESEARCH.md 작성 |
| [.claude/agents/planner.md](./.claude/agents/planner.md) | 에이전트 | 사용자 요청과 RESEARCH.md를 기반으로 구현 계획을 수립하고 PLAN.md 작성 |
| [.claude/agents/design-architect.md](./.claude/agents/design-architect.md) | 에이전트 | PLAN.md를 기반으로 코드 수준의 아키텍처를 설계하고 DESIGN.md 작성 |
| [.claude/agents/senior-clean-architect.md](./.claude/agents/senior-clean-architect.md) | 에이전트 | DESIGN.md와 PLAN.md를 기반으로 클린 아키텍처 원칙에 따라 실제 코드와 TC 구현 |
| [.claude/agents/skill-executor.md](./.claude/agents/skill-executor.md) | 에이전트 | 커스텀 스킬을 서브 컨텍스트에서 실행해 메인 컨텍스트를 깨끗하게 유지 |
| [.claude/agents/translator.md](./.claude/agents/translator.md) | 에이전트 | 파일이나 텍스트를 지정한 언어로 번역 및 로컬라이즈 |
