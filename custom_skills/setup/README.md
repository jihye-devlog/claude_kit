# setup

새 PC에서 claude_kit 레포를 클론한 후 글로벌 Claude Code 환경을 한 번에 맞추는 스킬.

## 설치 방법

```bash
cp custom_skills/setup/setup.md ~/.claude/commands/setup.md
```

Claude Code 재시작 후 `/setup` 으로 사용 가능합니다.

## 사용 방법

claude_kit 레포 루트에서 실행합니다.

```
/setup
```

## 설치 항목

| 항목 | 설명 |
|------|------|
| 에이전트 | `.claude/agents/*.md` → `~/.claude/agents/` |
| 스킬 | `custom_skills/**/*.md` → `~/.claude/commands/` |
| notify.sh | OS 네이티브 알림 스크립트 |
| statusline.sh | 하단 상태바 커스터마이징 스크립트 |
| keybindings.json | 키보드 단축키 설정 (선택) |
| sync-readme 훅 | Stop 또는 UserPromptSubmit 중 선택 |
| review 훅 | Stop 훅 자동 실행 (선택) |
| verifier 훅 | Stop 훅 자동 실행 (선택) |
| notification 훅 | 작업 완료·응답 필요 알림 (선택) |
| statusline 설정 | settings.json statusLine 항목 (선택) |

## 동작 방식

1. 에이전트·스킬·스크립트를 글로벌 경로에 복사
2. 설치 방식이 여러 가지인 항목(sync-readme 훅 등)은 사용자에게 선택 요청
3. 선택 사항(keybindings, 각종 훅)은 y/n 으로 확인 후 설치
4. 수집된 설정을 `~/.claude/settings.json` 에 병합
5. 설치 완료 보고 출력
