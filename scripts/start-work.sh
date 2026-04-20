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

# Auto-update Claude Code CLI to latest (CEO 지시 2026-04-20). 30s timeout — 네트워크 장애
# 또는 npm 레지스트리 이슈 시 세션 시작 차단하지 않도록 best-effort.
# SKIP_CLAUDE_UPDATE=1 로 스킵 가능.
if [ "${SKIP_CLAUDE_UPDATE:-0}" != "1" ] && command -v npm >/dev/null 2>&1; then
  echo "Claude Code CLI 최신 버전 업데이트 중... (SKIP_CLAUDE_UPDATE=1 로 건너뜀 가능)"
  timeout 30 npm install -g @anthropic-ai/claude-code@latest 2>&1 | tail -3 || \
    echo "[WARN] claude 업데이트 실패/타임아웃. 기존 버전으로 계속 진행."
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
