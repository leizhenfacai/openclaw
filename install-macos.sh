#!/usr/bin/env bash
set -euo pipefail

log(){ echo "[openclaw-macos] $*"; }

if ! command -v brew >/dev/null 2>&1; then
  echo "请先安装 Homebrew: https://brew.sh/" >&2
  exit 1
fi

if ! command -v node >/dev/null 2>&1; then
  log "未检测到 Node.js，安装 Node 22..."
  brew install node@22
  echo 'export PATH="/opt/homebrew/opt/node@22/bin:$PATH"' >> ~/.zshrc || true
  export PATH="/opt/homebrew/opt/node@22/bin:$PATH"
fi

log "Node: $(node -v 2>/dev/null || echo missing)"
log "NPM : $(npm -v 2>/dev/null || echo missing)"

log "安装 OpenClaw CLI..."
curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard

if ! command -v openclaw >/dev/null 2>&1; then
  echo "openclaw 未进入 PATH，请重新打开终端后再执行 onboard" >&2
  exit 1
fi

log "执行 onboarding（可交互）..."
openclaw onboard --install-daemon

log "完成。下一步：openclaw dashboard"
