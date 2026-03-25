#!/bin/bash
# README 외 파일 변경이 있으면 sync-readme 트리거 프롬프트 출력

cd "$(git rev-parse --show-toplevel 2>/dev/null)" || exit 0

# git 변경 파일 중 README.md 가 아닌 파일이 있는지 확인
changed=$(git status --porcelain 2>/dev/null | grep -v 'README.md' | grep -v '^\?\?' | head -1)
untracked=$(git status --porcelain 2>/dev/null | grep '^\?\?' | grep -v 'README.md' | head -1)

if [ -n "$changed" ] || [ -n "$untracked" ]; then
  echo "[sync-readme] 레포에 README 에 반영되지 않은 변경 사항이 감지되었습니다. README 업데이트가 필요한지 확인하고, 필요하다면 /sync-readme 를 실행하세요."
fi
