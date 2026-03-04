#!/bin/bash
set -e

echo "Configuring Dock Favorites..."

# 1. Your desired apps (in order from top to bottom / left to right)
apps=(
  "google-chrome.desktop"
  "org.gnome.Terminal.desktop"
  "org.gnome.Nautilus.desktop"
  "code.desktop"
  "nvim.desktop"
  "obsidian_obsidian.desktop"
  "xournalpp.desktop"
  "whatsapp.desktop"
  "zapzap_zapzap.desktop"
  "ledger-live.desktop"
  "org.gnome.Settings.desktop"
  "org.gnome.BitWarden.desktop"
)

installed_apps=()

# 2. Directories to search (Added the Snap directory)
desktop_dirs=(
  "/usr/share/applications"
  "/usr/local/share/applications"
  "$HOME/.local/share/applications"
  "/var/lib/flatpak/exports/share/applications"
  "/var/lib/snapd/desktop/applications"
)

# 3. Verify existence before adding
for app in "${apps[@]}"; do
  for dir in "${desktop_dirs[@]}"; do
    if [ -f "$dir/$app" ]; then
      installed_apps+=("$app")
      break
    fi
  done
done

# 4. Format and apply
favorites_list=$(printf "'%s'," "${installed_apps[@]}")
favorites_list="[${favorites_list%,}]"

gsettings set org.gnome.shell favorite-apps "$favorites_list"

echo "Dock configured successfully!"
