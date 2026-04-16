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

### 방법 2: 종료 시점에만 감지 (Stop, 권장)

Claude 가 작업을 종료하려 할 때 한 번만 발동한다. 편집이 여러 번 발생해도 중간 흐름을 끊지 않고 마지막에 일괄 점검한다. 글로벌 설정 (`~/.claude/settings.json`) 의 `Stop` 훅에 추가한다.

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "STRICT 판정 규칙 - 가장 마지막 user 메시지 이후 현재 assistant 턴에서 Claude가 '직접' Edit 또는 Write 도구를 호출한 적이 있는지만 확인하세요. 이전 턴들의 편집 이력은 절대 포함하지 마세요. 판정 결과에 따라 다음 중 하나만 수행하세요: (1) 이번 턴에 Edit/Write 호출이 전혀 없었다면(단순 질문·설명·조회·chat 응답 등) 아무 보고도 하지 말고 즉시 종료를 허용하세요. (2) 이번 턴 편집 파일이 README.md 자체뿐이거나 sync-readme 스킬 실행의 결과물뿐이라면 실행하지 말고 즉시 종료를 허용하세요. (3) 그 외에 이번 턴에 실제 코드·문서 편집이 있다면, 프로젝트 루트 README.md와 관련 하위 README.md가 그 변경을 반영하는지 점검하고, 반영되지 않았다면 skill-executor 서브에이전트로 sync-readme 스킬을 실행하세요. 이미 이번 턴에 sync-readme 가 실행되었다면 종료를 허용하세요."
          }
        ]
      }
    ]
  }
}
```

| 장점 | 단점 |
|------|------|
| 중간 편집 흐름을 끊지 않음 | 종료 직전에만 검사되어 회차 중 확인 불가 |
| 턴당 한 번만 실행되어 효율적 | Claude 가 종료를 시도해야 발동 |

### 트리거 대상 상황

- 코드 또는 기능 구현 완료
- 파일 또는 디렉토리 추가·삭제
- 기능 동작 변경
- 에이전트·스킬·도구 추가 또는 수정
- 설치·설정 방법 변경
