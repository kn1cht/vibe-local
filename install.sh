#!/bin/bash
# claude-local installer
# ワンコマンドでローカルAIコーディング環境をセットアップ
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/ochyai/claude-local/main/install.sh | bash
#   bash install.sh
#   bash install.sh --model qwen3:8b

set -euo pipefail

# --- カラー定義 ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m'

# --- ヘルパー ---
info()    { echo -e "${BLUE}ℹ️  ${NC}$*"; }
success() { echo -e "${GREEN}✅ ${NC}$*"; }
warn()    { echo -e "${YELLOW}⚠️  ${NC}$*"; }
error()   { echo -e "${RED}❌ ${NC}$*"; }
step()    { echo -e "\n${BOLD}${BLUE}[$1/$TOTAL_STEPS] $2${NC}"; }

TOTAL_STEPS=7

# --- 引数パース ---
MANUAL_MODEL=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --model)
            MANUAL_MODEL="$2"
            shift 2
            ;;
        --help|-h)
            echo "Usage: install.sh [--model MODEL_NAME]"
            echo ""
            echo "Options:"
            echo "  --model MODEL  使用するOllamaモデルを指定 (例: qwen3:8b)"
            echo ""
            echo "Examples:"
            echo "  bash install.sh"
            echo "  bash install.sh --model qwen3-coder:30b"
            exit 0
            ;;
        *)
            warn "不明なオプション: $1"
            shift
            ;;
    esac
done

# === ヘッダー ===
echo ""
echo -e "${BOLD}${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${BLUE}║   claude-local インストーラー            ║${NC}"
echo -e "${BOLD}${BLUE}║   無料AIコーディング環境セットアップ     ║${NC}"
echo -e "${BOLD}${BLUE}╚══════════════════════════════════════════╝${NC}"
echo ""

# =============================================
# Step 1: OS / アーキテクチャ検出
# =============================================
step 1 "システム検出"

OS="$(uname -s)"
ARCH="$(uname -m)"
info "OS: $OS / Arch: $ARCH"

case "$OS" in
    Darwin)
        IS_MAC=1
        IS_LINUX=0
        if [ "$ARCH" = "arm64" ]; then
            success "Apple Silicon Mac 検出 (最適な環境です)"
        elif [ "$ARCH" = "x86_64" ]; then
            warn "Intel Mac 検出 - 動作しますがApple Siliconより遅くなります"
        else
            error "未対応のアーキテクチャ: $ARCH"
            exit 1
        fi
        ;;
    Linux)
        IS_MAC=0
        IS_LINUX=1
        if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "aarch64" ]; then
            success "Linux ($ARCH) 検出"
        else
            error "未対応のアーキテクチャ: $ARCH"
            exit 1
        fi
        ;;
    *)
        error "未対応のOS: $OS"
        echo "対応OS: macOS (Apple Silicon推奨), Linux (x86_64/arm64)"
        exit 1
        ;;
esac

# =============================================
# Step 2: RAM 検出 & モデル自動選択
# =============================================
step 2 "メモリ検出 & モデル選択"

if [ "$IS_MAC" -eq 1 ]; then
    RAM_BYTES=$(sysctl -n hw.memsize)
    RAM_GB=$(( RAM_BYTES / 1073741824 ))
else
    RAM_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    RAM_GB=$(( RAM_KB / 1048576 ))
fi

info "搭載メモリ: ${RAM_GB}GB"

if [ -n "$MANUAL_MODEL" ]; then
    MODEL="$MANUAL_MODEL"
    info "手動指定モデル: $MODEL"
elif [ "$RAM_GB" -ge 32 ]; then
    MODEL="qwen3-coder:30b"
    success "モデル自動選択: $MODEL (19GB, コーディング最強)"
elif [ "$RAM_GB" -ge 16 ]; then
    MODEL="qwen3:8b"
    success "モデル自動選択: $MODEL (5GB, 高性能コーディング)"
elif [ "$RAM_GB" -ge 8 ]; then
    MODEL="qwen3:1.7b"
    warn "モデル自動選択: $MODEL (1.1GB, 最低限動作)"
    warn "16GB以上のメモリを推奨します"
else
    error "メモリ不足: ${RAM_GB}GB (最低8GB必要)"
    echo ""
    echo "対処法:"
    echo "  - 不要なアプリを閉じてメモリを解放"
    echo "  - 8GB以上のメモリを搭載したMacが必要です"
    exit 1
fi

# =============================================
# Step 3: 依存パッケージインストール
# =============================================
step 3 "依存パッケージのインストール"

# --- Homebrew (macOS) ---
if [ "$IS_MAC" -eq 1 ]; then
    if command -v brew &>/dev/null; then
        success "Homebrew: インストール済み"
    else
        info "Homebrew をインストール中..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        # Apple Silicon の場合 PATH に追加
        if [ -f /opt/homebrew/bin/brew ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        success "Homebrew インストール完了"
    fi
fi

# --- Ollama ---
if command -v ollama &>/dev/null; then
    success "Ollama: インストール済み ($(ollama --version 2>/dev/null || echo 'version unknown'))"
else
    info "Ollama をインストール中..."
    if [ "$IS_MAC" -eq 1 ]; then
        brew install ollama
    else
        curl -fsSL https://ollama.com/install.sh | sh
    fi
    success "Ollama インストール完了"
fi

# --- Node.js ---
if command -v node &>/dev/null; then
    NODE_VER=$(node --version)
    success "Node.js: インストール済み ($NODE_VER)"
else
    info "Node.js をインストール中..."
    if [ "$IS_MAC" -eq 1 ]; then
        brew install node
    else
        # NodeSource を使用
        if command -v apt-get &>/dev/null; then
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
        elif command -v dnf &>/dev/null; then
            sudo dnf install -y nodejs
        else
            error "パッケージマネージャが見つかりません。手動で Node.js をインストールしてください"
            exit 1
        fi
    fi
    success "Node.js インストール完了 ($(node --version))"
fi

# --- Claude Code CLI ---
if command -v claude &>/dev/null; then
    success "Claude Code CLI: インストール済み"
else
    info "Claude Code CLI をインストール中..."
    npm install -g @anthropic-ai/claude-code
    success "Claude Code CLI インストール完了"
fi

# --- Python3 ---
if command -v python3 &>/dev/null; then
    PY_VER=$(python3 --version)
    success "Python3: インストール済み ($PY_VER)"
else
    info "Python3 をインストール中..."
    if [ "$IS_MAC" -eq 1 ]; then
        brew install python3
    else
        if command -v apt-get &>/dev/null; then
            sudo apt-get install -y python3
        elif command -v dnf &>/dev/null; then
            sudo dnf install -y python3
        fi
    fi
    success "Python3 インストール完了"
fi

# =============================================
# Step 4: モデルダウンロード
# =============================================
step 4 "AIモデルのダウンロード"

# Ollama が起動しているか確認
if ! curl -s --max-time 2 "http://localhost:11434/api/tags" &>/dev/null; then
    info "Ollama を起動中..."
    if [ "$IS_MAC" -eq 1 ]; then
        open -a Ollama 2>/dev/null || ollama serve &>/dev/null &
    else
        ollama serve &>/dev/null &
    fi
    # 起動待ち
    for i in $(seq 1 15); do
        sleep 2
        if curl -s --max-time 2 "http://localhost:11434/api/tags" &>/dev/null; then
            break
        fi
    done
fi

# モデルが既にあるか確認
if curl -s "http://localhost:11434/api/tags" 2>/dev/null | grep -q "$MODEL"; then
    success "モデル $MODEL: ダウンロード済み"
else
    info "モデル $MODEL をダウンロード中..."
    info "(初回はサイズに応じて数分〜数十分かかります)"
    echo ""
    ollama pull "$MODEL"
    success "モデル $MODEL ダウンロード完了"
fi

# =============================================
# Step 5: ファイル配置
# =============================================
step 5 "ファイルの配置"

LIB_DIR="${HOME}/.local/lib/claude-local"
BIN_DIR="${HOME}/.local/bin"

mkdir -p "$LIB_DIR"
mkdir -p "$BIN_DIR"

# ファイルの取得元を判定 (ローカル or GitHub)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"

if [ -n "$SCRIPT_DIR" ] && [ -f "${SCRIPT_DIR}/anthropic-ollama-proxy.py" ]; then
    # ローカルからコピー
    info "ローカルファイルからインストール"
    cp "${SCRIPT_DIR}/anthropic-ollama-proxy.py" "$LIB_DIR/"
    cp "${SCRIPT_DIR}/claude-local.sh" "$BIN_DIR/claude-local"
else
    # GitHub からダウンロード
    REPO_RAW="https://raw.githubusercontent.com/ochyai/claude-local/main"
    info "GitHub からダウンロード"
    curl -fsSL "${REPO_RAW}/anthropic-ollama-proxy.py" -o "$LIB_DIR/anthropic-ollama-proxy.py"
    curl -fsSL "${REPO_RAW}/claude-local.sh" -o "$BIN_DIR/claude-local"
fi

chmod +x "$BIN_DIR/claude-local"
success "ファイル配置完了"
info "  プロキシ: $LIB_DIR/anthropic-ollama-proxy.py"
info "  コマンド: $BIN_DIR/claude-local"

# =============================================
# Step 6: 設定ファイル生成
# =============================================
step 6 "設定ファイルの生成"

CONFIG_DIR="${HOME}/.config/claude-local"
CONFIG_FILE="${CONFIG_DIR}/config"

mkdir -p "$CONFIG_DIR"

if [ -f "$CONFIG_FILE" ]; then
    warn "設定ファイルが既に存在します: $CONFIG_FILE"
    info "既存の設定を保持します (上書きする場合は手動で削除してください)"
else
    cat > "$CONFIG_FILE" << EOF
# claude-local 設定ファイル
# 自動生成: $(date '+%Y-%m-%d %H:%M:%S')

# 使用するOllamaモデル
MODEL="$MODEL"

# プロキシポート
PROXY_PORT=8082

# Ollamaホスト
OLLAMA_HOST="http://localhost:11434"
EOF
    success "設定ファイル生成: $CONFIG_FILE"
fi

# --- PATH 追加 ---
BIN_IN_PATH=0
if echo "$PATH" | grep -q "${HOME}/.local/bin"; then
    BIN_IN_PATH=1
fi

if [ "$BIN_IN_PATH" -eq 0 ]; then
    # シェル設定ファイルに追加
    SHELL_RC=""
    if [ -f "${HOME}/.zshrc" ]; then
        SHELL_RC="${HOME}/.zshrc"
    elif [ -f "${HOME}/.bashrc" ]; then
        SHELL_RC="${HOME}/.bashrc"
    fi

    if [ -n "$SHELL_RC" ]; then
        if ! grep -q '\.local/bin' "$SHELL_RC" 2>/dev/null; then
            echo '' >> "$SHELL_RC"
            echo '# claude-local' >> "$SHELL_RC"
            echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> "$SHELL_RC"
            success "PATH を $SHELL_RC に追加しました"
            info "反映するにはターミナルを再起動するか: source $SHELL_RC"
        else
            success "PATH: 設定済み"
        fi
    fi
    # 現在のセッションにも反映
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# =============================================
# Step 7: 動作確認テスト
# =============================================
step 7 "動作確認"

# Ollama テスト
if curl -s --max-time 2 "http://localhost:11434/api/tags" &>/dev/null; then
    success "Ollama: 起動中"
else
    warn "Ollama: 停止中 (claude-local 実行時に自動起動します)"
fi

# プロキシ起動テスト
info "プロキシの起動テスト..."
python3 "$LIB_DIR/anthropic-ollama-proxy.py" 8083 &>/tmp/claude-local-test-proxy.log &
TEST_PID=$!
sleep 2

if curl -s --max-time 2 "http://127.0.0.1:8083/" &>/dev/null; then
    success "プロキシ: 正常動作"
else
    warn "プロキシ: 起動テストに失敗 (ログ: /tmp/claude-local-test-proxy.log)"
fi
kill "$TEST_PID" 2>/dev/null || true

# Claude Code テスト
if command -v claude &>/dev/null; then
    success "Claude Code CLI: 利用可能"
else
    warn "Claude Code CLI: PATH に見つかりません (ターミナル再起動後に確認してください)"
fi

# =============================================
# 完了
# =============================================
echo ""
echo -e "${BOLD}${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${BOLD}${GREEN}║   インストール完了!                      ║${NC}"
echo -e "${BOLD}${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "使い方:"
echo -e "  ${BOLD}claude-local${NC}                    対話モード"
echo -e "  ${BOLD}claude-local -p \"質問\"${NC}          ワンショット"
echo -e "  ${BOLD}claude-local --auto${NC}             ネットワーク自動判定"
echo ""
echo -e "設定:"
echo -e "  モデル: ${BOLD}$MODEL${NC}"
echo -e "  設定ファイル: ${CONFIG_FILE}"
echo ""
echo -e "${YELLOW}注意: 新しいターミナルを開いてから claude-local を実行してください${NC}"
echo ""
