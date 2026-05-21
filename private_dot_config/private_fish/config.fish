if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting ""

    # Stuff
    set -xg VISUAL nvim
    set -xg EDITOR nvim

    # Activate atuin (filter out deprecated bind -k syntax)
    atuin init fish | string replace -r '^\s*bind -M insert -k up.*$' '' | source

    # Activate zoxide
    zoxide init fish | source

    # Add bun
    fish_add_path -a $HOME/.bun/bin

    # Reload aliases
    source ~/.config/fish/conf.d/aliases.fish

    # Nag for pending chezmoi changes
    if test -n "$(chezmoi diff --exclude=scripts 2>/dev/null)"
        echo "chezmoi: pending file changes"
    end
    if test -n "$(chezmoi diff --include=scripts 2>/dev/null)"
        echo "chezmoi: pending scripts"
    end
end
