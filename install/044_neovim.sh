#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update

echo "Installing Neovim, Python, and Shell dependencies..."

# 1. Install System Dependencies
sudo apt install -y libfuse2t64 make gcc python3-pip python3-venv python3-full \
  luarocks tree-sitter-cli git ripgrep fd-find build-essential npm unzip

# Ubuntu installs fd-find as 'fdfind', but Neovim plugins hardcode the command 'fd'.
# This system-wide symlink ensures plugins like Telescope can actually find it.
sudo ln -sf $(which fdfind) /usr/local/bin/fd

# 2. Install Neovim (AppImage)
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

# 3. Setup Dedicated Python Provider Environment
mkdir -p ~/.local/share/nvim/venv
python3 -m venv ~/.local/share/nvim/venv
~/.local/share/nvim/venv/bin/pip install pynvim

echo "Neovim Setup Complete! Run 'nvim' to bootstrap the plugins."
