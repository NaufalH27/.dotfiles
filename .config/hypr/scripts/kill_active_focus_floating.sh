#!/usr/bin/env bash

active_pid=$(hyprctl activewindow -j | jq -r '.pid')
workspace_id=$(hyprctl activewindow -j | jq -r '.workspace.id')

earliest_floating_pid=$(
  hyprctl clients -j | jq -r \
    --argjson wid "$workspace_id" \
    --argjson apid "$active_pid" '
    [
  .[]
  | select(
      .workspace.id == $wid
      and .floating
      and .pid != $apid
  )
]
| sort_by(.focusHistoryID)
| .[0].pid // empty
'
)

hyprctl dispatch killactive

if [[ -n "$earliest_floating_pid" ]]; then
  hyprctl dispatch focuswindow pid:$earliest_floating_pid
  hyprctl dispatch bringactivetotop
fi


