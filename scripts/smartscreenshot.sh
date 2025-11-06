# this script takes screenshot It captures your selection with grim + slurp 
into a temporary file. Opens that file in Swappy. If you press Save in Swappy,
it overwrites the temp file. Once you close Swappy, the script checks if the 
temp file exists and is non-empty — if yes, it moves it to ~/Pictures/Screenshots/.
If you close Swappy without saving, it deletes the temp file and sends a “discarded” notification.



#!/usr/bin/env bash
# screenshot.sh — select area → edit in swappy → only save if you press save
# requires: grim, slurp, swappy, notify-send

TMPFILE="$(mktemp --suffix .png)"
DESTDIR="$HOME/Pictures/Screenshots"
mkdir -p "$DESTDIR"

region=$(slurp 2>/dev/null)
[ -z "$region" ] && notify-send "Screenshot" "Cancelled" && exit 1

# Take screenshot to temp file
grim -g "$region" "$TMPFILE" || exit 1

# Open in Swappy (user chooses whether to save)
swappy -f "$TMPFILE"

# After Swappy closes, check if user pressed save
if [ -f "$TMPFILE" ] && [ "$(stat -c%s "$TMPFILE")" -gt 0 ]; then
    timestamp=$(date +%Y%m%d_%H%M%S)
    mv "$TMPFILE" "$DESTDIR/screenshot_$timestamp.png"
    notify-send "Screenshot" "Saved to $DESTDIR/screenshot_$timestamp.png"
else
    rm -f "$TMPFILE"
    notify-send "Screenshot" "Discarded (not saved)"
fi
