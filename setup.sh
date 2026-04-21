#!/usr/bin/env bash
# setup.sh — neovim & oh-my-zsh のワンタッチセットアップスクリプト
# 使い方: bash setup.sh

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ============================================================
# ユーティリティ
# ============================================================
info()    { echo "[INFO]  $*"; }
success() { echo "[OK]    $*"; }
warn()    { echo "[WARN]  $*"; }
error()   { echo "[ERROR] $*" >&2; exit 1; }

command_exists() { command -v "$1" &>/dev/null; }

# OS 判定
if [[ "$OSTYPE" == "darwin"* ]]; then
  IS_MAC=true
else
  IS_MAC=false
fi

# ============================================================
# 1. パッケージマネージャ / 依存ツールのインストール
# ============================================================
install_dependencies() {
  info "依存パッケージをインストールしています..."

  if $IS_MAC; then
    # Homebrew がなければインストール
    if ! command_exists brew; then
      info "Homebrew をインストールしています..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # zsh がなければインストール (macOS はデフォルトで入っているが念のため)
    command_exists zsh || brew install zsh

    # neovim
    if ! command_exists nvim; then
      info "Neovim をインストールしています..."
      brew install neovim
    else
      success "Neovim は既にインストール済みです ($(nvim --version | head -1))"
    fi

    # git (lazy.nvim のクローンに必要)
    command_exists git || brew install git

    # lazygit (.zshrc の lg エイリアスが参照)
    command_exists lazygit || brew install lazygit

    # ghq / fzf (repo() 関数・gswf() 関数が参照)
    command_exists ghq || brew install ghq
    command_exists fzf || brew install fzf

  else
    # Linux: apt / pacman / dnf を自動判別
    if command_exists apt; then
      sudo apt update -y
      local pkgs=()
      command_exists zsh    || pkgs+=(zsh)
      command_exists nvim   || pkgs+=(neovim)
      command_exists git    || pkgs+=(git)
      command_exists curl   || pkgs+=(curl)
      command_exists fzf    || pkgs+=(fzf)
      [ ${#pkgs[@]} -gt 0 ] && sudo apt install -y "${pkgs[@]}"

      if ! command_exists lazygit; then
        info "lazygit をインストールしています..."
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
          | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
        curl -Lo /tmp/lazygit.tar.gz \
          "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar -xf /tmp/lazygit.tar.gz -C /tmp lazygit
        sudo install /tmp/lazygit /usr/local/bin
      fi

      if ! command_exists ghq; then
        info "ghq をインストールしています..."
        GHQ_VERSION=$(curl -s "https://api.github.com/repos/x-motemen/ghq/releases/latest" \
          | grep '"tag_name"' | sed 's/.*"v\([^"]*\)".*/\1/')
        curl -Lo /tmp/ghq.zip \
          "https://github.com/x-motemen/ghq/releases/download/v${GHQ_VERSION}/ghq_linux_amd64.zip"
        unzip -o /tmp/ghq.zip ghq_linux_amd64/ghq -d /tmp
        sudo install /tmp/ghq_linux_amd64/ghq /usr/local/bin
      fi

    elif command_exists pacman; then
      local pkgs=()
      command_exists zsh      || pkgs+=(zsh)
      command_exists nvim     || pkgs+=(neovim)
      command_exists git      || pkgs+=(git)
      command_exists curl     || pkgs+=(curl)
      command_exists fzf      || pkgs+=(fzf)
      command_exists lazygit  || pkgs+=(lazygit)
      command_exists ghq      || pkgs+=(ghq)
      [ ${#pkgs[@]} -gt 0 ] && sudo pacman -Syu --noconfirm "${pkgs[@]}"

    elif command_exists dnf; then
      local pkgs=()
      command_exists zsh    || pkgs+=(zsh)
      command_exists nvim   || pkgs+=(neovim)
      command_exists git    || pkgs+=(git)
      command_exists curl   || pkgs+=(curl)
      command_exists fzf    || pkgs+=(fzf)
      [ ${#pkgs[@]} -gt 0 ] && sudo dnf install -y "${pkgs[@]}"

    else
      warn "対応するパッケージマネージャが見つかりませんでした。手動で zsh / neovim / git / curl をインストールしてください。"
    fi
  fi

  success "依存パッケージのインストール完了"
}

# ============================================================
# 2. シンボリックリンクの作成（バックアップ付き）
# ============================================================
create_symlink() {
  local src="$1"
  local dst="$2"

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    if [ "$(readlink -f "$dst" 2>/dev/null)" = "$src" ]; then
      success "シンボリックリンク済み: $dst -> $src"
      return
    fi
    local backup="${dst}.bak.$(date +%Y%m%d_%H%M%S)"
    warn "既存ファイルをバックアップ: $dst -> $backup"
    mv "$dst" "$backup"
  fi

  ln -sfn "$src" "$dst"
  success "シンボリックリンク作成: $dst -> $src"
}

# ============================================================
# 3. Oh My Zsh のインストール
# ============================================================
install_ohmyzsh() {
  if [ -d "$HOME/.oh-my-zsh" ]; then
    success "Oh My Zsh は既にインストール済みです"
  else
    info "Oh My Zsh をインストールしています..."
    # RUNZSH=no : インストール後に zsh を起動しない
    # CHSH=no   : デフォルトシェルを自動変更しない（後で手動で設定）
    RUNZSH=no CHSH=no sh -c \
      "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    success "Oh My Zsh インストール完了"
  fi
}

# ============================================================
# 4. Zsh プラグインのインストール
# ============================================================
install_zsh_plugins() {
  local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  # zsh-autosuggestions
  local autosugg_dir="$zsh_custom/plugins/zsh-autosuggestions"
  if [ -d "$autosugg_dir" ]; then
    success "zsh-autosuggestions は既にインストール済みです"
  else
    info "zsh-autosuggestions をインストールしています..."
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$autosugg_dir"
    success "zsh-autosuggestions インストール完了"
  fi

  # zsh-syntax-highlighting
  local syntax_dir="$zsh_custom/plugins/zsh-syntax-highlighting"
  if [ -d "$syntax_dir" ]; then
    success "zsh-syntax-highlighting は既にインストール済みです"
  else
    info "zsh-syntax-highlighting をインストールしています..."
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$syntax_dir"
    success "zsh-syntax-highlighting インストール完了"
  fi
}

# ============================================================
# 5. dotfile シンボリックリンクの作成
# ============================================================
link_dotfiles() {
  info "dotfile のシンボリックリンクを作成しています..."

  # .zshrc
  create_symlink "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"

  # neovim 設定
  mkdir -p "$HOME/.config"
  create_symlink "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
}

# ============================================================
# 6. デフォルトシェルを zsh に変更
# ============================================================
set_default_shell() {
  local zsh_path
  zsh_path="$(command -v zsh)"

  if [ "$SHELL" = "$zsh_path" ]; then
    success "デフォルトシェルは既に zsh です"
    return
  fi

  info "デフォルトシェルを zsh に変更しています..."

  # /etc/shells に zsh が登録されていなければ追加
  if ! grep -qx "$zsh_path" /etc/shells; then
    echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
  fi

  chsh -s "$zsh_path"
  success "デフォルトシェルを $zsh_path に変更しました (次回ログイン時から有効)"
}

# ============================================================
# メイン
# ============================================================
main() {
  echo "========================================"
  echo "  mydotfile セットアップスクリプト"
  echo "========================================"
  echo ""

  install_dependencies
  echo ""

  install_ohmyzsh
  echo ""

  install_zsh_plugins
  echo ""

  link_dotfiles
  echo ""

  set_default_shell
  echo ""

  echo "========================================"
  success "セットアップ完了！"
  echo ""
  echo "次のステップ:"
  echo "  1. ターミナルを再起動して zsh を反映させてください"
  echo "  2. nvim を起動すると lazy.nvim が自動でプラグインをインストールします"
  echo "========================================"
}

main "$@"
