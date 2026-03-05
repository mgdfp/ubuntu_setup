#!/bin/bash
set -e

echo "Configuring Dock Favorites..."

# 1. Your desired apps (in order from top to bottom / left to right)
apps=(
  "google-chrome.desktop"
  "Alacritty.desktop"
  "org.gnome.Nautilus.desktop"
  "code_code.desktop"
  "obsidian_obsidian.desktop"
  "com.github.xournalpp.xournalpp.desktop"
  "spotify_spotify.desktop"
  "bitwarden_bitwarden.desktop"
  "org.gnome.Settings.desktop"
  "nvim.desktop"
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

# fix dock behaviour so that if clicking when an app is open it get minimized. if several windows are open a preview is shown.
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'

# setting up so that if we press alt+1 it will open the first app in the dock and so on.
echo "Setting Alt+Number shortcuts for the dock..."
for i in {1..9}; do
  gsettings set org.gnome.shell.keybindings "switch-to-application-$i" "['<Alt>$i']"
done

echo "Dock configured successfully!"
