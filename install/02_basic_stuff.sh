#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load shared functions
source "$SCRIPT_DIR/../functions.sh"

PACKAGES=(
  "unzip"
  "p7zip"
  "unrar"
  "git"
  "curl"
  "wget"
  "eza"
  "zoxide"
  "fzf"
  "ripgrep"
  "bat"
  "fontconfig"
  "npm"
)

echo "Updating package lists..."
sudo apt update -qq

echo "Checking and installing applications..."

for pkg in "${PACKAGES[@]}"; do
  if is_apt_installed "$pkg"; then
    echo "  ✓ $pkg is already installed."
  else
    echo "  ➜ Installing $pkg..."
    sudo apt install -y -qq "$pkg"
  fi
done

echo "Installation process complete!"
