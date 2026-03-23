# add-tool

스킬, 에이전트, 스크립트 파일 경로를 알려주면 현재 레포에 디렉토리와 README 를 자동으로 생성하는 스킬입니다.

## 설치 방법

스킬 파일을 글로벌 스킬 디렉토리에 복사합니다.

```bash
cp add-tool/add-tool.md ~/.claude/skills/add-tool.md
```

Claude Code를 재시작하면 `/add-tool` 슬래시 커맨드로 사용할 수 있습니다.

## 사용 방법

```
/add-tool <명령어> <파일경로>
```

예시:

```
/add-tool save-progress ~/.claude/skills/save-progress.md
/add-tool statusline ~/.claude/statusline.sh
```

## 동작 방식

| 단계 | 내용 |
|------|------|
| 1 파일 읽기 | 제공된 경로의 파일을 읽어 도구 유형(스킬/에이전트/스크립트)과 기능을 파악 |
| 2 디렉토리 생성 | 현재 레포 루트에 명령어 이름으로 디렉토리 생성 |
| 3 파일 복사 | 도구 파일을 해당 디렉토리에 복사 |
| 4 README 작성 | 도구 유형에 맞는 설치 방법과 사용 방법이 담긴 README.md 작성 |
| 5 완료 보고 | 생성된 파일 목록과 글로벌 설치 명령어 출력 |

## 도구 유형별 설치 경로

| 유형 | 글로벌 설치 경로 | 활성화 방법 |
|------|----------------|-------------|
| 스킬 (`.md`) | `~/.claude/skills/` | Claude Code 재시작 후 `/<명령어>` 로 사용 |
| 에이전트 (`.md`) | `~/.claude/agents/` | Claude Code 재시작 후 에이전트로 사용 |
| 스크립트 (`.sh` 등) | `~/.claude/` | `settings.json` 에 추가 설정 후 사용 |
