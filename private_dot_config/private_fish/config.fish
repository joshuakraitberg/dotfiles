if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting ""

    # Stuff
    set -xg VISUAL nvim
    set -xg EDITOR nvim

    # Set SUDO_ASKPASS if ksshaskpass is available
    if command -v ksshaskpass &>/dev/null
        set -xg SUDO_ASKPASS (command -v ksshaskpass)
    end

    # Activate atuin (filter out deprecated bind -k syntax)
    atuin init fish | string replace -r '^\s*bind -M insert -k up.*$' '' | source

    # Activate zoxide
    zoxide init fish | source

    # Reload aliases
    source ~/.config/fish/conf.d/aliases.fish
end
