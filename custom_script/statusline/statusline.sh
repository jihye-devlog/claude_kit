#!/usr/bin/env bash
# Claude Code status line script
# Receives JSON via stdin from Claude Code

input=$(cat)

# --- Parse JSON ---
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
tokens_used=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
tokens_total=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')

project_name=$(basename "$cwd")

git_branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git_branch=$(git -C "$cwd" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null \
    || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
fi

# --- Colors ---
RESET="\033[0m"
BOLD="\033[1m"
CYAN="\033[36m"
GREEN="\033[32m"
YELLOW="\033[33m"
MAGENTA="\033[35m"
RED="\033[31m"

# --- Helpers ---
progress_bar() {
  local pct=$1 filled=$(( $1 * 10 / 100 )) bar=""
  local empty=$(( 10 - filled ))
  for ((i=0; i<filled; i++)); do bar+="█"; done
  for ((i=0; i<empty; i++)); do bar+="░"; done
  echo "$bar"
}

usage_color() {
  local pct=$1
  if [ "$pct" -ge 80 ] 2>/dev/null; then echo "$RED"
  elif [ "$pct" -ge 50 ] 2>/dev/null; then echo "$YELLOW"
  else echo "$GREEN"
  fi
}

fmt_tokens() {
  local n=$1
  if [ "$n" -ge 1000000 ] 2>/dev/null; then
    echo "$n" | awk '{printf "%.0fM", $1/1000000}'
  elif [ "$n" -ge 1000 ] 2>/dev/null; then
    echo "$n" | awk '{printf "%.0fK", $1/1000}'
  else
    echo "$n"
  fi
}

# --- Build parts ---
parts=()

# 1. Model
[ -n "$model" ] && parts+=("$(printf "${MAGENTA}%s${RESET}" "$model")")

# 2. Context: progress bar + percentage + actual tokens used / max + conversation tokens
if [ -n "$used_pct" ]; then
  pct_int=${used_pct%.*}
  color=$(usage_color "$pct_int")
  ctx_str="$(progress_bar "$pct_int") ${used_pct}%"
  if [ -n "$tokens_total" ] && [ "$tokens_total" -gt 0 ] 2>/dev/null; then
    actual_used=$(( pct_int * tokens_total / 100 ))
    ctx_str+=" $(fmt_tokens "$actual_used")/$(fmt_tokens "$tokens_total")"
  fi
  if [ -n "$tokens_used" ] && [ "$tokens_used" -gt 0 ] 2>/dev/null; then
    ctx_str+=" +$(fmt_tokens "$tokens_used")"
  fi
  parts+=("$(printf "${color}%s${RESET}" "$ctx_str")")
fi

# 4. Git branch
[ -n "$git_branch" ] && parts+=("$(printf "${GREEN}(%s)${RESET}" "$git_branch")")

# 5. Project name
[ -n "$project_name" ] && parts+=("$(printf "${CYAN}%s${RESET}" "$project_name")")

# 6. Vim mode
[ -n "$vim_mode" ] && parts+=("$(printf "${BOLD}[%s]${RESET}" "$vim_mode")")

# --- Output ---
sep=" | "
result=""
for part in "${parts[@]}"; do
  [ -z "$result" ] && result="$part" || result="$result$sep$part"
done

printf "%b\n" "$result"
