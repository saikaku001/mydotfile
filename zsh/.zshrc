# .zshrc

# ============================================================
# Oh My Zsh
# ============================================================
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
)

source $ZSH/oh-my-zsh.sh

# ============================================================
# エディタ
# ============================================================
export EDITOR="nvim"
export VISUAL="nvim"

# ============================================================
# Neovim エイリアス
# ============================================================
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

# dotfile を直接編集
alias vz="nvim ~/.zshrc"
alias vv="nvim ~/.config/nvim/init.lua"
alias vzr="source ~/.zshrc"   # .zshrc をリロード

# ============================================================
# ナビゲーション
# ============================================================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# ============================================================
# OS 判定
# ============================================================
if [[ "$OSTYPE" == "darwin"* ]]; then
  IS_MAC=true
else
  IS_MAC=false
fi

# ============================================================
# ファイル・ディレクトリ操作
# ============================================================
# macOS の ls はデフォルトで --color=auto 非対応のため -G を使用
# GNU coreutils (gls) がある場合はそちらを優先
if $IS_MAC; then
  if command -v gls &>/dev/null; then
    alias ls="gls --color=auto"
  else
    alias ls="ls -G"
  fi
else
  alias ls="ls --color=auto"
fi
alias ll="ls -lh"
alias la="ls -lAh"
alias lf="ls -lAh | grep"        # ファイル名でフィルタ: lf <キーワード>
alias mkdir="mkdir -pv"           # 親ディレクトリも自動作成 & 詳細表示
alias cp="cp -iv"                 # 上書き前に確認 & 詳細表示
alias mv="mv -iv"                 # 上書き前に確認 & 詳細表示
alias rm="rm -iv"                 # 削除前に確認 & 詳細表示

# ============================================================
# Git
# ============================================================
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gca="git commit --amend --no-edit"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpl="git pull"
alias gf="git fetch --prune"
alias gd="git diff"
alias gds="git diff --staged"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gbr="git branch"
alias gbrd="git branch -d"
alias gbrD="git branch -D"
alias glg="git log --oneline --graph --decorate --all"
alias gst="git stash"
alias gstp="git stash pop"
alias gstl="git stash list"
alias grb="git rebase"
alias grbi="git rebase -i"
alias grs="git restore"
alias grss="git restore --staged"

# lazygit
alias lg="lazygit"

# ============================================================
# プロセス・システム
# ============================================================
alias ports="lsof -i -P -n | grep LISTEN"   # 使用中ポート一覧
alias myip="curl -s https://ipinfo.io/ip"    # 外部 IP アドレス確認
alias psg="ps aux | grep"                    # プロセス検索: psg <キーワード>
alias df="df -h"
alias du="du -sh"

# ============================================================
# macOS 向け
# ============================================================
if $IS_MAC; then
  alias brewup="brew update && brew upgrade && brew cleanup"
  alias flushdns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
  alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
  alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"

  # macOS クリップボード
  alias pbp="pbpaste"
  alias pbc="pbcopy"
fi

# ============================================================
# Linux 向け
# ============================================================
if ! $IS_MAC; then
  # パッケージマネージャのアップデート (apt / pacman / dnf を自動判別)
  if command -v apt &>/dev/null; then
    alias sysup="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
  elif command -v pacman &>/dev/null; then
    alias sysup="sudo pacman -Syu"
  elif command -v dnf &>/dev/null; then
    alias sysup="sudo dnf upgrade -y"
  fi

  # DNS キャッシュフラッシュ
  alias flushdns="sudo systemd-resolve --flush-caches 2>/dev/null || sudo resolvectl flush-caches"

  # クリップボード (Wayland / X11 を自動判別)
  if command -v wl-copy &>/dev/null; then
    alias pbcopy="wl-copy"
    alias pbpaste="wl-paste"
  elif command -v xclip &>/dev/null; then
    alias pbcopy="xclip -selection clipboard"
    alias pbpaste="xclip -selection clipboard -o"
  elif command -v xsel &>/dev/null; then
    alias pbcopy="xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
  fi
  alias pbc="pbcopy"
  alias pbp="pbpaste"

  # ファイルマネージャでディレクトリを開く (macOS の open 相当)
  if command -v xdg-open &>/dev/null; then
    alias open="xdg-open"
  fi
fi

# ============================================================
# ユーティリティ関数
# ============================================================

# ディレクトリを作成してすぐ移動
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ghq + fzf でリポジトリを素早く移動 (ghq + fzf が必要)
repo() {
  local dir
  dir=$(ghq list | fzf --preview "ls $(ghq root)/{}")
  [ -n "$dir" ] && cd "$(ghq root)/$dir"
}

# fzf でブランチ切り替え
gswf() {
  local branch
  branch=$(git branch -a | grep -v HEAD | fzf --height 40% | sed 's/remotes\/origin\///' | tr -d '[:space:]')
  [ -n "$branch" ] && git switch "$branch"
}
