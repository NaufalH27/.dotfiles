#!/usr/bin/env bash

MINIMIZED_WS_OFFSET=10

active_ws=$(hyprctl activeworkspace -j | jq '.id')
hidden_ws=$((active_ws + MINIMIZED_WS_OFFSET))

hyprctl dispatch movetoworkspacesilent "$hidden_ws"

