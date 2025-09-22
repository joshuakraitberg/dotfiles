#!/usr/bin/env sh

set -e

DOTFILES_REPO="github.com/joshuakraitberg/dotfiles"

which() {
  sh -c -- "which $1 >/dev/null 2>&1"
}

if ! which chezmoi; then
  echo "Installing chezmoi..."

  if which pacman; then
    sudo pacman -S --noconfirm chezmoi
  elif which snap; then
    sudo snap install chezmoi --classic
  elif which apt-get; then
    (cd /tmp && sh -c "$(curl -fsLS get.chezmoi.io)" && sudo mv bin/chezmoi /usr/local/bin/)
  else
    echo 'Unknown package manager, cannot install chezmoi'
    exit 1
  fi
fi

# Only init first time
if [ ! -e ~/.config/chezmoi/chezmoi.yaml ]; then
  echo "Initializing chezmoi..."
  chezmoi init "${DOTFILES_REPO}" -v
fi

echo "Applying dotfiles..."
chezmoi apply -v
