#!/bin/bash
set -e

# 1. Install udev rules FIRST (so your Ledger is recognized immediately)
echo "Setting up Ledger USB permissions..."
wget -q -O - https://raw.githubusercontent.com/LedgerHQ/udev-rules/master/add_udev_rules.sh | sudo bash

# 2. Download the AppImage
echo "Downloading Ledger Live..."
mkdir -p ~/Downloads
wget -q https://download.live.ledger.com/latest/linux -O ~/Downloads/ledger-live.AppImage

# 3. Make it executable
chmod +x ~/Downloads/ledger-live.AppImage

# 4. Launch it in the background
echo "Launching Ledger Live... Please click 'Integrate and Run' in the popup!"
~/Downloads/ledger-live.AppImage &

# 5. Small delay to let the UI pop up before the script closes
sleep 5
