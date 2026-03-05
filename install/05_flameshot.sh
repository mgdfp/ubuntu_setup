#!/bin/bash
set -e

# Flameshot is a nice step-up over the default Gnome screenshot tool
echo "installing flameshot..."
sudo apt install -y -qq flameshot >/dev/null 2>&1
