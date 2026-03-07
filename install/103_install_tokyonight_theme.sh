#!/usr/bin/env bash
set -euo pipefail

THEME="Tokyonight-Dark-Storm" # change to Tokyonight-Green-Dark-Storm etc.
TMPDIR="$(mktemp -d -t tokyonight-XXXXXXXX)"
echo "Working dir: $TMPDIR"

echo "installing apparmor"
sudo apt install -y apparmor apparmor-utils
sudo systemctl enable --now apparmor

KEEP_TMPDIR=1

cleanup() {
  if [ "${KEEP_TMPDIR}" -eq 0 ]; then
    rm -rf "$TMPDIR"
  else
    echo "Keeping working dir for inspection: $TMPDIR"
    echo "To inspect: cd \"$TMPDIR\""
  fi
}

trap cleanup EXIT INT TERM

git clone --depth 1 \
  https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme.git \
  "$TMPDIR/Tokyonight-GTK-Theme"

INSTALLER="$TMPDIR/Tokyonight-GTK-Theme/themes/install.sh"
if [ ! -f "$INSTALLER" ]; then
  echo "ERROR: installer not found at: $INSTALLER"
  exit 1
fi

cd "$(dirname "$INSTALLER")"
./install.sh -t all -l --tweaks storm float outline

# Make sure dconf is not wedged (prevents "failed to commit changes" warnings)
pkill dconf-service 2>/dev/null || true
#Apply the theme
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme "$THEME"
gsettings set org.gnome.shell.extensions.user-theme name "$THEME"
gsettings set org.gnome.desktop.wm.preferences theme "$THEME"

KEEP_TMPDIR=0
