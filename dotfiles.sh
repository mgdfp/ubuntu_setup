#!/bin/bash
set -e

# Define the absolute path to your dotfiles directory

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR/dotfiles"

echo "Creating symlinks for your environment..."

# 1. Ensure the base .config directory exists
mkdir -p ~/.config

# 2. Link home directory files
ln -sfn "$DOTFILES_DIR/.bashrc" ~/.bashrc
ln -sfn "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
ln -sfn "$DOTFILES_DIR/.gitignore_global" ~/.gitignore_global

# 3. Link application config directories
ln -sfn "$DOTFILES_DIR/nvim" ~/.config/nvim
ln -sfn "$DOTFILES_DIR/alacritty" ~/.config/alacritty
ln -sfn "$DOTFILES_DIR/zellij" ~/.config/zellij

echo "Success! Your dotfiles are securely linked."
