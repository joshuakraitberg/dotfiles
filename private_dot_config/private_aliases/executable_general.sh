#!/usr/bin/env sh

# System
alias g='git'
alias k='kubectl'
alias vim='nvim'
alias v='nvim'
alias m='make'
alias h='htop'
alias s='sudo '
alias sudo='sudo '
alias sdn='sudo shutdown -h now'
alias srn='sudo reboot'
alias hg='history 0 | grep --color=auto'
alias vv='vim ~/.config/nvim/lua/config/lazy.lua'
alias tt='vim ~/.tmux.conf'
alias zz="vim ~/.zshrc"
alias zp="vim ~/.zprofile"
alias rr="source ~/.zprofile"
alias pg='ps -ef | grep'
alias svim="sudo -E $(which nvim) "
alias mine='chown $USER:$USER'
alias mkroot='chown root:root'
alias nkey='ssh-keygen -t ed25519 -a 200 -C "${USER}@${HOST}"'
alias opt='sudo watch -n 1 iptables -vnL'
alias optt='sudo watch -n 1 ip6tables -vnL'
alias exa='eza'
alias ls='exa -g'
alias ll='exa -lg'
alias la='exa -laag'
alias lt='exa -lagT'
alias pf='fzf --preview "bat --style=numbers --color=always --line-range :500 {}"'
# Delete all orphans + configuration
alias pqra='sudo pacman -Qtdq | sudo pacman -Rns -'

# chezmoi
alias czc='cd ~/.local/share/chezmoi'
alias cza='chezmoi apply -v'
alias czu='chezmoi update -v'
alias czd='chezmoi diff'
alias czm='chezmoi merge-all'

# Check GPG works
alias gg='echo "test" | gpg --clearsign'

# python
pushv() {
  # Make and activate venv for cwd
  set -x
  DEFAULT=$(python3 --version | cut -d ' ' -f 2)
  VERSION=${1:-$DEFAULT}
  BASE=$(basename "$(pwd)")
  NAME="${BASE}-${VERSION}"
  pyenv install -s "$VERSION" && {
    echo n | pyenv virtualenv "$VERSION" "$NAME" 2>/dev/null
    pyenv local "$NAME"
    pyenv activate
  }
}

popv() {
  # Remove venv for cwd
  set -x
  DEFAULT=$(python3 --version | cut -d ' ' -f 2)
  VERSION=${1:-$DEFAULT}
  BASE=$(basename "$(pwd)")
  NAME="${BASE}-${VERSION}"
  pyenv virtualenv-delete "$NAME"
  rm .python-version
}

# tmux
alias bye='tmux detach'
alias tst='if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then; tmux new-session -A -s main; else; echo "Already using TMUX"; (exit 1); fi'

# File ops
alias cp='cp -iv'
alias mv='mv -iv'
alias mkd='mkdir -pv'

## Colorize grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
