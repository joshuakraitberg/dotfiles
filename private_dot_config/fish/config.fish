if test -r ~/.config/fish/secrets.fish
    source ~/.config/fish/secrets.fish
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting ""

    # Stuff
    set -xg VISUAL nvim
    set -xg EDITOR nvim

    # Set SUDO_ASKPASS: zenity by default, fall back to ksshaskpass
    if set -q SUDO_ASKPASS
        # already set, leave it
    else if command -v zenity &>/dev/null
        set -xg SUDO_ASKPASS ~/.local/bin/sudo-askpass
    else if command -v ksshaskpass &>/dev/null
        set -xg SUDO_ASKPASS (command -v ksshaskpass)
    end

    # Activate bun
    fish_add_path ~/.bun/bin

    # Activate atuin (filter out deprecated bind -k syntax)
    atuin init fish | string replace -r '^\s*bind -M insert -k up.*$' '' | source

    # Activate zoxide
    zoxide init fish | source

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
