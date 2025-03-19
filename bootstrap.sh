#!/usr/bin/env sh

set -e

DOTFILES_REPO="github.com/joshuakraitberg/dotfiles"

# Do nothing if chezmoi data is present already
[ ! -e ~/.config/chezmoi/chezmoi.yaml ] || {
  echo "chezmoi is already configured"
  exit 0
}

# Install required packages
if which pacman; then
  sudo pacman -S --noconfirm chezmoi
elif which apt-get; then
  (cd ~ && sh -c "$(curl -fsLS get.chezmoi.io)")
  PATH="~/bin:$PATH"
else
  echo 'Unknown package manager, cannot install chezmoi'
  exit 1
fi

# Init and deploy
chezmoi init "${DOTFILES_REPO}" --apply -v
