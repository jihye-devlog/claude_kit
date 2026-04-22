# setup

claude_kit 레포를 클론한 새 PC 환경에서 글로벌 Claude Code 설정을 한 번에 맞추는 스킬.
각 도구의 README 를 참고해 설치를 진행하며, 설치 방식이 여러 가지인 경우 사용자에게 선택을 묻는다.

## 전제 조건

- claude_kit 레포가 로컬에 클론되어 있어야 한다
- `~/.claude/` 디렉토리가 존재해야 한다 (Claude Code 설치 시 자동 생성됨)

## 실행 절차

### 1단계: 레포 루트 확인

현재 작업 디렉토리가 claude_kit 레포 루트인지 확인한다.
`custom_skills/`, `.claude/agents/`, `custom_script/` 디렉토리가 존재하면 정상이다.
아니라면 사용자에게 claude_kit 루트로 이동 후 재실행을 안내하고 종료한다.

### 2단계: 에이전트 설치

`.claude/agents/` 디렉토리의 모든 `.md` 파일을 `~/.claude/agents/` 에 복사한다.

```bash
cp .claude/agents/*.md ~/.claude/agents/
```

설치된 에이전트 목록을 출력한다.

### 3단계: 스킬 설치

`custom_skills/` 하위 각 디렉토리의 `<name>.md` 파일을 `~/.claude/commands/` 에 복사한다.

```bash
cp custom_skills/add-tool/add-tool.md ~/.claude/commands/add-tool.md
cp custom_skills/lessons/lessons.md ~/.claude/commands/lessons.md
cp custom_skills/review/review.md ~/.claude/commands/review.md
cp custom_skills/save-progress/save-progress.md ~/.claude/commands/save-progress.md
cp custom_skills/sync-readme/sync-readme.md ~/.claude/commands/sync-readme.md
cp custom_skills/commit/commit.md ~/.claude/commands/commit.md
```

설치된 스킬 목록을 출력한다.

### 4단계: 스크립트 설치

아래 스크립트를 복사하고 실행 권한을 부여한다.

```bash
cp custom_script/notification/notify.sh ~/.claude/notify.sh
chmod +x ~/.claude/notify.sh

cp custom_script/statusline/statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
```

### 5단계: keybindings 설치 여부 확인

`~/.claude/keybindings.json` 이 레포의 `custom_script/keybindings/keybindings.json` 과 동일하면 "이미 설치됨" 으로 건너뛴다.

다르거나 없으면 사용자에게 묻는다:

```
keybindings.json 을 설치하시겠습니까?
현재 설정: Shift+Enter → 줄바꿈
기존 ~/.claude/keybindings.json 이 있으면 덮어씁니다.
(y/n)
```

y 이면:
```bash
cp custom_script/keybindings/keybindings.json ~/.claude/keybindings.json
```

### 6단계: sync-readme 훅 방식 선택

`~/.claude/settings.json` 에 아래 Stop 훅 prompt 가 이미 존재하면 "이미 설치됨" 으로 건너뛴다. UserPromptSubmit 방식이 이미 존재해도 마찬가지로 건너뛴다.

설치되어 있지 않으면 사용자에게 묻는다:

```
sync-readme 자동 실행 방식을 선택하세요:
1. Stop 훅 (권장) — Claude 작업 종료 시 한 번만 실행, 흐름을 끊지 않음
2. UserPromptSubmit 훅 — 매 메시지 전송 시마다 git status 확인
3. 설치 안 함
```

선택에 따라 `~/.claude/settings.json` 에 해당 훅을 추가한다.

Stop 훅 선택 시 추가할 내용:
```json
{
  "type": "prompt",
  "prompt": "다음 우선순위로 판단한다. 1순위(즉시 종료): 이번 턴 Edit/Write 없거나 README/sync-readme 산출물뿐인 경우, 또는 마지막 응답이 사용자에게 확인·승인·진행 여부를 묻는 질문으로 끝난 경우 — 어떤 스킬도 실행하지 않고 즉시 종료한다. 2순위(실행): 1순위 조건 중 어느 것도 해당하지 않고 코드·문서 편집이 있으며 sync-readme 미실행이면 skill-executor로 sync-readme 실행."
}
```

UserPromptSubmit 훅 선택 시 추가할 내용:
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ./custom_skills/sync-readme/check-sync.sh"
          }
        ]
      }
    ]
  }
}
```

### 7단계: review 훅 설치 여부 확인

`~/.claude/settings.json` Stop 훅에 review prompt 가 이미 존재하면 "이미 설치됨" 으로 건너뛴다.

설치되어 있지 않으면 사용자에게 묻는다:

```
review 스킬을 Stop 훅으로 자동 실행하도록 설정하시겠습니까?
코드·문서 편집 완료 시 자동으로 자체 검토를 실행합니다.
(y/n)
```

y 이면 `~/.claude/settings.json` Stop 훅에 아래를 추가한다:
```json
{
  "type": "prompt",
  "prompt": "다음 우선순위로 판단한다. 1순위(즉시 종료): 이번 턴 Edit/Write 없거나 README/sync-readme 산출물뿐인 경우, 또는 마지막 응답이 사용자에게 확인·승인·진행 여부를 묻는 질문으로 끝난 경우 — 어떤 스킬도 실행하지 않고 즉시 종료한다. 2순위(실행): 1순위 조건 중 어느 것도 해당하지 않고 코드·문서 편집이 있으며 review 미실행이면 review 스킬 실행."
}
```

### 8단계: verifier 훅 설치 여부 확인

`~/.claude/settings.json` Stop 훅에 verifier prompt 가 이미 존재하면 "이미 설치됨" 으로 건너뛴다.

설치되어 있지 않으면 사용자에게 묻는다:

```
verifier 에이전트를 Stop 훅으로 자동 실행하도록 설정하시겠습니까?
코드 파일(.py/.ts/.go 등) 편집 완료 시 자동으로 빌드·린트·테스트를 실행합니다.
(y/n)
```

y 이면 `~/.claude/settings.json` Stop 훅에 아래를 추가한다:
```json
{
  "type": "prompt",
  "prompt": "이번 턴(가장 최근 user 메시지 이후)에 Claude 가 직접 Edit 또는 Write 도구로 실제 코드 파일을 편집했는지 확인하세요. 실제 코드 파일 예: .py .ts .tsx .js .jsx .go .rs .java .kt .rb .php .c .cpp .h .hpp .swift .cs .scala .sh .sql 및 src/ tests/ app/ lib/ 등 프로젝트 소스 경로 아래의 파일. 다음 경우에는 이 훅을 실행하지 말고 즉시 종료를 허용합니다: (1) 이번 턴에 Edit/Write 호출이 전혀 없었다. (2) 이번 턴에 편집한 파일이 .md / README.md / 문서/설정 파일뿐이다. (3) 이번 턴에 이미 verifier 에이전트가 Agent 도구로 호출된 적이 있다(중복 방지). (4) 프로젝트 루트 CLAUDE.md 의 '## 빌드 & 테스트' 섹션이 비어있어 실행할 명령이 없고 verifier 도 추론 실패가 확실한 상황이다. (5) 마지막 응답이 사용자에게 확인·승인·진행 여부를 묻는 질문으로 끝났다 — 이 경우 어떤 스킬도 실행하지 않고 즉시 종료한다. 그 외의 경우에는 Agent 도구로 subagent_type=\"verifier\" 를 호출해 Full 모드 검증을 수행하세요. 호출 시 프롬프트에 '모드: Full' 과 '이번 턴에 편집된 파일 경로 목록' 을 반드시 명시하세요. verifier 가 실패를 반환하면 카테고리별 권고(implementer 또는 tc-writer 재호출) 를 사용자에게 전달하세요."
}
```

### 9단계: notification 훅 설치 여부 확인

`~/.claude/settings.json` 에 notification Stop 훅(notify.sh 커맨드)과 Notification 훅이 이미 존재하면 "이미 설치됨" 으로 건너뛴다.

설치되어 있지 않으면 사용자에게 묻는다:

```
작업 완료·응답 필요 시 OS 알림을 받도록 설정하시겠습니까?
(y/n)
```

y 이면 `~/.claude/settings.json` 에 아래를 추가한다:
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/notify.sh 'Claude Code' '작업이 완료되었습니다'"
          }
        ]
      }
    ],
    "Notification": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "MSG=$(jq -r '.message // \"응답이 필요합니다\"' 2>/dev/null || echo '응답이 필요합니다'); bash ~/.claude/notify.sh 'Claude Code' \"$MSG\""
          }
        ]
      }
    ]
  }
}
```

### 10단계: statusline 설치 여부 확인

`~/.claude/settings.json` 에 statusLine 설정이 이미 존재하면 "이미 설치됨" 으로 건너뛴다.

설치되어 있지 않으면 사용자에게 묻는다:

```
Claude Code 하단 상태바를 커스터마이징하도록 설정하시겠습니까?
표시 항목: 모델명 | context 사용률 | git 브랜치 | 프로젝트명
(y/n)
```

y 이면 `~/.claude/settings.json` 에 아래를 추가한다:
```json
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.claude/statusline.sh"
  }
}
```

### 11단계: 글로벌 설정 적용

`study/global_settings.md` 에 정의된 기본 설정을 `~/.claude/settings.json` 에 반영한다. 이미 동일한 값이 설정되어 있으면 "이미 설치됨" 으로 건너뛴다.

빠진 항목이 있으면 사용자에게 묻는다:

```
글로벌 기본 설정을 적용하시겠습니까?
- permissions: defaultMode=acceptEdits, allow=[Write,Edit,Glob,Grep,Read]
- model: claude-sonnet-4-6
- env: CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
- teammateMode: tmux
- skipDangerousModePermissionPrompt: true
(y/n)
```

y 이면 `~/.claude/settings.json` 에 아래 항목들을 병합한다:
```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  },
  "permissions": {
    "defaultMode": "acceptEdits",
    "allow": [
      "Write",
      "Edit",
      "Glob",
      "Grep",
      "Read"
    ]
  },
  "model": "claude-sonnet-4-6",
  "teammateMode": "tmux",
  "skipDangerousModePermissionPrompt": true
}
```

### 12단계: settings.json 병합

위 단계에서 수집한 모든 설정을 `~/.claude/settings.json` 의 기존 내용과 병합한다.
- 기존 파일이 없으면 새로 생성한다
- 기존 hooks 배열이 있으면 항목을 추가하고, 없으면 새로 만든다
- 중복 항목은 추가하지 않는다

### 13단계: 완료 보고

설치된 항목을 표로 출력한다.

| 항목 | 상태 |
|------|------|
| 에이전트 (N개) | 설치됨 |
| 스킬 (N개) | 설치됨 |
| notify.sh | 설치됨 |
| statusline.sh | 설치됨 |
| keybindings.json | 설치됨 / 이미 설치됨 / 건너뜀 |
| sync-readme 훅 | Stop / UserPromptSubmit / 이미 설치됨 / 건너뜀 |
| review 훅 | 설치됨 / 이미 설치됨 / 건너뜀 |
| verifier 훅 | 설치됨 / 이미 설치됨 / 건너뜀 |
| notification 훅 | 설치됨 / 이미 설치됨 / 건너뜀 |
| statusline 설정 | 설치됨 / 이미 설치됨 / 건너뜀 |
| 글로벌 기본 설정 | 설치됨 / 이미 설치됨 / 건너뜀 |

마지막으로 안내한다:
```
Claude Code를 재시작하면 모든 설정이 적용됩니다.
```
