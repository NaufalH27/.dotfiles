#!/usr/bin/env bash

active=$(hyprctl activewindow -j)
active_ws=$(hyprctl activeworkspace -j | jq '.id')
hidden_ws=$((active_ws + 10))

if jq -e '. == null' <<<"$active" >/dev/null; then

    next_addr=$(hyprctl clients -j | jq -r \
        --argjson hidden "$hidden_ws" '
        [.[]
         | select(.workspace.id == $hidden)
         | {address, focusHistoryID}]
        | sort_by(.focusHistoryID)
        | last.address
        // empty
    ')

else
    active_addr=$(jq -r '.address' <<<"$active")

    next_addr=$(hyprctl clients -j | jq -r \
        --argjson ws "$active_ws" \
        --argjson hidden "$hidden_ws" \
        --arg addr "$active_addr" '
        [.[]
         | select(
             (.workspace.id == $ws or .workspace.id == $hidden)
             and .address != $addr
           )
         | {address, focusHistoryID}]
        | sort_by(.focusHistoryID)
        | last.address
        // empty
    ')
fi

echo "$next_addr"

if [[ -n "$next_addr" ]]; then
    hyprctl dispatch movetoworkspacesilent "$active_ws",address:"$next_addr"
    hyprctl dispatch focuswindow address:"$next_addr"
fi

hyprctl dispatch bringactivetotop

