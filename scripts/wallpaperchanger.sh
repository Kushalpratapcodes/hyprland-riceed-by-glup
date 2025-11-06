#!/usr/bin/env bash
# ~/.config/hypr/scripts/wall-random.sh
# Random wallpaper changer for Hyprpaper only

WALL_DIR="$HOME/Pictures/Wallpapers"

mapfile -t files < <(find "$WALL_DIR" -type f \( -iname '*.jpg' -o -iname '*.png' -o -iname '*.jpeg' -o -iname '*.webp' \))

[ ${#files[@]} -eq 0 ] && notify-send "Hyprpaper" "No wallpapers in $WALL_DIR" && exit 1

file="${files[RANDOM % ${#files[@]}]}"
monitors=$(hyprctl monitors -j | jq -r '.[].name')

hyprctl hyprpaper preload "$file"
for m in $monitors; do
  hyprctl hyprpaper wallpaper "$m,$file"
done

notify-send "Hyprpaper" "Wallpaper set: $(basename "$file")"
