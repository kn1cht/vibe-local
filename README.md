# 🤖⚡ Ｖ Ｉ Ｂ Ｅ  Ｌ Ｏ Ｃ Ａ Ｌ ⚡🤖

```
    ██╗   ██╗██╗██████╗ ███████╗
    ██║   ██║██║██╔══██╗██╔════╝
    ██║   ██║██║██████╔╝█████╗
    ╚██╗ ██╔╝██║██╔══██╗██╔══╝
     ╚████╔╝ ██║██████╔╝███████╗
      ╚═══╝  ╚═╝╚═════╝ ╚══════╝
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

**🇯🇵** オフラインのワークショップでAIエージェントを使って学習者をサポートしたり、有料プランに未加入の学生がエージェントコーディングを練習したり、ネットワークのない環境で自然言語を使ってターミナル操作を学んだり――そんな場面を想定した、非営利の研究・教育目的のユーティリティツールです。

**🇺🇸** Built for offline workshops where instructors support learners with AI agents, for students without paid plans who want to practice agent coding, and for beginners learning terminal operations through natural language — a non-profit research and education utility.

**🇨🇳** 面向离线工作坊中使用AI代理辅助学习者、未订阅付费计划的学生练习代理编程、以及初学者通过自然语言学习终端操作等场景，这是一个非营利性的研究与教育实用工具。

---

## 🇯🇵 日本語 | [🇺🇸 English](#-english) | [🇨🇳 中文](#-中文)

### これは何？

MacにコマンドをコピペするだけでAIがコードを書いてくれる環境。
ネットワーク不要・完全無料。Ollama + ローカルLLM で Claude Code のインターフェースをそのまま使える。

### インストール (3ステップ)

**1.** ターミナルを開く（Spotlight `Cmd+Space` → "ターミナル"で検索）

**2.** 以下をコピペしてEnter:

```bash
curl -fsSL https://raw.githubusercontent.com/ochyai/vibe-local/main/install.sh | bash
```

**3.** 新しいターミナルを開いて起動:

```bash
vibe-local
```

### 使い方

```bash
# 対話モード（AIと会話しながらコーディング）
vibe-local

# ワンショット（1回だけ質問）
vibe-local -p "Pythonでじゃんけんゲーム作って"

# ネットワーク自動判定（ネットがあればClaude API、なければローカル）
vibe-local --auto

# モデルを手動指定
vibe-local --model qwen3:8b
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
nano ~/.config/vibe-local/config
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
curl -fsSL https://raw.githubusercontent.com/ochyai/vibe-local/main/install.sh | bash
```

**3.** Open a new terminal and run:

```bash
vibe-local
```

### Usage

```bash
# Interactive mode (chat with AI while coding)
vibe-local

# One-shot (ask once)
vibe-local -p "Create a snake game in Python"

# Auto-detect network (uses Claude API if online, local if offline)
vibe-local --auto

# Specify model manually
vibe-local --model qwen3:8b
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
nano ~/.config/vibe-local/config
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
curl -fsSL https://raw.githubusercontent.com/ochyai/vibe-local/main/install.sh | bash
```

**3.** 打开新终端并运行：

```bash
vibe-local
```

### 使用方法

```bash
# 交互模式（与AI对话编程）
vibe-local

# 单次执行（只问一次）
vibe-local -p "用Python写一个贪吃蛇游戏"

# 自动检测网络（有网用Claude API，没网用本地）
vibe-local --auto

# 手动指定模型
vibe-local --model qwen3:8b
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
nano ~/.config/vibe-local/config
# 修改 MODEL="qwen3:8b"
```

</details>

---

## 🔧 Architecture

```
User
  ↓
vibe-local (launch script)
  ↓
Claude Code CLI (UI + agent features)
  ↓
anthropic-ollama-proxy (API translation)
  ↓
Ollama (local LLM runtime)
  ↓
qwen3-coder:30b (AI model)
```

## 🚨 Security / リスクについて / 安全须知

### 🇯🇵 日本語

> **このツールは自己責任でご利用ください。**

`vibe-local` は初回起動時に **ツール自動許可モード** (`--dangerously-skip-permissions`) を使うか確認します。
自動許可モードを選ぶと、AIがファイルの読み書き・コマンド実行・システム操作を **確認なしで** 実行します。

- ローカルLLMはクラウドAI (Claude) より **精度が低い** ため、意図しない操作が実行される可能性があります
- 重要なファイルがあるディレクトリでの使用は慎重に行ってください
- 心配な場合は起動時に `n` を選択すると、毎回確認を求める通常モードで動きます
- `-y` フラグで確認をスキップできますが、リスクを理解した上でご利用ください

```bash
vibe-local        # 毎回パーミッション確認あり（初回に選択）
vibe-local -y     # 確認スキップ（自動許可モード）
```

### 🇺🇸 English

> **Use this tool at your own risk.**

On first launch, `vibe-local` asks whether to enable **auto-approve mode** (`--dangerously-skip-permissions`).
In auto-approve mode, the AI can read/write files, execute commands, and modify your system **without asking**.

- Local LLMs are **less accurate** than cloud AI (Claude), so unintended actions may occur
- Be careful when using in directories with important files
- Choose `n` at the prompt to use normal mode (asks before each tool use)
- The `-y` flag skips the prompt — only use it if you understand the risks

```bash
vibe-local        # Permission check on first launch
vibe-local -y     # Skip check (auto-approve mode)
```

### 🇨🇳 中文

> **使用本工具风险自负。**

首次启动时，`vibe-local` 会询问是否启用 **工具自动批准模式** (`--dangerously-skip-permissions`)。
在自动批准模式下，AI可以读写文件、执行命令、修改系统，**无需确认**。

- 本地LLM的精度 **低于** 云端AI (Claude)，可能执行非预期操作
- 在包含重要文件的目录中使用时请谨慎
- 选择 `n` 将使用普通模式（每次工具使用前询问）
- `-y` 参数跳过确认 - 请在理解风险后使用

```bash
vibe-local        # 首次启动时确认权限
vibe-local -y     # 跳过确认（自动批准模式）
```

---

## ⚙️ Notes

- Local LLM accuracy is lower than Claude API
- First model download takes time (several GB to 20GB)
- Use `vibe-local --auto` to auto-switch to Claude API when online

---

## 📜 Disclaimer / 免責事項 / 免责声明

### 🇯🇵

> **本プロジェクトは Anthropic 社とは一切関係ありません。**
> Anthropic が提供・推奨・保証するものではありません。
> 「Claude」は Anthropic, PBC の商標です。本プロジェクトは非公式のコミュニティツールです。
>
> 本ツールは Claude Code CLI を非標準の方法で使用しています（ローカルプロキシ経由でサードパーティLLMに接続）。
> Claude Code CLI の利用規約に抵触する可能性があります。利用者は自身で利用規約を確認してください。
>
> 本ソフトウェアは現状有姿（AS IS）で提供され、明示的・暗示的を問わず、いかなる保証もありません。
> 使用によって生じたいかなる損害についても、著者は一切責任を負いません。
> **すべて自己責任でご利用ください。**

### 🇺🇸

> **This project is NOT affiliated with, endorsed by, or associated with Anthropic.**
> "Claude" is a trademark of Anthropic, PBC. This is an unofficial community tool.
>
> This tool uses the Claude Code CLI in a non-standard way (connecting to third-party LLMs via a local proxy).
> This may not comply with the Claude Code CLI's terms of service. Users should review the terms themselves.
>
> Third-party dependencies (Ollama, Qwen models, Node.js, etc.) have their own licenses and terms.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
> The authors are not liable for any damages arising from the use of this software.
> **Use entirely at your own risk.**

### 🇨🇳

> **本项目与 Anthropic 公司无任何关联。**
> 非 Anthropic 提供、推荐或担保。"Claude"是 Anthropic, PBC 的商标。本项目是非官方社区工具。
>
> 本工具以非标准方式使用 Claude Code CLI（通过本地代理连接第三方LLM）。
> 这可能不符合 Claude Code CLI 的服务条款。用户应自行确认相关条款。
>
> 第三方依赖（Ollama、Qwen模型、Node.js等）有各自的许可证和使用条款。
>
> 本软件按"原样"提供，不提供任何明示或暗示的保证。
> 作者不对因使用本软件而产生的任何损害承担责任。
> **使用本工具风险完全自负。**

## 📄 License

MIT
