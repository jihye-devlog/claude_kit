#!/usr/bin/env bash
# Claude Code notification script
# Detects OS and sends a native system notification

TITLE="${1:-Claude Code}"
MESSAGE="${2:-알림}"

OS=$(uname -s 2>/dev/null)

case "$OS" in
  Darwin)
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"Glass\"" 2>/dev/null
    ;;
  Linux)
    if command -v notify-send &>/dev/null; then
      notify-send "$TITLE" "$MESSAGE" 2>/dev/null
    fi
    ;;
  MINGW*|CYGWIN*|MSYS*)
    powershell.exe -Command "
      Add-Type -AssemblyName System.Windows.Forms
      \$n = New-Object System.Windows.Forms.NotifyIcon
      \$n.Icon = [System.Drawing.SystemIcons]::Information
      \$n.BalloonTipTitle = '$TITLE'
      \$n.BalloonTipText = '$MESSAGE'
      \$n.Visible = \$true
      \$n.ShowBalloonTip(5000)
      Start-Sleep -s 2
      \$n.Dispose()
    " 2>/dev/null
    ;;
esac
