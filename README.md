# 🤖⚡ ＣＬＡＵＤＥ  ＬＯＣＡＬ ⚡🤖

```
     ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗
    ██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝
    ██║     ██║     ███████║██║   ██║██║  ██║█████╗
    ██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝
    ╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗
     ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝
              ██╗      ██████╗  ██████╗ █████╗ ██╗
              ██║     ██╔═══██╗██╔════╝██╔══██╗██║
              ██║     ██║   ██║██║     ███████║██║
              ██║     ██║   ██║██║     ██╔══██║██║
              ███████╗╚██████╔╝╚██████╗██║  ██║███████╗
              ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝
```

> 🌴✨ **Free AI Coding Environment** ✨🌴
>
> No network. No cost. Local LLM agent coding.

---

## 🇯🇵 日本語 | [🇺🇸 English](#-english) | [🇨🇳 中文](#-中文)

### これは何？

MacにコマンドをコピペするだけでAIがコードを書いてくれる環境。
ネットワーク不要・完全無料。Ollama + ローカルLLM で Claude Code のインターフェースをそのまま使える。

### インストール (3ステップ)

**1.** ターミナルを開く（Spotlight `Cmd+Space` → "ターミナル"で検索）

**2.** 以下をコピペしてEnter:

```bash
curl -fsSL https://raw.githubusercontent.com/ochyai/claude-local/main/install.sh | bash
```

**3.** 新しいターミナルを開いて起動:

```bash
claude-local
```

### 使い方

```bash
# 対話モード（AIと会話しながらコーディング）
claude-local

# ワンショット（1回だけ質問）
claude-local -p "Pythonでじゃんけんゲーム作って"

# ネットワーク自動判定（ネットがあればClaude API、なければローカル）
claude-local --auto

# モデルを手動指定
claude-local --model qwen3:8b
```

### 対応環境

| 環境 | メモリ | モデル | 備考 |
|------|--------|--------|------|
| Apple Silicon Mac (M1以降) | 32GB+ | qwen3-coder:30b | 🏆 **推奨** |
| Apple Silicon Mac (M1以降) | 16GB | qwen3:8b | ⭐ 十分実用的 |
| Apple Silicon Mac (M1以降) | 8GB | qwen3:1.7b | 最低限動作 |
| Intel Mac | 16GB+ | qwen3:8b | 動作するが遅め |
| Linux (x86_64/arm64) | 16GB+ | qwen3:8b | NVIDIA GPU推奨 |

### トラブルシューティング

<details>
<summary>💡 よくある問題と解決法</summary>

**"ollama が起動できませんでした"**
```bash
open -a Ollama        # macOS
ollama serve          # Linux
```

**"モデルが見つかりません"**
```bash
ollama pull qwen3:8b
```

**"claude: command not found"**
```bash
npm install -g @anthropic-ai/claude-code
```

**モデルを変更したい**
```bash
nano ~/.config/claude-local/config
# MODEL="qwen3:8b" を変更
```

</details>

---

## 🇺🇸 English

### What is this?

A free AI coding environment you can set up with a single command on your Mac.
No network required. Completely free. Uses Ollama + local LLM with the Claude Code interface.

### Install (3 steps)

**1.** Open Terminal (Spotlight `Cmd+Space` → search "Terminal")

**2.** Paste and hit Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/ochyai/claude-local/main/install.sh | bash
```

**3.** Open a new terminal and run:

```bash
claude-local
```

### Usage

```bash
# Interactive mode (chat with AI while coding)
claude-local

# One-shot (ask once)
claude-local -p "Create a snake game in Python"

# Auto-detect network (uses Claude API if online, local if offline)
claude-local --auto

# Specify model manually
claude-local --model qwen3:8b
```

### Supported Environments

| Environment | RAM | Model | Notes |
|-------------|-----|-------|-------|
| Apple Silicon Mac (M1+) | 32GB+ | qwen3-coder:30b | 🏆 **Recommended** |
| Apple Silicon Mac (M1+) | 16GB | qwen3:8b | ⭐ Very capable |
| Apple Silicon Mac (M1+) | 8GB | qwen3:1.7b | Minimum viable |
| Intel Mac | 16GB+ | qwen3:8b | Works but slower |
| Linux (x86_64/arm64) | 16GB+ | qwen3:8b | NVIDIA GPU recommended |

### Troubleshooting

<details>
<summary>💡 Common issues and solutions</summary>

**"ollama failed to start"**
```bash
open -a Ollama        # macOS
ollama serve          # Linux
```

**"model not found"**
```bash
ollama pull qwen3:8b
```

**"claude: command not found"**
```bash
npm install -g @anthropic-ai/claude-code
```

**Change model**
```bash
nano ~/.config/claude-local/config
# Change MODEL="qwen3:8b"
```

</details>

---

## 🇨🇳 中文

### 这是什么？

在Mac上只需复制粘贴一个命令，AI就能帮你写代码。
无需网络，完全免费。使用 Ollama + 本地大语言模型，享受 Claude Code 的界面体验。

### 安装（3步）

**1.** 打开终端（Spotlight `Cmd+Space` → 搜索"终端"或"Terminal"）

**2.** 粘贴以下命令并按回车：

```bash
curl -fsSL https://raw.githubusercontent.com/ochyai/claude-local/main/install.sh | bash
```

**3.** 打开新终端并运行：

```bash
claude-local
```

### 使用方法

```bash
# 交互模式（与AI对话编程）
claude-local

# 单次执行（只问一次）
claude-local -p "用Python写一个贪吃蛇游戏"

# 自动检测网络（有网用Claude API，没网用本地）
claude-local --auto

# 手动指定模型
claude-local --model qwen3:8b
```

### 支持的环境

| 环境 | 内存 | 模型 | 备注 |
|------|------|------|------|
| Apple Silicon Mac (M1及以上) | 32GB+ | qwen3-coder:30b | 🏆 **推荐** |
| Apple Silicon Mac (M1及以上) | 16GB | qwen3:8b | ⭐ 足够实用 |
| Apple Silicon Mac (M1及以上) | 8GB | qwen3:1.7b | 最低限运行 |
| Intel Mac | 16GB+ | qwen3:8b | 可运行但较慢 |
| Linux (x86_64/arm64) | 16GB+ | qwen3:8b | 推荐NVIDIA GPU |

### 故障排除

<details>
<summary>💡 常见问题及解决方法</summary>

**"ollama 无法启动"**
```bash
open -a Ollama        # macOS
ollama serve          # Linux
```

**"未找到模型"**
```bash
ollama pull qwen3:8b
```

**"claude: command not found"**
```bash
npm install -g @anthropic-ai/claude-code
```

**更换模型**
```bash
nano ~/.config/claude-local/config
# 修改 MODEL="qwen3:8b"
```

</details>

---

## 🔧 Architecture

```
User
  ↓
claude-local (launch script)
  ↓
Claude Code CLI (UI + agent features)
  ↓
anthropic-ollama-proxy (API translation)
  ↓
Ollama (local LLM runtime)
  ↓
qwen3-coder:30b (AI model)
```

## ⚠️ Notes

- Local LLM accuracy is lower than Claude API
- First model download takes time (several GB to 20GB)
- Uses `--dangerously-skip-permissions` — for local use only
- Use `claude-local --auto` to auto-switch to Claude API when online

## 📄 License

MIT
