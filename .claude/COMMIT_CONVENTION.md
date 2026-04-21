# 커밋 메시지 규칙

## 형식

```
[CATEGORY] 설명
[CATEGORY1][CATEGORY2] 설명
[CATEGORY][TARGET] 설명
```

- 설명은 한글 또는 영어 모두 허용
- 설명은 간결하게 변경 내용을 요약

## 카테고리

| 카테고리 | 설명 |
| --- | --- |
| SKILLS | 스킬 파일 추가·수정 |
| AGENTS | 에이전트 파일 추가·수정 |
| SCRIPT | 스크립트 추가·수정 |
| STUDY | 학습 자료 추가·수정 |
| CLAUDE | CLAUDE.md 수정 |
| README | README 수정 |
| PLUGINS | 플러그인 관련 변경 |

## 서브 타겟

SKILLS, AGENTS 카테고리는 두 번째 prefix 로 대상 이름을 명시할 수 있다.

```
[SKILLS][COMMIT] push 단계 추가
[AGENTS][PLANNER] 간략화
```

## 예시

```
[SKILLS] commit 스킬 추가
[SKILLS][COMMIT] push 단계 추가
[AGENTS][PLANNER] 간략화
[SKILLS][REVIEW][SYNC-README] hook 조건 변경
[STUDY] tmux 단축키 정리
[CLAUDE] 세션 시작 규칙 추가
```
