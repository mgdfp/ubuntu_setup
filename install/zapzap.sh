#!/bin/bash
set -e

# Install ZapZap via Snap (much smoother than Flatpak for scripts)
sudo snap install zapzap

echo "ZapZap installed. To enable minimize-on-close:"
echo "1. Open ZapZap from your menu."
echo "2. Go to Settings (Gear Icon)."
echo "3. Check 'Run in background' and 'Close to tray'."
