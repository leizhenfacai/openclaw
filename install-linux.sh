#!/usr/bin/env bash
set -euo pipefail

log(){ echo "[openclaw-linux] $*"; }

if ! command -v curl >/dev/null 2>&1; then
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update -y && sudo apt-get install -y curl ca-certificates
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y curl ca-certificates
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y curl ca-certificates
  else
    echo "请先安装 curl" >&2; exit 1
  fi
fi

if ! command -v node >/dev/null 2>&1; then
  if command -v apt-get >/dev/null 2>&1; then
    log "未检测到 Node.js，安装 Node 22..."
    curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
    sudo apt-get install -y nodejs
  else
    echo "未检测到 Node.js，请先手动安装 Node.js 22+" >&2
    exit 1
  fi
fi

log "Node: $(node -v 2>/dev/null || echo missing)"
log "NPM : $(npm -v 2>/dev/null || echo missing)"

log "安装 OpenClaw CLI..."
curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard

if ! command -v openclaw >/dev/null 2>&1; then
  echo "openclaw 未进入 PATH，请重新打开终端后再执行 onboard" >&2
  exit 1
fi

log "执行 onboarding（可交互，适合小白）..."
openclaw onboard --install-daemon

log "完成。下一步：openclaw dashboard"
