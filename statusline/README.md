# statusline.sh

Claude Code 하단 상태바를 커스터마이징하는 스크립트입니다.

## 표시 항목

아래 순서로 `|` 구분자와 함께 표시됩니다.

| 항목 | 예시 | 설명 |
|------|------|------|
| Model name | `claude-sonnet-4-6` | 현재 사용 중인 모델명 |
| Context bar | `████░░░░░░ 42%` | context window 사용률 (progress bar + 퍼센트) |
| Token bar | `███░░░░░░░ 45123/200K` | 토큰 사용량 (progress bar + 사용/전체) |
| Git branch | `(main)` | 현재 git 브랜치 |
| Project name | `claude_kit` | 현재 디렉토리 이름 |

**색상 기준:**
- 초록 — 50% 미만
- 노랑 — 50~79%
- 빨강 — 80% 이상

## 설치 방법

**1. 스크립트를 복사하거나 경로를 확인합니다.**

```bash
cp statusline/statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
```

**2. `~/.claude/settings.json`에 아래 설정을 추가합니다.**

```json
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.claude/statusline.sh"
  }
}
```

> 스크립트를 다른 경로에 둔다면 `command` 값을 해당 절대경로로 변경하세요.

## 의존성

- `bash` 4.0+
- `jq` — JSON 파싱에 사용 (`brew install jq`)
- `git` — 브랜치 정보 조회에 사용

## 동작 방식

Claude Code는 이벤트 발생 시 JSON 데이터를 스크립트의 stdin으로 전달합니다. 스크립트는 이를 파싱해 포맷팅된 문자열을 stdout으로 출력하고, Claude Code가 이를 하단 상태바에 렌더링합니다.

주요 JSON 필드:

```
.model.display_name                      — 모델명
.context_window.used_percentage          — context 사용률 (%)
.context_window.total_input_tokens       — 누적 입력 토큰 수
.context_window.context_window_size      — context window 최대 크기
.workspace.current_dir                   — 현재 작업 디렉토리
.vim.mode                                — vim 모드 (사용 시)
```
