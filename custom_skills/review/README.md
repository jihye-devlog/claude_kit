# review

작업 완료 후 변경된 코드와 파일을 자체 검토하고 문제를 수정한 뒤 사용자에게 보고하는 스킬

## 설치 방법

```bash
cp review/review.md ~/.claude/commands/review.md
```

Claude Code 재시작 후 `/review` 로 수동 실행 가능하다.

자동 실행을 위해 `~/.claude/settings.json` 의 `Stop` 훅에 아래 항목을 추가한다. `Stop` 훅은 Claude 가 작업을 종료하려 할 때 한 번만 발동하므로 중간 편집 흐름을 끊지 않는다.

```json
{
  "hooks": [
    {
      "type": "prompt",
      "prompt": "이번 턴 Edit/Write 없거나 README/sync-readme 산출물뿐이면 종료. 그 외 코드·문서 편집 있고 review 미실행이면 review 스킬 실행."
    }
  ]
}
```

## 사용 방법

자동 실행: Claude 가 작업을 종료하려 할 때 Stop 훅이 발동해 변경 파일을 자체 검토한다. 편집 중간에는 흐름을 끊지 않는다.
수동 실행: `/review` 슬래시 커맨드로 직접 실행할 수 있다.

## 동작 방식

1. 현재 대화에서 수정한 파일 목록을 수집한다
2. 각 파일을 다시 읽고 정확성, 누락, 중복, 일관성, 오류 가능성, 불필요한 코드를 점검한다
3. 발견된 문제는 즉시 수정한다
4. 수정 사항이 있으면 간략히 보고하고, 없으면 별도 보고 없이 원래 결과를 전달한다
