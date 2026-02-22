#!/bin/bash
# vibe-local installer
# ✨🌴 Ｖ Ａ Ｐ Ｏ Ｒ Ｗ Ａ Ｖ Ｅ   ＩＮＳＴＡＬＬＥＲ 🌴✨
# Trilingual: 日本語 / English / 中文
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/ochyai/vibe-local/main/install.sh | bash
#   bash install.sh
#   bash install.sh --model qwen3:8b
#   bash install.sh --lang en

set -euo pipefail

# ╔══════════════════════════════════════════════════════════════╗
# ║  🎨  Ｖ Ａ Ｐ Ｏ Ｒ Ｗ Ａ Ｖ Ｅ   Ｃ Ｏ Ｌ Ｏ Ｒ Ｓ    ║
# ╚══════════════════════════════════════════════════════════════╝

PINK='\033[38;5;198m'
HOT_PINK='\033[38;5;206m'
MAGENTA='\033[38;5;165m'
PURPLE='\033[38;5;141m'
CYAN='\033[38;5;51m'
AQUA='\033[38;5;87m'
MINT='\033[38;5;121m'
CORAL='\033[38;5;210m'
ORANGE='\033[38;5;208m'
YELLOW='\033[38;5;226m'
WHITE='\033[38;5;255m'
GRAY='\033[38;5;245m'
RED='\033[38;5;196m'
GREEN='\033[38;5;46m'
NEON_GREEN='\033[38;5;118m'
BLUE='\033[38;5;33m'

BG_PINK='\033[48;5;198m'
BG_PURPLE='\033[48;5;53m'
BG_CYAN='\033[48;5;30m'

BOLD='\033[1m'
DIM='\033[2m'
BLINK='\033[5m'
NC='\033[0m'

GRADIENT_NEON=(46 47 48 49 50 51 45 39 33 27 21 57 93 129 165 201 200 199 198 197 196)
GRADIENT_VAPOR=(51 87 123 159 195 189 183 177 171 165)

# ╔══════════════════════════════════════════════════════════════╗
# ║  🌐  Ｔ Ｒ Ｉ Ｌ Ｉ Ｎ Ｇ Ｕ Ａ Ｌ   Ｅ Ｎ Ｇ Ｉ Ｎ Ｅ  ║
# ╚══════════════════════════════════════════════════════════════╝

# Detect system language: ja / en / zh
detect_lang() {
    local raw_lang="${LANG:-${LC_ALL:-${LC_MESSAGES:-en_US.UTF-8}}}"
    case "$raw_lang" in
        ja*) echo "ja" ;;
        zh*) echo "zh" ;;
        *)   echo "en" ;;
    esac
}

LANG_CODE="$(detect_lang)"

# Message lookup: msg KEY
# Returns message in current LANG_CODE
msg() {
    local key="$1"
    local var="MSG_${LANG_CODE}_${key}"
    echo "${!var:-${key}}"
}

# === Japanese ===
MSG_ja_subtitle="✨🌴  無 料 Ａ Ｉ コ ー デ ィ ン グ 環 境  🌴✨"
MSG_ja_tagline="ネットワーク不要 • 完全無料 • ローカルAIコーディング"
MSG_ja_boot1="ヴェイパーウェーブサブシステム初期化中..."
MSG_ja_boot2="アエステティックモジュール読み込み中..."
MSG_ja_boot3="ネオン周波数キャリブレーション中..."
MSG_ja_boot4="▶ Ｓ Ｙ Ｓ Ｔ Ｅ Ｍ  Ｏ Ｎ Ｌ Ｉ Ｎ Ｅ"
MSG_ja_step1="Ｓ Ｙ Ｓ Ｔ Ｅ Ｍ  Ｓ Ｃ Ａ Ｎ"
MSG_ja_step2="Ｍ Ｅ Ｍ Ｏ Ｒ Ｙ  Ａ Ｎ Ａ Ｌ Ｙ Ｓ Ｉ Ｓ"
MSG_ja_step3="Ｐ Ａ Ｃ Ｋ Ａ Ｇ Ｅ  Ｉ Ｎ Ｓ Ｔ Ａ Ｌ Ｌ"
MSG_ja_step4="Ａ Ｉ  Ｍ Ｏ Ｄ Ｅ Ｌ  Ｄ Ｏ Ｗ Ｎ Ｌ Ｏ Ａ Ｄ"
MSG_ja_step5="Ｆ Ｉ Ｌ Ｅ  Ｄ Ｅ Ｐ Ｌ Ｏ Ｙ"
MSG_ja_step6="Ｃ Ｏ Ｎ Ｆ Ｉ Ｇ  Ｇ Ｅ Ｎ Ｅ Ｒ Ａ Ｔ Ｅ"
MSG_ja_step7="Ｓ Ｙ Ｓ Ｔ Ｅ Ｍ  Ｔ Ｅ Ｓ Ｔ"
MSG_ja_hw_scan="ハードウェアスキャン中..."
MSG_ja_apple_silicon="Apple Silicon Mac 検出 🍎⚡ (最適な環境です)"
MSG_ja_intel_mac="Intel Mac 検出 - 動作しますがApple Siliconより遅くなります"
MSG_ja_linux_ok="Linux 検出 🐧"
MSG_ja_unsupported_arch="未対応のアーキテクチャ"
MSG_ja_unsupported_os="未対応のOS"
MSG_ja_supported_os="対応OS: macOS (Apple Silicon推奨), Linux (x86_64/arm64)"
MSG_ja_mem_scan="メモリ空間マッピング中..."
MSG_ja_mem_label="搭載メモリ"
MSG_ja_model_best="コーディング最強"
MSG_ja_model_great="高性能コーディング"
MSG_ja_model_min="最低限動作"
MSG_ja_model_recommend="16GB以上のメモリを推奨します"
MSG_ja_mem_lack="メモリ不足"
MSG_ja_mem_lack_min="最低8GB必要"
MSG_ja_mem_lack_hint1="不要なアプリを閉じてメモリを解放"
MSG_ja_mem_lack_hint2="8GB以上のメモリを搭載したMacが必要です"
MSG_ja_manual_model="手動指定モデル"
MSG_ja_installed="インストール済み"
MSG_ja_installing="インストール中..."
MSG_ja_install_done="インストール完了"
MSG_ja_no_pkgmgr="パッケージマネージャが見つかりません"
MSG_ja_ollama_starting="Ollama を起動中..."
MSG_ja_model_downloading="モデルをダウンロード中..."
MSG_ja_model_download_hint="初回はサイズに応じて数分〜数十分かかります"
MSG_ja_model_downloaded="ダウンロード済み"
MSG_ja_model_dl_done="ダウンロード完了"
MSG_ja_file_deploy="ファイルデプロイ中..."
MSG_ja_source_local="ソース: ローカル"
MSG_ja_source_github="ソース: GitHub"
MSG_ja_config_gen="設定ファイル生成中..."
MSG_ja_config_exists="設定ファイルが既に存在 → 既存設定を保持"
MSG_ja_config_file="設定ファイル"
MSG_ja_path_added="PATH 追加"
MSG_ja_path_set="PATH: 設定済み"
MSG_ja_diag="システム診断を実行中..."
MSG_ja_online="ＯＮＬＩＮＥ"
MSG_ja_standby="ＳＴＡＮＤＢＹ (起動時に自動起動)"
MSG_ja_ready="ＲＥＡＤＹ"
MSG_ja_warning="ＷＡＲＮＩＮＧ"
MSG_ja_loaded="ＬＯＡＤＥＤ"
MSG_ja_not_loaded="未ロード"
MSG_ja_path_reopen="PATH未設定 (ターミナル再起動で解決)"
MSG_ja_complete="ＩＮＳＴＡＬＬ  ＣＯＭＰＬＥＴＥ !!"
MSG_ja_usage="使い方:"
MSG_ja_mode_interactive="対話モード"
MSG_ja_mode_oneshot="ワンショット"
MSG_ja_mode_auto="ネットワーク自動判定"
MSG_ja_settings="設定:"
MSG_ja_label_model="モデル"
MSG_ja_label_config="設定"
MSG_ja_label_command="コマンド"
MSG_ja_reopen="新しいターミナルを開いてから vibe-local を実行"
MSG_ja_enjoy="🌴  無 料 Ａ Ｉ コ ー デ ィ ン グ を 楽 し も う  🌴"
MSG_ja_help_usage="Usage: install.sh [--model MODEL_NAME] [--lang LANG]"
MSG_ja_help_model="使用するOllamaモデルを指定 (例: qwen3:8b)"
MSG_ja_help_lang="言語指定: ja, en, zh"
MSG_ja_unknown_opt="不明なオプション"

# === English ===
MSG_en_subtitle="✨🌴  Ｆ Ｒ Ｅ Ｅ  Ａ Ｉ  Ｃ Ｏ Ｄ Ｉ Ｎ Ｇ  Ｅ Ｎ Ｖ Ｉ Ｒ Ｏ Ｎ Ｍ Ｅ Ｎ Ｔ  🌴✨"
MSG_en_tagline="No Network • Totally Free • Local AI Coding"
MSG_en_boot1="Initializing vaporwave subsystem..."
MSG_en_boot2="Loading aesthetic modules..."
MSG_en_boot3="Calibrating neon frequencies..."
MSG_en_boot4="▶ Ｓ Ｙ Ｓ Ｔ Ｅ Ｍ  Ｏ Ｎ Ｌ Ｉ Ｎ Ｅ"
MSG_en_step1="Ｓ Ｙ Ｓ Ｔ Ｅ Ｍ  Ｓ Ｃ Ａ Ｎ"
MSG_en_step2="Ｍ Ｅ Ｍ Ｏ Ｒ Ｙ  Ａ Ｎ Ａ Ｌ Ｙ Ｓ Ｉ Ｓ"
MSG_en_step3="Ｐ Ａ Ｃ Ｋ Ａ Ｇ Ｅ  Ｉ Ｎ Ｓ Ｔ Ａ Ｌ Ｌ"
MSG_en_step4="Ａ Ｉ  Ｍ Ｏ Ｄ Ｅ Ｌ  Ｄ Ｏ Ｗ Ｎ Ｌ Ｏ Ａ Ｄ"
MSG_en_step5="Ｆ Ｉ Ｌ Ｅ  Ｄ Ｅ Ｐ Ｌ Ｏ Ｙ"
MSG_en_step6="Ｃ Ｏ Ｎ Ｆ Ｉ Ｇ  Ｇ Ｅ Ｎ Ｅ Ｒ Ａ Ｔ Ｅ"
MSG_en_step7="Ｓ Ｙ Ｓ Ｔ Ｅ Ｍ  Ｔ Ｅ Ｓ Ｔ"
MSG_en_hw_scan="Scanning hardware..."
MSG_en_apple_silicon="Apple Silicon Mac detected 🍎⚡ (optimal environment)"
MSG_en_intel_mac="Intel Mac detected - works but slower than Apple Silicon"
MSG_en_linux_ok="Linux detected 🐧"
MSG_en_unsupported_arch="Unsupported architecture"
MSG_en_unsupported_os="Unsupported OS"
MSG_en_supported_os="Supported: macOS (Apple Silicon recommended), Linux (x86_64/arm64)"
MSG_en_mem_scan="Mapping memory space..."
MSG_en_mem_label="System memory"
MSG_en_model_best="Best for coding"
MSG_en_model_great="Great for coding"
MSG_en_model_min="Minimum viable"
MSG_en_model_recommend="16GB+ RAM recommended"
MSG_en_mem_lack="Insufficient memory"
MSG_en_mem_lack_min="Minimum 8GB required"
MSG_en_mem_lack_hint1="Close unnecessary apps to free memory"
MSG_en_mem_lack_hint2="A Mac with 8GB+ RAM is required"
MSG_en_manual_model="Manual model"
MSG_en_installed="installed"
MSG_en_installing="Installing..."
MSG_en_install_done="installed"
MSG_en_no_pkgmgr="No package manager found"
MSG_en_ollama_starting="Starting Ollama..."
MSG_en_model_downloading="Downloading model..."
MSG_en_model_download_hint="First download may take several minutes depending on size"
MSG_en_model_downloaded="already downloaded"
MSG_en_model_dl_done="download complete"
MSG_en_file_deploy="Deploying files..."
MSG_en_source_local="Source: local"
MSG_en_source_github="Source: GitHub"
MSG_en_config_gen="Generating config..."
MSG_en_config_exists="Config exists → keeping current settings"
MSG_en_config_file="Config file"
MSG_en_path_added="PATH added"
MSG_en_path_set="PATH: already set"
MSG_en_diag="Running system diagnostics..."
MSG_en_online="ＯＮＬＩＮＥ"
MSG_en_standby="ＳＴＡＮＤＢＹ (auto-starts on launch)"
MSG_en_ready="ＲＥＡＤＹ"
MSG_en_warning="ＷＡＲＮＩＮＧ"
MSG_en_loaded="ＬＯＡＤＥＤ"
MSG_en_not_loaded="not loaded"
MSG_en_path_reopen="Not in PATH (restart terminal to fix)"
MSG_en_complete="ＩＮＳＴＡＬＬ  ＣＯＭＰＬＥＴＥ !!"
MSG_en_usage="Usage:"
MSG_en_mode_interactive="Interactive mode"
MSG_en_mode_oneshot="One-shot"
MSG_en_mode_auto="Auto-detect network"
MSG_en_settings="Settings:"
MSG_en_label_model="Model"
MSG_en_label_config="Config"
MSG_en_label_command="Command"
MSG_en_reopen="Open a new terminal, then run vibe-local"
MSG_en_enjoy="🌴  Ｅ Ｎ Ｊ Ｏ Ｙ  Ｆ Ｒ Ｅ Ｅ  Ａ Ｉ  Ｃ Ｏ Ｄ Ｉ Ｎ Ｇ  🌴"
MSG_en_help_usage="Usage: install.sh [--model MODEL_NAME] [--lang LANG]"
MSG_en_help_model="Specify Ollama model (e.g. qwen3:8b)"
MSG_en_help_lang="Language: ja, en, zh"
MSG_en_unknown_opt="Unknown option"

# === Chinese ===
MSG_zh_subtitle="✨🌴  免 费 Ａ Ｉ 编 程 环 境  🌴✨"
MSG_zh_tagline="无需网络 • 完全免费 • 本地AI编程"
MSG_zh_boot1="初始化蒸汽波子系统..."
MSG_zh_boot2="加载美学模块..."
MSG_zh_boot3="校准霓虹频率..."
MSG_zh_boot4="▶ Ｓ Ｙ Ｓ Ｔ Ｅ Ｍ  Ｏ Ｎ Ｌ Ｉ Ｎ Ｅ"
MSG_zh_step1="Ｓ Ｙ Ｓ Ｔ Ｅ Ｍ  Ｓ Ｃ Ａ Ｎ"
MSG_zh_step2="Ｍ Ｅ Ｍ Ｏ Ｒ Ｙ  Ａ Ｎ Ａ Ｌ Ｙ Ｓ Ｉ Ｓ"
MSG_zh_step3="Ｐ Ａ Ｃ Ｋ Ａ Ｇ Ｅ  Ｉ Ｎ Ｓ Ｔ Ａ Ｌ Ｌ"
MSG_zh_step4="Ａ Ｉ  Ｍ Ｏ Ｄ Ｅ Ｌ  Ｄ Ｏ Ｗ Ｎ Ｌ Ｏ Ａ Ｄ"
MSG_zh_step5="Ｆ Ｉ Ｌ Ｅ  Ｄ Ｅ Ｐ Ｌ Ｏ Ｙ"
MSG_zh_step6="Ｃ Ｏ Ｎ Ｆ Ｉ Ｇ  Ｇ Ｅ Ｎ Ｅ Ｒ Ａ Ｔ Ｅ"
MSG_zh_step7="Ｓ Ｙ Ｓ Ｔ Ｅ Ｍ  Ｔ Ｅ Ｓ Ｔ"
MSG_zh_hw_scan="扫描硬件中..."
MSG_zh_apple_silicon="检测到 Apple Silicon Mac 🍎⚡ (最佳环境)"
MSG_zh_intel_mac="检测到 Intel Mac - 可运行但比Apple Silicon慢"
MSG_zh_linux_ok="检测到 Linux 🐧"
MSG_zh_unsupported_arch="不支持的架构"
MSG_zh_unsupported_os="不支持的操作系统"
MSG_zh_supported_os="支持: macOS (推荐Apple Silicon), Linux (x86_64/arm64)"
MSG_zh_mem_scan="内存空间映射中..."
MSG_zh_mem_label="系统内存"
MSG_zh_model_best="编程最强"
MSG_zh_model_great="高性能编程"
MSG_zh_model_min="最低限运行"
MSG_zh_model_recommend="推荐16GB以上内存"
MSG_zh_mem_lack="内存不足"
MSG_zh_mem_lack_min="最少需要8GB"
MSG_zh_mem_lack_hint1="关闭不需要的应用以释放内存"
MSG_zh_mem_lack_hint2="需要8GB以上内存的Mac"
MSG_zh_manual_model="手动指定模型"
MSG_zh_installed="已安装"
MSG_zh_installing="安装中..."
MSG_zh_install_done="安装完成"
MSG_zh_no_pkgmgr="未找到包管理器"
MSG_zh_ollama_starting="正在启动 Ollama..."
MSG_zh_model_downloading="下载模型中..."
MSG_zh_model_download_hint="首次下载可能需要几分钟到几十分钟"
MSG_zh_model_downloaded="已下载"
MSG_zh_model_dl_done="下载完成"
MSG_zh_file_deploy="部署文件中..."
MSG_zh_source_local="来源: 本地"
MSG_zh_source_github="来源: GitHub"
MSG_zh_config_gen="生成配置文件中..."
MSG_zh_config_exists="配置文件已存在 → 保持现有设置"
MSG_zh_config_file="配置文件"
MSG_zh_path_added="PATH 已添加"
MSG_zh_path_set="PATH: 已设置"
MSG_zh_diag="运行系统诊断..."
MSG_zh_online="ＯＮＬＩＮＥ"
MSG_zh_standby="ＳＴＡＮＤＢＹ (启动时自动运行)"
MSG_zh_ready="ＲＥＡＤＹ"
MSG_zh_warning="ＷＡＲＮＩＮＧ"
MSG_zh_loaded="ＬＯＡＤＥＤ"
MSG_zh_not_loaded="未加载"
MSG_zh_path_reopen="未在PATH中 (重启终端解决)"
MSG_zh_complete="安 装 完 成 !!"
MSG_zh_usage="使用方法:"
MSG_zh_mode_interactive="交互模式"
MSG_zh_mode_oneshot="单次执行"
MSG_zh_mode_auto="自动检测网络"
MSG_zh_settings="设置:"
MSG_zh_label_model="模型"
MSG_zh_label_config="配置"
MSG_zh_label_command="命令"
MSG_zh_reopen="打开新终端后运行 vibe-local"
MSG_zh_enjoy="🌴  享 受 免 费 Ａ Ｉ 编 程  🌴"
MSG_zh_help_usage="Usage: install.sh [--model MODEL_NAME] [--lang LANG]"
MSG_zh_help_model="指定Ollama模型 (例: qwen3:8b)"
MSG_zh_help_lang="语言: ja, en, zh"
MSG_zh_unknown_opt="未知选项"

# ╔══════════════════════════════════════════════════════════════╗
# ║  🎬  Ａ Ｎ Ｉ Ｍ Ａ Ｔ Ｉ Ｏ Ｎ   Ｅ Ｎ Ｇ Ｉ Ｎ Ｅ    ║
# ╚══════════════════════════════════════════════════════════════╝

rainbow_text() {
    local text="$1"
    local -a colors=("${GRADIENT_NEON[@]}")
    local len=${#text}
    local num_colors=${#colors[@]}
    local result=""
    for ((i=0; i<len; i++)); do
        local ci=$(( i % num_colors ))
        result+="\033[38;5;${colors[$ci]}m${text:$i:1}"
    done
    echo -e "${result}${NC}"
}

vapor_text() {
    local text="$1"
    local -a colors=("${GRADIENT_VAPOR[@]}")
    local len=${#text}
    local num_colors=${#colors[@]}
    local result=""
    for ((i=0; i<len; i++)); do
        local ci=$(( (i * num_colors / len) % num_colors ))
        result+="\033[38;5;${colors[$ci]}m${text:$i:1}"
    done
    echo -e "${result}${NC}"
}

vaporwave_progress() {
    local msg="$1"
    local duration="${2:-2}"
    local width=40
    local bar_chars=("░" "▒" "▓" "█")
    local sparkles=("✨" "💎" "🔮" "💜" "🌸" "🎵" "🌊" "⚡" "🔥" "💫" "🌈" "🦄")
    local -a colors=(198 199 207 213 177 171 165 129 93 57 51 50 49 48 47 46)
    local num_colors=${#colors[@]}
    local steps=$(( ${duration%.*} * 20 ))
    if [ "$steps" -lt 10 ]; then steps=10; fi

    for ((s=0; s<=steps; s++)); do
        local pct=$(( s * 100 / steps ))
        local filled=$(( s * width / steps ))
        local empty=$(( width - filled ))
        local spark_idx=$(( s % ${#sparkles[@]} ))
        local spark="${sparkles[$spark_idx]}"

        local bar=""
        for ((b=0; b<filled; b++)); do
            local ci=$(( b * num_colors / width ))
            bar+="\033[38;5;${colors[$ci]}m█"
        done
        if [ "$filled" -lt "$width" ]; then
            local anim_idx=$(( s % 4 ))
            local ci=$(( filled * num_colors / width ))
            bar+="\033[38;5;${colors[$ci]}m${bar_chars[$anim_idx]}"
            empty=$(( empty - 1 ))
        fi
        for ((b=0; b<empty; b++)); do
            bar+="\033[38;5;237m░"
        done

        printf "\r  ${spark} ${BOLD}${CYAN}%-30s${NC} ${MAGENTA}▐${NC}${bar}${MAGENTA}▌${NC} ${BOLD}${NEON_GREEN}%3d%%${NC} ${spark} " "$msg" "$pct"
        sleep 0.05
    done
    printf "\r  ✅ ${BOLD}${GREEN}%-30s${NC} ${MAGENTA}▐${NC}"
    for ((b=0; b<width; b++)); do
        local ci=$(( b * num_colors / width ))
        printf "\033[38;5;${colors[$ci]}m█"
    done
    printf "${MAGENTA}▌${NC} ${BOLD}${NEON_GREEN}100%%${NC} 🎉 \n"
}

step_header() {
    local num="$1"
    local title="$2"
    local icons=("🔍" "🧠" "📦" "🤖" "📂" "⚙️" "🧪")
    local icon="${icons[$(( num - 1 ))]}"
    local -a colors=(51 87 123 159 165 171 177)
    local c="${colors[$(( num - 1 ))]}"
    echo ""
    echo -e "  \033[38;5;${c}m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "  ${icon}  \033[38;5;${c}m${BOLD}ＳＴＥＰ ${num}/${TOTAL_STEPS}${NC}  ${BOLD}${WHITE}${title}${NC}"
    echo -e "  \033[38;5;${c}m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

vapor_success() { echo -e "  ${NEON_GREEN}┃${NC} ✅ ${BOLD}${MINT}$*${NC}"; }
vapor_info()    { echo -e "  ${CYAN}┃${NC} 💠 ${AQUA}$*${NC}"; }
vapor_warn()    { echo -e "  ${ORANGE}┃${NC} ⚠️  ${YELLOW}$*${NC}"; }
vapor_error()   { echo -e "  ${RED}┃${NC} 💀 ${RED}${BOLD}$*${NC}"; }

TOTAL_STEPS=7

# --- 引数パース ---
MANUAL_MODEL=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --model)
            MANUAL_MODEL="$2"
            shift 2
            ;;
        --lang)
            LANG_CODE="$2"
            shift 2
            ;;
        --help|-h)
            echo "$(msg help_usage)"
            echo ""
            echo "Options:"
            echo "  --model MODEL  $(msg help_model)"
            echo "  --lang LANG    $(msg help_lang)"
            exit 0
            ;;
        *)
            vapor_warn "$(msg unknown_opt): $1"
            shift
            ;;
    esac
done

# ╔══════════════════════════════════════════════════════════════╗
# ║  🌅  Ｔ Ｉ Ｔ Ｌ Ｅ   Ｓ Ｃ Ｒ Ｅ Ｅ Ｎ                ║
# ╚══════════════════════════════════════════════════════════════╝

clear 2>/dev/null || true
echo ""

# Animated entrance
for i in 1 2 3; do
    printf "\r  💜✨🔮  "
    sleep 0.15
    printf "\r  🔮💜✨  "
    sleep 0.15
    printf "\r  ✨🔮💜  "
    sleep 0.15
done
printf "\r              \n"

echo -e "  ${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${MINT}💜${NEON_GREEN}💜${YELLOW}💜${ORANGE}💜${CORAL}💜${HOT_PINK}💜${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${NC}"
echo ""
echo -e "${MAGENTA}${BOLD}"
cat << 'LOGO'
    ██╗   ██╗██╗██████╗ ███████╗
    ██║   ██║██║██╔══██╗██╔════╝
    ██║   ██║██║██████╔╝█████╗
    ╚██╗ ██╔╝██║██╔══██╗██╔══╝
     ╚████╔╝ ██║██████╔╝███████╗
      ╚═══╝  ╚═╝╚═════╝ ╚══════╝
LOGO
echo -e "${NC}${CYAN}${BOLD}"
cat << 'LOGO2'
              ██╗      ██████╗  ██████╗ █████╗ ██╗
              ██║     ██╔═══██╗██╔════╝██╔══██╗██║
              ██║     ██║   ██║██║     ███████║██║
              ██║     ██║   ██║██║     ██╔══██║██║
              ███████╗╚██████╔╝╚██████╗██║  ██║███████╗
              ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝
LOGO2
echo -e "${NC}"
echo -e "  ${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${MINT}💜${NEON_GREEN}💜${YELLOW}💜${ORANGE}💜${CORAL}💜${HOT_PINK}💜${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${NC}"
echo ""
vapor_text "  $(msg subtitle)"
echo ""
rainbow_text "  ════════════════════════════════════════════════════════════════"
echo -e "  ${PINK}💜${NC} ${BOLD}${WHITE}$(msg tagline)${NC} ${PINK}💜${NC}"
rainbow_text "  ════════════════════════════════════════════════════════════════"
echo ""
sleep 1

echo -e "  ${DIM}${CYAN}$(msg boot1)${NC}"
sleep 0.3
echo -e "  ${DIM}${PURPLE}$(msg boot2)${NC}"
sleep 0.3
echo -e "  ${DIM}${PINK}$(msg boot3)${NC}"
sleep 0.3
echo -e "  ${BOLD}${NEON_GREEN}  $(msg boot4)${NC}"
sleep 0.5
echo ""

# =============================================
# Step 1: OS / アーキテクチャ検出
# =============================================
step_header 1 "$(msg step1)"

OS="$(uname -s)"
ARCH="$(uname -m)"

vaporwave_progress "$(msg hw_scan)" 1

vapor_info "OS: $OS / Arch: $ARCH"

case "$OS" in
    Darwin)
        IS_MAC=1
        IS_LINUX=0
        if [ "$ARCH" = "arm64" ]; then
            vapor_success "$(msg apple_silicon)"
        elif [ "$ARCH" = "x86_64" ]; then
            vapor_warn "$(msg intel_mac)"
        else
            vapor_error "$(msg unsupported_arch): $ARCH"
            exit 1
        fi
        ;;
    Linux)
        IS_MAC=0
        IS_LINUX=1
        if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "aarch64" ]; then
            vapor_success "$(msg linux_ok) ($ARCH)"
        else
            vapor_error "$(msg unsupported_arch): $ARCH"
            exit 1
        fi
        ;;
    *)
        vapor_error "$(msg unsupported_os): $OS"
        echo "  $(msg supported_os)"
        exit 1
        ;;
esac

# =============================================
# Step 2: RAM 検出 & モデル自動選択
# =============================================
step_header 2 "$(msg step2)"

if [ "$IS_MAC" -eq 1 ]; then
    RAM_BYTES=$(sysctl -n hw.memsize)
    RAM_GB=$(( RAM_BYTES / 1073741824 ))
else
    RAM_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    RAM_GB=$(( RAM_KB / 1048576 ))
fi

vaporwave_progress "$(msg mem_scan)" 1

RAM_DISPLAY_MAX=128
RAM_BAR_WIDTH=30
RAM_FILLED=$(( RAM_GB * RAM_BAR_WIDTH / RAM_DISPLAY_MAX ))
if [ "$RAM_FILLED" -gt "$RAM_BAR_WIDTH" ]; then RAM_FILLED=$RAM_BAR_WIDTH; fi
RAM_EMPTY=$(( RAM_BAR_WIDTH - RAM_FILLED ))

RAM_BAR=""
for ((i=0; i<RAM_FILLED; i++)); do RAM_BAR+="█"; done
for ((i=0; i<RAM_EMPTY; i++)); do RAM_BAR+="░"; done

echo -e "  ${PURPLE}┃${NC} 🧠 ${BOLD}${WHITE}$(msg mem_label): ${NEON_GREEN}${RAM_GB}GB${NC}"
echo -e "  ${PURPLE}┃${NC}    ${CYAN}▐${NEON_GREEN}${RAM_BAR}${CYAN}▌${NC} ${DIM}${GRAY}(${RAM_GB}/${RAM_DISPLAY_MAX}GB)${NC}"
echo ""

if [ -n "$MANUAL_MODEL" ]; then
    MODEL="$MANUAL_MODEL"
    vapor_info "$(msg manual_model): $MODEL"
elif [ "$RAM_GB" -ge 32 ]; then
    MODEL="qwen3-coder:30b"
    echo -e "  ${NEON_GREEN}┃${NC} 🏆 ${BOLD}${YELLOW}★★★ ＢＥＳＴ  ＭＯＤＥＬ ★★★${NC}"
    echo -e "  ${NEON_GREEN}┃${NC}    ${BOLD}${WHITE}$MODEL${NC} ${DIM}(19GB, MoE 3.3B active, $(msg model_best))${NC}"
elif [ "$RAM_GB" -ge 16 ]; then
    MODEL="qwen3:8b"
    echo -e "  ${MINT}┃${NC} ⭐ ${BOLD}${CYAN}★★ ＧＲＥＡＴ  ＭＯＤＥＬ ★★${NC}"
    echo -e "  ${MINT}┃${NC}    ${BOLD}${WHITE}$MODEL${NC} ${DIM}(5GB, $(msg model_great))${NC}"
elif [ "$RAM_GB" -ge 8 ]; then
    MODEL="qwen3:1.7b"
    vapor_warn "$MODEL (1.1GB, $(msg model_min))"
    vapor_warn "$(msg model_recommend)"
else
    vapor_error "$(msg mem_lack): ${RAM_GB}GB ($(msg mem_lack_min))"
    echo ""
    echo "  $(msg mem_lack_hint1)"
    echo "  $(msg mem_lack_hint2)"
    exit 1
fi

# =============================================
# Step 3: 依存パッケージインストール
# =============================================
step_header 3 "$(msg step3)"

if [ "$IS_MAC" -eq 1 ]; then
    if command -v brew &>/dev/null; then
        vapor_success "Homebrew 🍺 $(msg installed)"
    else
        vaporwave_progress "Homebrew $(msg installing)" 3
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        if [ -f /opt/homebrew/bin/brew ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        vapor_success "Homebrew 🍺 $(msg install_done)"
    fi
fi

# brew install は HOMEBREW_NO_AUTO_UPDATE=1 で高速化
# (auto-update が走ると数分間フリーズしたように見える)
brew_install() {
    HOMEBREW_NO_AUTO_UPDATE=1 brew install "$@"
}

if command -v ollama &>/dev/null; then
    vapor_success "Ollama 🦙 $(msg installed) ($(ollama --version 2>/dev/null || echo '?'))"
else
    vapor_info "Ollama 🦙 $(msg installing)"
    if [ "$IS_MAC" -eq 1 ]; then
        brew_install ollama
    else
        curl -fsSL https://ollama.com/install.sh | sh
    fi
    vapor_success "Ollama 🦙 $(msg install_done)"
fi

if command -v node &>/dev/null; then
    vapor_success "Node.js 💚 $(msg installed) ($(node --version))"
else
    vapor_info "Node.js 💚 $(msg installing)"
    if [ "$IS_MAC" -eq 1 ]; then
        brew_install node
    else
        if command -v apt-get &>/dev/null; then
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
        elif command -v dnf &>/dev/null; then
            sudo dnf install -y nodejs
        else
            vapor_error "$(msg no_pkgmgr)"
            exit 1
        fi
    fi
    vapor_success "Node.js 💚 $(msg install_done) ($(node --version))"
fi

if command -v claude &>/dev/null; then
    vapor_success "Claude Code CLI 🤖 $(msg installed)"
else
    vapor_info "Claude Code CLI 🤖 $(msg installing)"
    npm install -g @anthropic-ai/claude-code
    vapor_success "Claude Code CLI 🤖 $(msg install_done)"
fi

if command -v python3 &>/dev/null; then
    vapor_success "Python3 🐍 $(msg installed) ($(python3 --version))"
else
    vapor_info "Python3 🐍 $(msg installing)"
    if [ "$IS_MAC" -eq 1 ]; then
        brew_install python3
    else
        if command -v apt-get &>/dev/null; then
            sudo apt-get install -y python3
        elif command -v dnf &>/dev/null; then
            sudo dnf install -y python3
        fi
    fi
    vapor_success "Python3 🐍 $(msg install_done)"
fi

# =============================================
# Step 4: モデルダウンロード
# =============================================
step_header 4 "$(msg step4)"

if ! curl -s --max-time 2 "http://localhost:11434/api/tags" &>/dev/null; then
    vapor_info "$(msg ollama_starting)"
    if [ "$IS_MAC" -eq 1 ]; then
        open -a Ollama 2>/dev/null || ollama serve &>/dev/null &
    else
        ollama serve &>/dev/null &
    fi
    for i in $(seq 1 15); do
        sleep 2
        if curl -s --max-time 2 "http://localhost:11434/api/tags" &>/dev/null; then
            break
        fi
    done
fi

if curl -s "http://localhost:11434/api/tags" 2>/dev/null | grep -q "$MODEL"; then
    vapor_success "$MODEL $(msg model_downloaded) 🧠✨"
else
    echo ""
    echo -e "  ${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${MINT}💜${NEON_GREEN}💜${YELLOW}💜${ORANGE}💜${CORAL}💜${HOT_PINK}💜${NC}"
    echo -e "  ${BOLD}${MAGENTA}  🔽  ${WHITE}$MODEL ${CYAN}$(msg model_downloading)${NC}"
    echo -e "  ${DIM}${AQUA}      $(msg model_download_hint)${NC}"
    echo -e "  ${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${MINT}💜${NEON_GREEN}💜${YELLOW}💜${ORANGE}💜${CORAL}💜${HOT_PINK}💜${NC}"
    echo ""
    ollama pull "$MODEL" 2>/dev/null
    echo ""
    echo -e "  ${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${MINT}💜${NEON_GREEN}💜${YELLOW}💜${ORANGE}💜${CORAL}💜${HOT_PINK}💜${NC}"
    vapor_success "$MODEL $(msg model_dl_done) 🧠🎉"
    echo -e "  ${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${MINT}💜${NEON_GREEN}💜${YELLOW}💜${ORANGE}💜${CORAL}💜${HOT_PINK}💜${NC}"
    echo ""
fi

# =============================================
# Step 5: ファイル配置
# =============================================
step_header 5 "$(msg step5)"

LIB_DIR="${HOME}/.local/lib/vibe-local"
BIN_DIR="${HOME}/.local/bin"

mkdir -p "$LIB_DIR"
mkdir -p "$BIN_DIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "")"

vaporwave_progress "$(msg file_deploy)" 1.5

if [ -n "$SCRIPT_DIR" ] && [ -f "${SCRIPT_DIR}/anthropic-ollama-proxy.py" ]; then
    vapor_info "$(msg source_local)"
    cp "${SCRIPT_DIR}/anthropic-ollama-proxy.py" "$LIB_DIR/"
    cp "${SCRIPT_DIR}/vibe-local.sh" "$BIN_DIR/vibe-local"
else
    REPO_RAW="https://raw.githubusercontent.com/ochyai/vibe-local/main"
    vapor_info "$(msg source_github)"
    curl -fsSL "${REPO_RAW}/anthropic-ollama-proxy.py" -o "$LIB_DIR/anthropic-ollama-proxy.py"
    curl -fsSL "${REPO_RAW}/vibe-local.sh" -o "$BIN_DIR/vibe-local"
fi

chmod +x "$BIN_DIR/vibe-local"
vapor_success "Proxy → $LIB_DIR/"
vapor_success "Command → $BIN_DIR/vibe-local"

# =============================================
# Step 6: 設定ファイル生成
# =============================================
step_header 6 "$(msg step6)"

CONFIG_DIR="${HOME}/.config/vibe-local"
CONFIG_FILE="${CONFIG_DIR}/config"

mkdir -p "$CONFIG_DIR"

vaporwave_progress "$(msg config_gen)" 1

if [ -f "$CONFIG_FILE" ]; then
    vapor_warn "$(msg config_exists)"
else
    cat > "$CONFIG_FILE" << EOF
# vibe-local config
# Auto-generated: $(date '+%Y-%m-%d %H:%M:%S')

MODEL="$MODEL"
PROXY_PORT=8082
OLLAMA_HOST="http://localhost:11434"
EOF
    vapor_success "$(msg config_file): $CONFIG_FILE"
fi

BIN_IN_PATH=0
if echo "$PATH" | grep -q "${HOME}/.local/bin"; then
    BIN_IN_PATH=1
fi

if [ "$BIN_IN_PATH" -eq 0 ]; then
    SHELL_RC=""
    if [ -f "${HOME}/.zshrc" ]; then
        SHELL_RC="${HOME}/.zshrc"
    elif [ -f "${HOME}/.bashrc" ]; then
        SHELL_RC="${HOME}/.bashrc"
    fi

    if [ -n "$SHELL_RC" ]; then
        if ! grep -q '\.local/bin' "$SHELL_RC" 2>/dev/null; then
            echo '' >> "$SHELL_RC"
            echo '# vibe-local' >> "$SHELL_RC"
            echo 'export PATH="${HOME}/.local/bin:${PATH}"' >> "$SHELL_RC"
            vapor_success "$(msg path_added) → $SHELL_RC"
        else
            vapor_success "$(msg path_set)"
        fi
    fi
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# =============================================
# Step 7: 動作確認テスト
# =============================================
step_header 7 "$(msg step7)"

echo ""
echo -e "  ${CYAN}┃${NC} 🔬 ${BOLD}${WHITE}$(msg diag)${NC}"
echo ""

if curl -s --max-time 2 "http://localhost:11434/api/tags" &>/dev/null; then
    vapor_success "Ollama Server       → 🟢 $(msg online)"
else
    vapor_warn "Ollama Server       → 🟡 $(msg standby)"
fi

TEST_STATE_DIR="${HOME}/.local/state/vibe-local"
mkdir -p "$TEST_STATE_DIR" && chmod 700 "$TEST_STATE_DIR"
python3 "$LIB_DIR/anthropic-ollama-proxy.py" 8083 &>"${TEST_STATE_DIR}/test-proxy.log" &
TEST_PID=$!
sleep 2

if curl -s --max-time 2 "http://127.0.0.1:8083/" &>/dev/null; then
    vapor_success "API Proxy           → 🟢 $(msg online)"
else
    vapor_warn "API Proxy           → 🟡 $(msg warning)"
fi
kill "$TEST_PID" 2>/dev/null || true

if command -v claude &>/dev/null; then
    vapor_success "Claude Code CLI     → 🟢 $(msg ready)"
else
    vapor_warn "Claude Code CLI     → 🟡 $(msg path_reopen)"
fi

if curl -s "http://localhost:11434/api/tags" 2>/dev/null | grep -q "$MODEL"; then
    vapor_success "AI Model ($MODEL) → 🟢 $(msg loaded)"
else
    vapor_warn "AI Model            → 🟡 $(msg not_loaded)"
fi

# ╔══════════════════════════════════════════════════════════════╗
# ║  🎆  Ｃ Ｏ Ｍ Ｐ Ｌ Ｅ Ｔ Ｅ !!                         ║
# ╚══════════════════════════════════════════════════════════════╝

echo ""
echo ""

CELEBRATE_FRAMES=(
    "  🎆 🎇 ✨ 💫 🌟 ⭐ 🌟 💫 ✨ 🎇 🎆"
    "  🎇 🎆 💫 ✨ ⭐ 🌟 ⭐ ✨ 💫 🎆 🎇"
    "  ✨ 💫 🎆 🎇 🌟 ⭐ 🌟 🎇 🎆 💫 ✨"
    "  💫 ✨ 🎇 🎆 ⭐ 🌟 ⭐ 🎆 🎇 ✨ 💫"
)
for ((r=0; r<3; r++)); do
    for frame in "${CELEBRATE_FRAMES[@]}"; do
        printf "\r${frame}"
        sleep 0.1
    done
done
echo ""
echo ""

# Massive completion banner (no rigid box to avoid alignment breaks)
echo -e "  ${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${MINT}💜${NEON_GREEN}💜${YELLOW}💜${ORANGE}💜${CORAL}💜${HOT_PINK}💜${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${NC}"
echo ""
rainbow_text "    ██████████████████████████████████████████████████████████"
echo ""
echo -e "          🎉🎉🎉  ${BOLD}${MAGENTA}$(msg complete)${NC}  🎉🎉🎉"
echo ""
rainbow_text "    ██████████████████████████████████████████████████████████"
echo ""
echo -e "  ${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${MINT}💜${NEON_GREEN}💜${YELLOW}💜${ORANGE}💜${CORAL}💜${HOT_PINK}💜${PINK}💜${MAGENTA}💜${PURPLE}💜${CYAN}💜${AQUA}💜${NC}"
echo -e "${NC}"

echo ""
rainbow_text "    ═══════════════════════════════════════════════════════"
echo ""
echo -e "    ${BOLD}${WHITE}🚀 $(msg usage)${NC}"
echo ""
echo -e "    ${PINK}❯${NC} ${BOLD}${CYAN}vibe-local${NC}                     ${DIM}$(msg mode_interactive)${NC}"
echo -e "    ${PINK}❯${NC} ${BOLD}${CYAN}vibe-local -p \"...\"${NC}            ${DIM}$(msg mode_oneshot)${NC}"
echo -e "    ${PINK}❯${NC} ${BOLD}${CYAN}vibe-local --auto${NC}              ${DIM}$(msg mode_auto)${NC}"
echo ""
rainbow_text "    ═══════════════════════════════════════════════════════"
echo ""
echo -e "    ${BOLD}${WHITE}⚙️  $(msg settings)${NC}"
echo -e "    ${PURPLE}┃${NC} $(msg label_model):     ${BOLD}${NEON_GREEN}$MODEL${NC}"
echo -e "    ${PURPLE}┃${NC} $(msg label_config):       ${AQUA}$CONFIG_FILE${NC}"
echo -e "    ${PURPLE}┃${NC} $(msg label_command):   ${AQUA}$BIN_DIR/vibe-local${NC}"
echo ""
rainbow_text "    ═══════════════════════════════════════════════════════"
echo ""
echo -e "    ${YELLOW}${BOLD}⚡ $(msg reopen) ⚡${NC}"
echo ""
echo ""

vapor_text "    $(msg enjoy)"
echo ""
echo ""
