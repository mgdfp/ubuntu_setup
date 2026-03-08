#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load shared functions
source "$SCRIPT_DIR/../functions.sh"

# 1. Install Zellij if not present
if is_snap_installed "zellij"; then
  echo "  ✓ Zellij is already installed."
else
  echo "  ➜ Installing Zellij..."
  sudo snap install zellij --classic
fi

echo "Zellij setup complete!"
