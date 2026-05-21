#!/usr/bin/env sh

set -e

DOTFILES_REPO="github.com/joshuakraitberg/dotfiles"

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
for cmd in curl git; do
  if ! command_exists "$cmd"; then
    echo "Error: $cmd not found. Please install it and try again."
    exit 1
  fi
done

# Install chezmoi if needed
if ! command_exists chezmoi; then
  echo "Installing chezmoi..."

  # Detect package manager
  if command_exists pacman; then
    pm="pacman"
  elif command_exists apt-get; then
    pm="apt"
  else
    pm=""
  fi

  case "$pm" in
    pacman)
      sudo pacman -S --noconfirm chezmoi
      ;;
    apt)
      (cd /tmp && sh -c "$(curl -fsLS get.chezmoi.io)" && sudo mv bin/chezmoi /usr/local/bin/)
      ;;
    *)
      echo "Error: Unknown package manager. Install chezmoi manually: https://www.chezmoi.io/install/"
      exit 1
      ;;
  esac
fi

# Initialize and apply
if [ ! -e ~/.config/chezmoi/chezmoi.yaml ]; then
  echo "Initializing chezmoi..."
  chezmoi init "${DOTFILES_REPO}" -v
fi

echo "Applying dotfiles..."
chezmoi apply -v
