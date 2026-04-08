#!/usr/bin/env bash
set -euo pipefail

# Directory where this script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update -qq

# System dependencies
sudo apt install -y -qq \
  wget tar git ripgrep fd-find build-essential unzip \
  python3-pip python3-venv python3-full \
  luarocks

# tree sitter in apt is too old. remove if installed and get later version from npm.
sudo apt remove -y tree-sitter-cli 2>/dev/null || true
sudo npm install -g tree-sitter-cli

# Ubuntu installs fd-find as 'fdfind', but many plugins expect 'fd'
sudo ln -sf "$(command -v fdfind)" /usr/local/bin/fd

# Optional: wipe Neovim runtime dirs (keeps ~/.config/nvim intact)
rm -rf ~/.local/share/nvim/ ~/.local/state/nvim/ ~/.cache/nvim/

echo "Installing Neovim (stable tarball to /usr/local)..."

cd /tmp
rm -rf nvim-linux-x86_64 nvim.tar.gz

wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
tar -xf nvim.tar.gz
sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
sudo cp -R nvim-linux-x86_64/lib /usr/local/
sudo cp -R nvim-linux-x86_64/share /usr/local/
rm -rf nvim-linux-x86_64 nvim.tar.gz
cd - >/dev/null

# Python provider venv
mkdir -p ~/.local/share/nvim/venv
python3 -m venv ~/.local/share/nvim/venv
~/.local/share/nvim/venv/bin/pip install -U pip pynvim

echo "Neovim installation complete."
