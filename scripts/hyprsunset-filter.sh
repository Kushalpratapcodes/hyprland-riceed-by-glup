#!/bin/bash

# Define the step size for temperature change (e.g., 200 Kelvin)
STEP=200

# Define the minimum and maximum temperature limits
MIN_TEMP=2000  # Very warm/yellow
MAX_TEMP=6500  # Normal white/daylight

# Get the desired action (up or down)
ACTION=$1

# Get the current hyprsunset temperature via IPC (requires 'jq' to be installed: sudo pacman -S jq)
CURRENT_TEMP_JSON=$(hyprctl -j hyprsunset)
CURRENT_TEMP=$(echo "$CURRENT_TEMP_JSON" | jq -r '.temperature')

# If hyprsunset is not running or returns a non-integer, assume max temperature as a starting point.
if ! [[ "$CURRENT_TEMP" =~ ^[0-9]+$ ]]; then
    CURRENT_TEMP=$MAX_TEMP
fi

NEW_TEMP=$CURRENT_TEMP

if [ "$ACTION" == "up" ]; then
    # UP: Increase temperature (less yellow/warmer)
    # Note: Going "up" in temperature makes the screen LESS yellow.
    NEW_TEMP=$((CURRENT_TEMP + STEP))
    
    # Ensure it doesn't exceed the max (normal white light)
    if [ $NEW_TEMP -gt $MAX_TEMP ]; then
        NEW_TEMP=$MAX_TEMP
    fi

elif [ "$ACTION" == "down" ]; then
    # DOWN: Decrease temperature (more yellow/warmer)
    # Note: Going "down" in temperature makes the screen MORE yellow.
    NEW_TEMP=$((CURRENT_TEMP - STEP))

    # Ensure it doesn't fall below the minimum (very warm light)
    if [ $NEW_TEMP -lt $MIN_TEMP ]; then
        NEW_TEMP=$MIN_TEMP
    fi
fi

# Apply the new temperature using hyprctl
hyprctl hyprsunset temperature $NEW_TEMP
