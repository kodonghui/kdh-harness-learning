#!/bin/bash
# start-study.sh — kdh-harness-learning 하네스 공부 세션 부트스트랩
# Boot 시 tmux send-keys 로 /resume-session 슬래시를 직접 주입한다.
set -u

SESSION="study"
# 기본값: 이 스크립트가 있는 리포 루트. KDH_STUDY_DIR 로 오버라이드 가능.
CWD="${KDH_STUDY_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
WRAPPER="$HOME/.local/bin/claude-wrapper"

if [ ! -x "$WRAPPER" ]; then
  echo "ERROR: claude-wrapper 없음: $WRAPPER" >&2
  echo "  kdh-conductor/bootstrap/wsl-setup.sh 먼저 실행" >&2
  exit 1
fi

if tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "이미 존재. attach: tmux attach -t $SESSION"
  exit 0
fi

if [ ! -d "$CWD" ]; then
  echo "ERROR: study CWD 없음: $CWD" >&2
  echo "  KDH_STUDY_DIR 환경변수로 경로 오버라이드 가능" >&2
  exit 1
fi

echo "tmux study 세션 시작 (CWD=$CWD)..."
tmux new -s "$SESSION" -d -c "$CWD" "$WRAPPER"

# REPL readiness probe + /resume-session 자동 주입
for _ in $(seq 1 30); do
  if tmux capture-pane -t "$SESSION" -p -S -20 2>/dev/null | grep -qE '❯|> '; then
    sleep 1
    tmux send-keys -t "$SESSION" "/resume-session" Enter
    echo "[OK] Study READY + /resume-session 주입됨"
    exit 0
  fi
  sleep 1
done

echo "[WARN] READY 감지 실패. 수동: tmux attach -t $SESSION" >&2
exit 2
