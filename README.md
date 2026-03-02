# OpenClaw 一键安装（Linux / Mac / Windows）

给小白用户的快速部署包：拉代码后运行脚本即可。

## 目标

- 安装快
- 操作简单
- 支持 Linux / Mac / Windows
- 关键步骤有明确“用户需要手动做什么”预期

---

## 0) 安全要求（必须）

- **不要把任何 token / API Key 写进仓库**。
- 仅在用户本机环境变量或本地配置中填写。
- 发布前检查：
  - `git grep -n "api_key\|token\|secret\|password"`
  - 确认仓库里没有敏感信息。

---

## 1) 部署前检查清单

- 可联网（能访问 `openclaw.ai` / npm）
- 有管理员权限（sudo 或管理员 PowerShell）
- Node.js 22+（脚本会尝试安装）
- 客户知道自己要接的渠道（飞书 / Telegram / WhatsApp）并准备好对应凭据

---

## 2) 一键安装

### Linux

```bash
chmod +x install-linux.sh
./install-linux.sh
```

### Mac

```bash
chmod +x install-macos.sh
./install-macos.sh
```

### Windows（管理员 PowerShell）

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\install-windows.ps1
```

---

## 3) 安装后验证

```bash
openclaw status
openclaw gateway status
openclaw dashboard
```

如果 `openclaw` 命令不存在，重开终端再试。

---

## 4) 渠道接入（给客户预期）

> 说明：不同渠道都需要客户自己提供 token/凭据。

### 飞书（Feishu）

客户需要准备：
- App ID / App Secret
- 机器人事件订阅配置（消息事件）
- 回调地址（按 OpenClaw 控制台提示填写）

操作建议：
1. 运行 `openclaw configure`
2. 在配置向导中添加 Feishu 渠道
3. 填写 App 凭据
4. 在飞书开发者后台完成事件订阅与回调

### Telegram

客户需要准备：
- Bot Token（@BotFather）

操作建议：
1. `openclaw configure`
2. 添加 Telegram 渠道
3. 填入 Bot Token
4. 给 bot 发一条消息验证连通

### WhatsApp

客户需要准备：
- Provider 平台凭据（如 Cloud API token / phone number id / webhook secret 等）

操作建议：
1. `openclaw configure`
2. 添加 WhatsApp 渠道
3. 填写 provider 参数
4. 完成 webhook 验证与测试消息

---

## 5) 常见问题

1. **安装成功但命令不可用**
   - 重新开终端
   - 检查 PATH

2. **onboard 卡住**
   - 网络原因，重试
   - 先执行 `openclaw status` 看 gateway 是否在跑

3. **渠道收不到消息**
   - 凭据错误
   - webhook 未配置/未通过验证
   - 回调地址无法公网访问

---

## 6) 交付建议（给客户）

- 第一次部署完成后，留一份：
  - 渠道参数清单（不含明文密钥）
  - 回调地址清单
  - 验收截图（能收到消息、能回复）

这样后续迁移会非常快。
