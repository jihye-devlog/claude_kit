# claude_kit

Claude Code 커스터마이징 도구 모음입니다.

## 디렉토리 구조

```
claude_kit/
├── .claude/
│   └── agents/
│       ├── code-researcher.md
│       ├── planner.md
│       └── design-architect.md
├── statusline/
│   ├── statusline.sh
│   └── README.md
├── notification/
│   ├── notify.sh
│   └── README.md
├── save-progress/
│   ├── save-progress.md
│   └── README.md
└── add-tool/
    ├── add-tool.md
    └── README.md
```

## 목록

| 경로 | 유형 | 설명 |
|------|------|------|
| [statusline](./statusline) | 스크립트 | Claude Code 하단 상태바 커스터마이징 |
| [notification](./notification) | 스크립트 | 작업 완료 및 응답 필요 시 OS 네이티브 알림 전송 |
| [save-progress](./save-progress) | 스킬 | 세션 진행 상황을 메모리 파일에 저장해 다음 세션에서 이어받기 |
| [add-tool](./add-tool) | 스킬 | 스킬/에이전트/스크립트 파일을 레포에 자동 등록 |
| [.claude/agents/code-researcher.md](./.claude/agents/code-researcher.md) | 에이전트 | 코드베이스를 분석해 구조, 동작, 아키텍처를 파악하고 RESEARCH.md 작성 |
| [.claude/agents/planner.md](./.claude/agents/planner.md) | 에이전트 | 사용자 요청과 RESEARCH.md를 기반으로 구현 계획을 수립하고 PLAN.md 작성 |
| [.claude/agents/design-architect.md](./.claude/agents/design-architect.md) | 에이전트 | PLAN.md를 기반으로 코드 수준의 아키텍처를 설계하고 DESIGN.md 작성 |
