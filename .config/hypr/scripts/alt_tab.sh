#!/usr/bin/env bash

active=$(hyprctl activewindow -j)
active_ws=$(hyprctl activeworkspace -j | jq '.id')
hidden_ws=$((active_ws + 10))

if jq -e '. == null' <<<"$active" >/dev/null; then

    next_pid=$(hyprctl clients -j | jq -r \
        --argjson hidden "$hidden_ws" '
        [.[] 
         | select(.workspace.id == $hidden)
         | {pid, focusHistoryID}]
        | sort_by(.focusHistoryID)
        | last.pid
        // empty
    ')
else
    floating=$(jq -r '.floating' <<<"$active")
    pid=$(jq -r '.pid' <<<"$active")

    next_pid=$(hyprctl clients -j | jq -r \
        --argjson ws "$active_ws" \
        --argjson hidden "$hidden_ws" \
        --argjson pid "$pid" '
        [.[] 
         | select((.workspace.id == $ws or .workspace.id == $hidden) and .pid != $pid)
         | {pid, focusHistoryID}]
        | sort_by(.focusHistoryID)
        | last.pid
        // empty
    ')
fi

[[ -n "$next_pid" ]] && hyprctl dispatch movetoworkspacesilent "$active_ws", "pid:$next_pid"
[[ -n "$next_pid" ]] && hyprctl dispatch focuswindow "pid:$next_pid"

hyprctl dispatch bringactivetotop

