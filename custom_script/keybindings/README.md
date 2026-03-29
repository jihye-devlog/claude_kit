# keybindings.json

Claude Code CLI에서 키보드 단축키를 커스터마이징하는 설정 파일입니다.

## 기본 설정

| 키 | 동작 | 설명 |
|---|---|---|
| Enter | 메시지 전송 | 기본 동작 (변경 없음) |
| Shift+Enter | 줄바꿈 | chat:newline 액션 바인딩 |

## 설치 방법

**1. 설정 파일을 복사합니다.**

```bash
cp keybindings/keybindings.json ~/.claude/keybindings.json
```

**2. 바로 적용됩니다.** 재시작이 필요 없습니다.

## 커스터마이징

`~/.claude/keybindings.json` 파일을 직접 수정하여 원하는 키 조합으로 변경할 수 있습니다.

**예시 — Ctrl+Enter로 줄바꿈:**

```json
{
  "bindings": [
    {
      "context": "Chat",
      "bindings": {
        "ctrl+enter": "chat:newline"
      }
    }
  ]
}
```

## 사용 가능한 주요 액션

| 액션 | 설명 |
|---|---|
| chat:newline | 줄바꿈 삽입 |
| chat:submit | 메시지 전송 |
| chat:cancel | 현재 응답 취소 |
| history:previous | 이전 입력 불러오기 |
| history:next | 다음 입력 불러오기 |

## 동작 방식

Claude Code는 시작 시 `~/.claude/keybindings.json` 파일을 읽어 키바인딩을 적용합니다. 파일 변경 시 자동으로 감지되어 재시작 없이 즉시 반영됩니다.
