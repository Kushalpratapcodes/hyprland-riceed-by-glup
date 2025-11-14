#!/usr/bin/env bash
# Choose a random wallpaper and lock using hyprlock
set -euo pipefail

# Configure this folder or export WALLPAPER_DIR beforehand
WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/Pictures/Wallpapers}"
TARGET="$HOME/.config/hypr/hyprlock/current_wallpaper.jpg"
# extensions to consider
shopt -s nullglob
files=()
while IFS= read -r -d $'\0' f; do files+=("$f"); done < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) -print0)

if [ ${#files[@]} -eq 0 ]; then
  # fallback image (adjust path as desired)
  fallback="$HOME/.config/hypr/hyprlock/fallback.jpg"
  if [ -f "$fallback" ]; then
    cp -f "$fallback" "$TARGET"
  else
    # no images — just run hyprlock without changing background
    hyprlock
    exit 0
  fi
else
  chosen="${files[RANDOM % ${#files[@]}]}"
  # Copy to target so hyprlock can reliably read it
  cp -f -- "$chosen" "$TARGET"
fi

# Optional: run pre-lock hooks (mute mic, pause music)
# wpctl set-mute @DEFAULT_AUDIO_SOURCE@ true || true
# playerctl pause || true

# Finally call hyprlock (use full path if necessary)
hyprlock
