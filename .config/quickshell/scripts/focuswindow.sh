#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: $0 <address> [fullscreen] [minimized] [active_ws]"
  exit 1
fi

address="$1"
fullscreen="${2:-0}"
minimized="${3:-0}"
active_ws="$4"

if [ "$minimized" == "true" ] && [ -n "$active_ws" ]; then
  hyprctl dispatch movetoworkspacesilent "$active_ws, address:$address"
fi

hyprctl dispatch focuswindow "address:$address"

if [ "$fullscreen" -gt 0 ]; then
  hyprctl --batch "dispatch fullscreen $fullscreen; dispatch fullscreen $fullscreen"
fi

hyprctl dispatch bringactivetotop

