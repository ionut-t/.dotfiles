#!/bin/bash

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ -z "$PERCENTAGE" ]; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

if [ -n "$CHARGING" ]; then
  ICON="🔌"
elif [ "$PERCENTAGE" -gt 80 ]; then
  ICON="█"
elif [ "$PERCENTAGE" -gt 60 ]; then
  ICON="▓"
elif [ "$PERCENTAGE" -gt 40 ]; then
  ICON="▒"
elif [ "$PERCENTAGE" -gt 20 ]; then
  ICON="░"
else
  ICON="!"
  sketchybar --set "$NAME" icon.color=0xfff38ba8
fi

sketchybar --set "$NAME" drawing=on icon="$ICON" label="${PERCENTAGE}%"
