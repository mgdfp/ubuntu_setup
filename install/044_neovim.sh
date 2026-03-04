#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update

echo "Installing Neovim, Python, and Shell dependencies..."

# 1. Install System Dependencies
sudo apt install -y libfuse2t64 make gcc python3-pip python3-venv python3-full \
  luarocks tree-sitter-cli git ripgrep fd-find build-essential npm unzip

# 2. Install Neovim (AppImage)
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod +x nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

# 3. Setup Dedicated Python Provider Environment
mkdir -p ~/.local/share/nvim/venv
python3 -m venv ~/.local/share/nvim/venv
~/.local/share/nvim/venv/bin/pip install pynvim

# 4. Setup LazyVim Starter
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi

# 5. Apply custom languages config
mkdir -p "$HOME/.config/nvim/lua/plugins"

cp "$SCRIPT_DIR/../configs/languages.lua" ~/.config/nvim/lua/plugins/languages.lua
cp "$SCRIPT_DIR/../configs/avante.lua" ~/.config/nvim/lua/plugins/avante.lua

# 6. Apply custom options config - FIXED DESTINATION PATH
mkdir -p "$HOME/.config/nvim/lua/config"
cp "$SCRIPT_DIR/../configs/options.lua" ~/.config/nvim/lua/config/options.lua

echo "Setting up Gemini API key..."
if ! grep -q "GEMINI_API_KEY" ~/.bashrc; then
  echo 'export GEMINI_API_KEY="AIzaSyBHwCa-QecXMfYsWM76ghKXfgm2zi4pDqA"' >>~/.bashrc
  echo "API key added to .bashrc."
else
  echo "API key already exists in .bashrc."
fi
echo "Neovim Setup Complete! Run 'nvim' to bootstrap the plugins."
