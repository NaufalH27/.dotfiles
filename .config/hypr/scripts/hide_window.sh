#!/usr/bin/env bash

active=$(hyprctl activewindow -j)
active_ws=$(hyprctl activeworkspace -j | jq '.id')
hidden_ws=$((active_ws + 10))
hyprctl dispatch movetoworkspacesilent $hidden_ws
