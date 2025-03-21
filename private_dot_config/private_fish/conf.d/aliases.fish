# general
alias g='git'
alias k='kubectl'
alias mine='chown $USER:$USER'
alias mkroot='chown root:root'

# configs
alias vv='vim ~/.config/nvim/lua/config/lazy.lua'
alias tt='vim ~/.tmux.conf'
alias zz="vim ~/.config/fish/config.fish"
alias aa="vim ~/.config/fish/conf.d/aliases.fish"
alias zp="vim ~/.zprofile"
alias rr="source ~/.config/fish/config.fish"

# files
alias ls='eza -g'
alias ll='eza -lg'
alias la='eza -laag'
alias lt='eza -lagT'

# file ops
alias mkd='mkdir -pv'

# grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# vim
alias v='nvim'
alias vim='nvim'
alias svim="sudo -E $(which nvim) "

# tmux
alias bye='tmux detach'

function tst
    if command -v tmux >/dev/null 2>&1 && status is-interactive && not string match -q "*screen*" "$TERM" && not string match -q "*tmux*" "$TERM" && [ -z "$TMUX" ]
        tmux new-session -A -s main
    end
end

# kubernetes
if which kubecolor &>/dev/null
    function kubectl
        kubecolor $argv
    end
end

# chezmoi
alias czc='cd ~/.local/share/chezmoi'
alias cza='chezmoi apply -v'
alias czu='chezmoi update -v'
alias czd='chezmoi diff'
alias czm='chezmoi merge-all'
