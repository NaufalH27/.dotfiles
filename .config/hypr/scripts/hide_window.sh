#!/usr/bin/env bash

MINIMIZED_WS_OFFSET=100

active_ws=$(hyprctl activeworkspace -j | jq '.id')
hidden_ws=$((active_ws + MINIMIZED_WS_OFFSET))

active=$(hyprctl activewindow -j)
is_pinned=$(jq -r '.pinned' <<<"$active")

if [[ "$is_pinned" == "false" ]]; then
    hyprctl dispatch movetoworkspacesilent "$hidden_ws"
fi

