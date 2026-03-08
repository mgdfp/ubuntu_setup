#!/bin/bash
set -e

# Get the directory where this script actually lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Load shared functions
source "$SCRIPT_DIR/../functions.sh"

if is_snap_installed "bitwarden"; then
  echo "  ✓ Bitwarden is already installed."
else
  echo "  ➜ Installing Bitwarden..."
  sudo snap install bitwarden
fi

echo "Bitwarden setup complete!"
