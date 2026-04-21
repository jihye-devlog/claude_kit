# commit

현재 레포의 .claude/COMMIT_CONVENTION.md 규칙을 읽어 변경사항을 규칙에 맞게 커밋한다. 파일이 없으면 기본 형식 사용.

## 설치 방법

```bash
cp custom_skills/commit/commit.md ~/.claude/commands/commit.md
```

Claude Code 재시작 후 `/commit` 으로 사용 가능합니다.

## 사용 방법

```
/commit
```

## 동작 방식

1. **커밋 규칙 파악**: 프로젝트 루트의 `.claude/COMMIT_CONVENTION.md` 파일을 읽어 커밋 규칙을 확인합니다. 파일이 없으면 기본 형식 `[CATEGORY] 설명` 을 사용합니다.

2. **변경사항 파악**: `git status`, `git diff HEAD`, `git log --oneline -5` 를 실행해 변경 내용과 최근 커밋 스타일을 확인합니다.

3. **커밋 메시지 작성**: 파악한 규칙에 맞게 커밋 메시지를 작성합니다. 변경된 파일의 카테고리를 파악해 prefix를 결정하고, 여러 카테고리에 걸친 변경이면 복수 prefix를 사용합니다.

4. **커밋 실행**: 커밋 메시지를 사용자에게 먼저 보여주고 확인 후 `git add` 와 `git commit` 을 실행합니다.
