#!/bin/bash

# Catppuccin Mocha
BLUE=0xff89b4fa
SURFACE0=0xff313244
SUBTEXT=0xffa6adc8
TEXT=0xffcdd6f4

SID="$1"

FOCUSED_WORKSPACE="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
OCCUPIED_WORKSPACES=$(aerospace list-workspaces --monitor all --empty no 2>/dev/null)

# Check if this workspace has windows
HAS_WINDOWS=false
while IFS= read -r ws; do
  if [ "$ws" = "$SID" ]; then
    HAS_WINDOWS=true
    break
  fi
done <<< "$OCCUPIED_WORKSPACES"

if [ "$SID" = "$FOCUSED_WORKSPACE" ]; then
  APP_NAME=$(aerospace list-windows --focused --format '%{app-name}' 2>/dev/null)
  LABEL="$SID"
  [ -n "$APP_NAME" ] && LABEL="$SID  $APP_NAME"
  sketchybar --set "$NAME" \
    drawing=on \
    background.drawing=on \
    background.color=$BLUE \
    label="$LABEL" \
    label.color=0xff1e1e2e
elif [ "$HAS_WINDOWS" = true ]; then
  APP_NAME=$(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null | head -1)
  LABEL="$SID"
  [ -n "$APP_NAME" ] && LABEL="$SID  $APP_NAME"
  sketchybar --set "$NAME" \
    drawing=on \
    background.drawing=on \
    background.color=$SURFACE0 \
    label="$LABEL" \
    label.color=$TEXT
else
  sketchybar --set "$NAME" drawing=off
fi
