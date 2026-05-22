#!/usr/bin/env sh

set -e

DOTFILES_REPO_ROOT="joshuakraitberg/dotfiles"
DOTFILES_REPO="https://github.com/${DOTFILES_REPO_ROOT}.git"
DOTFILES_REPO_SSH="git@github.com:${DOTFILES_REPO_ROOT}.git"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

install_chezmoi() {
  if command_exists pacman; then
    sudo pacman -S --noconfirm chezmoi
  else
    (cd /tmp && sh -c "$(curl -fsLS get.chezmoi.io)" && sudo mv bin/chezmoi /usr/local/bin/)
  fi
}

for cmd in curl git; do
  command_exists "$cmd" || {
    echo "Error: $cmd not found"
    exit 1
  }
done

command_exists chezmoi || {
  echo "Installing chezmoi..."
  install_chezmoi
}

cd "$(dirname "$0")"

echo "Initializing chezmoi..."
_origin="$(git remote get-url origin 2>/dev/null || true)"
if [ "$_origin" = "$DOTFILES_REPO" ] || [ "$_origin" = "$DOTFILES_REPO_SSH" ]; then
  chezmoi init -v
else
  chezmoi init "${DOTFILES_REPO}" -v
fi

echo "Applying dotfiles..."
chezmoi apply -v
