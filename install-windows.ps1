#Requires -RunAsAdministrator
$ErrorActionPreference = 'Stop'

Write-Host "[openclaw-windows] 检查 Node.js..."
$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
  Write-Host "未检测到 Node.js，尝试使用 winget 安装 Node.js LTS..."
  winget install OpenJS.NodeJS.LTS --accept-source-agreements --accept-package-agreements
}

Write-Host "Node version:"; node -v
Write-Host "NPM version:"; npm -v

Write-Host "安装 OpenClaw CLI..."
npm install -g openclaw@latest

Write-Host "执行 onboarding（可交互）..."
openclaw onboard --install-daemon

Write-Host "完成。下一步运行: openclaw dashboard"
