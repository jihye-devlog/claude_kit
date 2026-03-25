---
name: lessons
description: Record mistakes Claude makes and prevent repetition. ALWAYS invoke this skill when: (1) the user corrects Claude's output or approach ("아니야", "틀렸어", "잘못됐어", "그게 아니라", "다시", "수정해"), (2) a command, build, or file operation fails due to Claude's error, (3) Claude realizes mid-task that a previous step was wrong, or (4) the user runs /lessons. At session start, proactively read ~/.claude/mistakes.md if it exists, and avoid repeating any recorded mistakes throughout the session.
---

## 목적

Claude가 저지른 실수를 `~/.claude/mistakes.md`에 누적 기록하고, 이후 세션에서 동일한 실수를 반복하지 않는다.

## 실수 감지 기준

아래 상황 중 하나라도 해당되면 즉시 기록한다.

| 상황 | 판단 기준 |
|------|-----------|
| 사용자 교정 | "아니야", "틀렸어", "그게 아니라", "다시", "수정해" 등 정정 발언 |
| 명령/빌드 실패 | Claude가 작성한 코드나 명령이 에러를 유발한 경우 |
| 자기 인식 | 작업 도중 이전 단계가 잘못됐음을 스스로 발견한 경우 |
| 슬래시 커맨드 | 사용자가 `/lessons`를 실행한 경우 (현재까지의 실수 요약 출력) |

## 기록 절차

1. `~/.claude/mistakes.md`가 없으면 아래 헤더로 새로 생성한다.

```
# Claude Lessons

Claude가 반복하지 말아야 할 실수 기록.
```

2. 파일 끝에 아래 형식으로 항목을 추가한다.
3. 사용자에게 한 줄로 기록 완료를 알린다.

## 기록 형식

```
## YYYY-MM-DD | <컨텍스트 한 줄 요약>

실수: <무엇을 잘못했는지>
교정: <올바른 방법>
파일/기능: <관련 파일 경로 또는 기능명, 없으면 생략>
```

예시:

```
## 2026-03-25 | add-tool README 설치 경로

실수: 스킬 설치 경로를 ~/.claude/skills/ 로 안내함
교정: 사용자 추가 스킬은 ~/.claude/commands/ 에 설치해야 함
파일/기능: add-tool/README.md, add-tool/add-tool.md
```

## 세션 시작 시 동작

세션 초반에 `~/.claude/mistakes.md`가 존재하면 반드시 읽는다. 현재 작업과 관련된 과거 실수 항목이 있으면 같은 실수를 반복하지 않도록 주의한다. 파일이 없으면 넘어간다.

## /lessons 커맨드 동작

사용자가 `/lessons`를 실행하면:

1. `~/.claude/mistakes.md` 전체를 읽는다.
2. 실수 목록을 날짜순으로 요약해서 보여준다.
3. 반복되는 패턴이 있으면 강조한다.
4. 파일이 없으면 "아직 기록된 실수가 없습니다"를 출력한다.
