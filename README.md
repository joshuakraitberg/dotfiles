# Instructions

## Pull
```sh
git clone git@github.com:joshuakraitberg/dotfiles.git ~
```

## Bootstrapping for first run
```sh
# pip install pipx
pipx install dotdrop==1.10.3
pipx ensurepath
alias dotdrop='\dotdrop --cfg=$HOME/dotfiles/config.yaml'
```

## Deploy custom dotfiles
```sh
dotdrop install -aD -p home
```

## Importing new files
```sh
# Example:
dotdrop import -l absolute -p home ~/.gitconfig
```