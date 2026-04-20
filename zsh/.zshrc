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
# ファイル・ディレクトリ操作
# ============================================================
alias ls="ls --color=auto"        # macOS の場合は gls または ls -G に変更
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
alias brewup="brew update && brew upgrade && brew cleanup"
alias flushdns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"

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
