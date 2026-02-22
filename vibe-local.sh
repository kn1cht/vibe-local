#!/bin/bash
# vibe-local.sh
# ローカルLLM (Ollama) で Claude Code を起動するスクリプト
# Anthropic API → Ollama 変換プロキシを自動管理
#
# NOTE: This project is NOT affiliated with, endorsed by, or associated with Anthropic.
#
# 使い方:
#   vibe-local                    # インタラクティブモード
#   vibe-local -p "質問"          # ワンショット
#   vibe-local --auto             # ネットワーク状況で自動判定
#   vibe-local --model qwen3:8b   # モデル手動指定
#   vibe-local -y                 # パーミッション確認スキップ (自己責任)

set -euo pipefail

# --- ディレクトリ初期化 ---
STATE_DIR="${HOME}/.local/state/vibe-local"
mkdir -p "$STATE_DIR"
chmod 700 "$STATE_DIR"

# --- 設定読み込み (安全なパーサー) ---
CONFIG_FILE="${HOME}/.config/vibe-local/config"
PROXY_LIB_DIR="${HOME}/.local/lib/vibe-local"
PROXY_SCRIPT="${PROXY_LIB_DIR}/anthropic-ollama-proxy.py"

# デフォルト値
MODEL=""
OLLAMA_HOST="http://localhost:11434"
PROXY_PORT=8082

# [C1 fix] source ではなく grep で既知キーのみ安全に読む
if [ -f "$CONFIG_FILE" ]; then
    _val() { grep -E "^${1}=" "$CONFIG_FILE" 2>/dev/null | head -1 | sed "s/^${1}=[\"']\{0,1\}\([^\"']*\)[\"']\{0,1\}/\1/" || true; }
    _m="$(_val MODEL)"
    _p="$(_val PROXY_PORT)"
    _h="$(_val OLLAMA_HOST)"
    [ -n "$_m" ] && MODEL="$_m"
    [ -n "$_p" ] && PROXY_PORT="$_p"
    [ -n "$_h" ] && OLLAMA_HOST="$_h"
    unset _val _m _p _h
fi

# config が無い場合、RAM からモデルを自動判定
if [ -z "$MODEL" ]; then
    if [[ "$(uname)" == "Darwin" ]]; then
        RAM_GB=$(( $(sysctl -n hw.memsize) / 1073741824 ))
    else
        RAM_GB=$(( $(grep MemTotal /proc/meminfo | awk '{print $2}') / 1048576 ))
    fi

    if [ "$RAM_GB" -ge 32 ]; then
        MODEL="qwen3-coder:30b"
    elif [ "$RAM_GB" -ge 16 ]; then
        MODEL="qwen3:8b"
    elif [ "$RAM_GB" -ge 8 ]; then
        MODEL="qwen3:1.7b"
    else
        echo "エラー: メモリが不足しています (${RAM_GB}GB)。最低8GB必要です。"
        exit 1
    fi
fi

PROXY_URL="http://127.0.0.1:${PROXY_PORT}"
# [M4 fix] PIDファイルをユーザープライベートディレクトリに
PROXY_PID_FILE="${STATE_DIR}/proxy.pid"

# --- 開発時フォールバック: プロキシスクリプトの探索 ---
if [ ! -f "$PROXY_SCRIPT" ]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    if [ -f "${SCRIPT_DIR}/anthropic-ollama-proxy.py" ]; then
        PROXY_SCRIPT="${SCRIPT_DIR}/anthropic-ollama-proxy.py"
    else
        echo "エラー: プロキシスクリプトが見つかりません"
        echo "  install.sh を実行するか、anthropic-ollama-proxy.py を同じディレクトリに置いてください"
        exit 1
    fi
fi

# --- ollama が起動しているか確認・起動 ---
ensure_ollama() {
    if curl -s --max-time 2 "$OLLAMA_HOST/api/tags" &>/dev/null; then
        return 0
    fi

    echo "🦙 ollama を起動中..."
    if [[ "$(uname)" == "Darwin" ]]; then
        open -a Ollama 2>/dev/null || ollama serve &>/dev/null &
    else
        ollama serve &>/dev/null &
    fi

    for i in $(seq 1 15); do
        sleep 2
        if curl -s --max-time 2 "$OLLAMA_HOST/api/tags" &>/dev/null; then
            echo "✅ ollama 起動完了"
            return 0
        fi
    done

    echo "❌ エラー: ollama が起動できませんでした"
    echo ""
    echo "対処法:"
    echo "  macOS: Ollama アプリを手動で起動してください"
    echo "  Linux: ollama serve を実行してください"
    return 1
}

# --- 変換プロキシの起動 ---
ensure_proxy() {
    if curl -s --max-time 1 "$PROXY_URL/" &>/dev/null; then
        return 0
    fi

    # 古いPIDファイルがあれば掃除
    if [ -f "$PROXY_PID_FILE" ]; then
        kill "$(cat "$PROXY_PID_FILE")" 2>/dev/null || true
        rm -f "$PROXY_PID_FILE"
    fi

    echo "🔄 Anthropic→Ollama 変換プロキシを起動中..."
    # [M5 fix] ログをプライベートディレクトリに
    python3 "$PROXY_SCRIPT" "$PROXY_PORT" &>"${STATE_DIR}/proxy.log" &
    local pid=$!
    echo "$pid" > "$PROXY_PID_FILE"

    for i in $(seq 1 10); do
        sleep 1
        if curl -s --max-time 1 "$PROXY_URL/" &>/dev/null; then
            echo "✅ 変換プロキシ起動完了 (PID: $pid, port: $PROXY_PORT)"
            return 0
        fi
    done

    echo "❌ エラー: 変換プロキシが起動できませんでした"
    echo ""
    echo "対処法:"
    echo "  python3 がインストールされているか確認: python3 --version"
    echo "  ログを確認: cat ${STATE_DIR}/proxy.log"
    return 1
}

# --- ネットワーク接続チェック ---
check_network() {
    curl -s --max-time 3 https://api.anthropic.com/ &>/dev/null
}

# --- クリーンアップ ---
cleanup() {
    if [ -f "$PROXY_PID_FILE" ]; then
        kill "$(cat "$PROXY_PID_FILE")" 2>/dev/null || true
        rm -f "$PROXY_PID_FILE"
    fi
}
trap cleanup EXIT

# --- 引数パース ---
AUTO_MODE=0
YES_FLAG=0
EXTRA_ARGS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --auto)
            AUTO_MODE=1
            shift
            ;;
        --model)
            MODEL="$2"
            shift 2
            ;;
        -y|--yes)
            YES_FLAG=1
            shift
            ;;
        *)
            EXTRA_ARGS+=("$1")
            shift
            ;;
    esac
done

# --- 自動判定モード ---
if [ "$AUTO_MODE" -eq 1 ]; then
    if check_network; then
        echo "🌐 ネットワーク接続あり → 通常の Claude Code を起動"
        exec claude ${EXTRA_ARGS[@]+"${EXTRA_ARGS[@]}"}
    else
        echo "📡 ネットワーク接続なし → ローカルモード ($MODEL)"
    fi
fi

# --- ローカルモードで起動 ---
ensure_ollama || exit 1

# モデルがロード済みか確認
if ! curl -s "$OLLAMA_HOST/api/tags" | grep -q "$MODEL"; then
    echo "❌ エラー: モデル $MODEL が見つかりません"
    echo ""
    echo "対処法:"
    echo "  ollama pull $MODEL"
    echo ""
    echo "利用可能なモデル:"
    curl -s "$OLLAMA_HOST/api/tags" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    for m in data.get('models', []):
        print(f\"  - {m['name']}\")
except: pass
" 2>/dev/null || echo "  (一覧取得失敗)"
    exit 1
fi

# 変換プロキシ起動
ensure_proxy || exit 1

# --- パーミッション確認 ---
# --dangerously-skip-permissions はツール実行を全自動化する。
# ローカルLLMは精度が低いため、意図しないコマンドが実行される可能性がある。
# ユーザーに明示的に確認を取る。

# [H4 fix] 配列で安全に管理
PERM_ARGS=()

if [ "$YES_FLAG" -eq 1 ]; then
    PERM_ARGS+=(--dangerously-skip-permissions)
else
    echo ""
    echo "============================================"
    echo " ⚠️  パーミッション確認 / Permission Check"
    echo "============================================"
    echo ""
    echo " vibe-local はツール自動許可モード"
    echo " (--dangerously-skip-permissions) で起動できます。"
    echo ""
    echo " This means the AI can execute commands, read/write"
    echo " files, and modify your system WITHOUT asking."
    echo ""
    echo " ローカルLLMはクラウドAIより精度が低いため、"
    echo " 意図しない操作が実行される可能性があります。"
    echo ""
    echo " Local LLMs are less accurate than cloud AI."
    echo " Unintended actions may occur."
    echo ""
    echo " 本地LLM精度较低，可能执行非预期操作。"
    echo ""
    echo "--------------------------------------------"
    echo " [y] 自動許可モード (Auto-approve all tools)"
    echo " [N] 通常モード (Ask before each tool use)"
    echo "--------------------------------------------"
    echo ""
    # [C2 fix] デフォルトを安全側 (N) に変更
    printf " 続行しますか？ / Continue? [y/N]: "
    read -r REPLY </dev/tty 2>/dev/null || read -r REPLY 2>/dev/null || REPLY="n"
    echo ""

    case "$REPLY" in
        [yY]|[yY][eE][sS]|はい|是)
            PERM_ARGS+=(--dangerously-skip-permissions)
            echo " → 自動許可モードで起動します"
            ;;
        *)
            echo " → 通常モード (毎回確認) で起動します"
            ;;
    esac
fi

PERM_LABEL="通常モード (ask each time)"
if [ ${#PERM_ARGS[@]} -gt 0 ]; then
    PERM_LABEL="ツール自動許可 (auto-approve)"
fi

echo ""
echo "============================================"
echo " 🤖 Claude Code (ローカルモード)"
echo " Model: $MODEL"
echo " Proxy: $PROXY_URL → $OLLAMA_HOST"
echo " Permissions: $PERM_LABEL"
echo "============================================"
echo ""

ANTHROPIC_BASE_URL="$PROXY_URL" \
ANTHROPIC_API_KEY="local" \
exec claude --model "$MODEL" ${PERM_ARGS[@]+"${PERM_ARGS[@]}"} ${EXTRA_ARGS[@]+"${EXTRA_ARGS[@]}"}
