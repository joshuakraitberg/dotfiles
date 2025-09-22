if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting ""

    # Stuff
    set -xg VISUAL nvim
    set -xg EDITOR nvim

    # Activate atuin
    atuin init fish | source

    # Activate zoxide
    zoxide init fish | source

    # Reload aliases
    source ~/.config/fish/conf.d/aliases.fish
end
