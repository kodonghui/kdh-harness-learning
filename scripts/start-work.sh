#!/bin/bash
# start-work.sh — work(독파모) 세션 부트스트랩
# 독파모는 별도 폴더. KDH_WORK_DIR 로 경로 지정 (기본: 셀렉트스타 업무/독파모).
# Boot 시 tmux send-keys 로 /resume-session 슬래시를 직접 주입한다.
set -u

SESSION="work"
CWD="${KDH_WORK_DIR:-/mnt/c/Users/USER/Desktop/셀렉트스타 업무/독파모}"
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
  echo "ERROR: work CWD 없음: $CWD" >&2
  echo "  KDH_WORK_DIR 환경변수로 경로 오버라이드 (독파모 폴더)" >&2
  exit 1
fi

echo "tmux work 세션 시작 (CWD=$CWD)..."
tmux new -s "$SESSION" -d -c "$CWD" "$WRAPPER"

# REPL readiness probe + /resume-session 자동 주입
for _ in $(seq 1 30); do
  if tmux capture-pane -t "$SESSION" -p -S -20 2>/dev/null | grep -qE '❯|> '; then
    sleep 1
    tmux send-keys -t "$SESSION" "/resume-session" Enter
    echo "[OK] Work READY + /resume-session 주입됨"
    exit 0
  fi
  sleep 1
done

echo "[WARN] READY 감지 실패. 수동: tmux attach -t $SESSION" >&2
exit 2
