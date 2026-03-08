#!/bin/bash
set -e

# Returns true (0) if the APT package is installed
is_apt_installed() {
  dpkg -s "$1" >/dev/null 2>&1
}

# Returns true (0) if the Snap package is installed
is_snap_installed() {
  snap list "$1" >/dev/null 2>&1
}

# Returns true (0) if the Flatpak ID is installed
is_flatpak_installed() {
  flatpak info "$1" >/dev/null 2>&1
}

# Returns true (0) if the command/binary exists in the system path
is_command_installed() {
  command -v "$1" >/dev/null 2>&1
}

# Returns true (0) if the specific file/AppImage exists
is_file_installed() {
  [ -f "$1" ]
}

# Returns true if any file exists, can be used with wildcard *
is_any_file_installed() {
  (
    ls $1 >/dev/null 2>&1
  )
}
