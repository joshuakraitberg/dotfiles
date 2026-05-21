# Dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Bootstrap

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/joshuakraitberg/dotfiles/refs/heads/master/bootstrap.sh)"
```

## Usage

```sh
chezmoi diff      # See changes
chezmoi apply -v  # Apply changes
chezmoi update -v # Pull and apply
```

Aliases:

```sh
czc  # cd to chezmoi dir
cza  # apply
czu  # update
czd  # diff
```

## Adding Files

```sh
chezmoi add ~/.bashrc
chezmoi add --template ~/.gitconfig  # If needs templating
```

## Adding Packages

Edit `.chezmoidata/packages.yaml` and run `chezmoi apply -v`.
