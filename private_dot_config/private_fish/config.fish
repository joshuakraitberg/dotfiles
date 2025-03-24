if status is-interactive
    # Commands to run in interactive sessions can go here
    set -U fish_greeting ""

    # Activate atuin
    atuin init fish | source

    # Reload aliases
    source ~/.config/fish/conf.d/aliases.fish
end
