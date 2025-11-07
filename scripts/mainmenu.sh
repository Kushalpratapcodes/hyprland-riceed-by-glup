#!/usr/bin/env bash
action="$1"
case "$action" in
  home) notify-send "Menu" "Home selected";;
  rooms) notify-send "Menu" "Rooms selected";;
  schedules) notify-send "Menu" "Schedules selected";;
  profile) notify-send "Menu" "Profile selected";;
  add) notify-send "Menu" "Add action";;
  *) notify-send "Menu" "Unknown: $action";;
esac
