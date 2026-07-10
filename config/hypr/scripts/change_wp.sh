#!/usr/bin/env bash

WP_DIR="$HOME/Pictures/desktops/"

change_wp() {
  if [ -z "$1" ]; then
    # Random picture
    PIC=$(find "$WP_DIR" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.gif' \) | shuf -n 1)
  else
    PIC="$1"
  fi

  wallust run $PIC --backend wal -s
  noctalia msg wallpaper-set "${PIC}"
  # xrdb -merge ~/.cache/wal/dwm-templ
  # xdotool key super+ctrl+backslash
  printf "%s\n" "$PIC"
}

change_wp "$@"
