# claude-local - 無料でAIコーディング

Macにコマンドをコピペするだけで、AIがコードを書いてくれる環境が手に入ります。

ネットワーク不要・完全無料。Apple Silicon Mac + Ollama でローカルLLMを動かし、
Claude Code のインターフェースでエージェントコーディングを体験できます。

## インストール (3ステップ)

### 1. ターミナルを開く

Spotlight検索（`Cmd + Space`）で「ターミナル」と入力してEnter

### 2. 以下をコピペしてEnter

```bash
curl -fsSL https://raw.githubusercontent.com/ochyai/claude-local/main/install.sh | bash
```

### 3. 完了! 新しいターミナルを開いて起動

```bash
claude-local
```

## 使い方

```bash
# 対話モード（チャットのようにAIと会話しながらコーディング）
claude-local

# ワンショット（1回だけ質問）
claude-local -p "Pythonでじゃんけんゲーム作って"

# ネットワーク自動判定（ネットがあればClaude API、なければローカル）
claude-local --auto

# モデルを手動指定
claude-local --model qwen3:8b
```

## 対応環境

| 環境 | メモリ | モデル | 備考 |
|------|--------|--------|------|
| Apple Silicon Mac (M1以降) | 32GB以上 | qwen3-coder:30b | **推奨** コーディング最強 |
| Apple Silicon Mac (M1以降) | 16GB | qwen3:8b | 十分実用的 |
| Apple Silicon Mac (M1以降) | 8GB | qwen3:1.7b | 最低限動作 |
| Intel Mac | 16GB以上 | qwen3:8b | 動作するが遅め |
| Linux (x86_64/arm64) | 16GB以上 | qwen3:8b | NVIDIA GPU推奨 |

## トラブルシューティング

### "ollama が起動できませんでした"

```bash
# Ollama を手動で起動
open -a Ollama        # macOS
ollama serve          # Linux
```

### "モデルが見つかりません"

```bash
# モデルを手動ダウンロード
ollama pull qwen3:8b
```

### "claude: command not found"

```bash
# Claude Code CLI を再インストール
npm install -g @anthropic-ai/claude-code
```

### "プロキシが起動できませんでした"

```bash
# Python3 が入っているか確認
python3 --version

# ログを確認
cat /tmp/claude-local-proxy.log
```

### モデルを変更したい

```bash
# 設定ファイルを編集
nano ~/.config/claude-local/config
# MODEL="qwen3:8b" を変更

# または起動時に指定
claude-local --model qwen3-coder:30b
```

## 仕組み

```
ユーザー
  ↓
claude-local (起動スクリプト)
  ↓
Claude Code CLI (UIとエージェント機能)
  ↓
anthropic-ollama-proxy (API変換)
  ↓
Ollama (ローカルLLM実行)
  ↓
qwen3-coder:30b (AIモデル)
```

- **Claude Code CLI**: Anthropic公式のCLIツール。ファイル編集、コマンド実行などのエージェント機能を提供
- **anthropic-ollama-proxy**: Anthropic Messages APIをOllama互換のOpenAI APIに変換するプロキシ
- **Ollama**: ローカルでLLMを実行するランタイム。Apple Silicon のGPU (Metal) を活用
- **qwen3-coder**: Alibabaが開発したコーディング特化のLLM

## 注意事項

- ローカルLLM は Claude API と比べると精度が劣ります
- 初回のモデルダウンロードには時間がかかります（数GB〜20GB）
- `--dangerously-skip-permissions` を使用しているため、ローカル専用で使用してください
- ネットワーク接続がある場合は `claude-local --auto` で自動的にClaude APIを使用できます

## ライセンス

MIT
