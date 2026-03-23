# notify.sh

Claude Code 작업 완료 및 사용자 응답 필요 시 OS 네이티브 알림을 전송하는 스크립트입니다.

## 지원 OS

| OS | 방식 | 비고 |
|---|---|---|
| macOS | osascript | 기본 내장 |
| Linux | notify-send | libnotify 설치 필요 |
| Windows | PowerShell BalloonTip | Git Bash 환경 기준 |

## 알림 시점

| Hook | 시점 | 알림 메시지 |
|---|---|---|
| Stop | Claude가 응답을 마쳤을 때 | 작업이 완료되었습니다 |
| Notification | Claude가 사용자 입력을 기다릴 때 | 해당 알림 메시지 |

## 설치 방법

**1. 스크립트를 복사합니다.**

```bash
cp notification/notify.sh ~/.claude/notify.sh
chmod +x ~/.claude/notify.sh
```

**2. `~/.claude/settings.json`에 아래 설정을 추가합니다.**

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

## 의존성

- `bash` 4.0+
- macOS: 없음 (osascript 기본 내장)
- Linux: `libnotify` (`sudo apt install libnotify-bin` 또는 `brew install libnotify`)
- Windows: PowerShell (Git Bash 환경)

## 동작 방식

`Stop` hook은 Claude가 응답을 마칠 때 실행됩니다. `Notification` hook은 Claude Code가 알림 이벤트를 발생시킬 때 실행되며, stdin으로 전달된 JSON에서 메시지를 추출해 알림 내용으로 사용합니다.

```
stdin JSON (.message) --> notify.sh --> OS 네이티브 알림
```
