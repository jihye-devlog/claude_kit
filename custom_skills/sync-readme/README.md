# sync-readme

레포 유형을 자동으로 분석해 변경 사항에 맞는 README.md 를 업데이트하는 스킬

## 설치 방법

```bash
cp sync-readme/sync-readme.md ~/.claude/commands/sync-readme.md
```

Claude Code 재시작 후 `/sync-readme` 로 사용 가능하다.

## 사용 방법

코드 변경 후 Claude 가 자동으로 호출하거나, 직접 실행:

```
/sync-readme
```

## 동작 방식

1. 레포를 분석해 유형 판단 (도구 모음 / 앱·서비스 / 라이브러리 / 모노레포)
2. 기존 README 를 읽어 스타일, 톤, 구조 파악
3. 변경된 내용 기준으로 업데이트할 README 와 섹션 결정
4. 기존 스타일을 유지하면서 필요한 부분만 수정

## 자동 트리거 설정

hook 을 등록하면 Claude 가 README 업데이트 필요 여부를 자동으로 판단한다. 사용 환경에 따라 두 가지 방식 중 선택할 수 있다.

### 방법 1: 모든 변경 감지 (UserPromptSubmit)

사용자가 메시지를 보낼 때마다 `check-sync.sh` 가 `git status` 를 확인한다. Claude 도구뿐 아니라 VSCode, 터미널 등 외부에서 변경한 경우에도 감지된다.

프로젝트 설정 (`.claude/settings.local.json`) 또는 글로벌 설정 (`~/.claude/settings.json`) 에 추가한다.

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

| 장점 | 단점 |
|------|------|
| 변경 방식과 무관하게 감지 | 매 메시지마다 git status 실행 |
| 외부 편집기 변경도 포함 | 프로젝트 레벨 설정 시 레포마다 등록 필요 |

### 방법 2: Claude 변경만 감지 (PostToolUse)

Claude 가 Edit 또는 Write 도구를 사용했을 때만 트리거된다. 글로벌 설정 (`~/.claude/settings.json`) 에 추가하면 모든 프로젝트에서 동작한다.

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "prompt",
            "prompt": "파일이 변경되었습니다. README 업데이트가 필요한 변경인지 확인하고, 필요하다면 /sync-readme 를 실행하세요."
          }
        ]
      }
    ]
  }
}
```

| 장점 | 단점 |
|------|------|
| 글로벌 한 번 설정으로 모든 프로젝트 적용 | VSCode, 터미널 등 외부 변경 감지 불가 |
| 파일 변경 시에만 트리거되어 노이즈 적음 | Claude 의 Edit/Write 사용 시에만 동작 |

### 트리거 대상 상황

- 코드 또는 기능 구현 완료
- 파일 또는 디렉토리 추가·삭제
- 기능 동작 변경
- 에이전트·스킬·도구 추가 또는 수정
- 설치·설정 방법 변경
