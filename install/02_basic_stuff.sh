#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load shared functions
source "$SCRIPT_DIR/../functions.sh"

# ... rest of your script
PACKAGES=(
  "ubuntu-restricted-extras"
  "unzip"
  "p7zip"
  "unrar"
  "git"
  "gitk"
  "meld"
  "curl"
  "wget"
  "eza"
  "zoxide"
  "fzf"
  "ripgrep"
  "bat"
  "wl-clipboard"
  "flameshot"
  "vlc"
  "npm"
)

echo "Updating package lists..."
sudo apt update -qq

echo "Checking and installing applications..."

# 2. Loop through the list and check if the app is already installed, skip if it is.
for pkg in "${PACKAGES[@]}"; do
  if is_apt_installed "$pkg"; then
    echo "  ✓ $pkg is already installed."
  else
    echo "  ➜ Installing $pkg..."
    # Note: ubuntu-restricted-extras may prompt for a EULA agreement
    sudo apt install -y -qq "$pkg"
  fi
done

echo "Installation process complete!"
