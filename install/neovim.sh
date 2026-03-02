#!/bin/bash
set -e

echo "Installing Neovim and Python dependencies..."
# python3-venv is critical on Ubuntu 24.04 for isolated environments
sudo apt update
sudo apt install -y libfuse2t64 make gcc python3-pip python3-venv python3-full luarocks tree-sitter-cli

# 1. Install Neovim (AppImage v0.11.6)
cd /tmp
wget -q -O nvim.appimage https://github.com/neovim/neovim/releases/download/v0.11.6/nvim-linux-x86_64.appimage
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# 2. Install the 'pynvim' provider (needed for some Python plugins)
# We use --break-system-packages or a venv; for a dev setup, a dedicated venv is cleaner
python3 -m pip install --user --upgrade pynvim --break-system-packages || true

# 3. Setup LazyVim Starter (if not exists)
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi

# 4. Enable the Python "Extra" in LazyVim
# This tells LazyVim to automatically install Pyright (LSP) and Ruff (Linter/Formatter)
if [ -f "$HOME/.config/nvim/lua/config/lazy.lua" ]; then
  # This uses 'sed' to uncomment the python extra in the LazyVim config
  sed -i 's/-- { import = "lazyvim.plugins.extras.lang.python" }/{ import = "lazyvim.plugins.extras.lang.python" }/' "$HOME/.config/nvim/lua/config/lazy.lua"
fi

echo "Neovim Python Environment Setup Complete!"
