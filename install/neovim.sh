#!/bin/bash
set -e

echo "Installing Neovim, Python, and Shell dependencies..."

# 1. Install System Dependencies (added npm and unzip for Mason)
sudo apt update
sudo apt install -y libfuse2t64 make gcc python3-pip python3-venv python3-full \
  luarocks tree-sitter-cli git ripgrep fd-find build-essential npm unzip

# 2. Install Neovim (AppImage)
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod +x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# 3. Setup Dedicated Python Provider Environment
mkdir -p ~/.local/share/nvim/venv
python3 -m venv ~/.local/share/nvim/venv
~/.local/share/nvim/venv/bin/pip install pynvim

# 4. Setup LazyVim Starter
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi

# 5. Enable Python and Shell "Extras"
mkdir -p "$HOME/.config/nvim/lua/plugins"
cat <<EOF > "$HOME/.config/nvim/lua/plugins/languages.lua"
return {
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.sh" }
}
EOF

# 6. Point Neovim to the dedicated Python provider
mkdir -p "$HOME/.config/nvim/lua/config"
cat <<EOF >> "$HOME/.config/nvim/lua/config/options.lua"
vim.g.python3_host_prog = vim.fn.expand("~/.local/share/nvim/venv/bin/python")
EOF

echo "Neovim Setup Complete! Run 'nvim' to bootstrap the plugins."
