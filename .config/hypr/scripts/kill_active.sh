#!/usr/bin/env bash
set -euo pipefail

active_ws=$(hyprctl activeworkspace -j)
workspace_id=$(jq -r '.id' <<<"$active_ws")
has_fullscreen=$(jq -r '.hasfullscreen' <<<"$active_ws")
killed_pid=$(hyprctl activewindow -j | jq -r '.pid')
killed_is_tiled=$(
  hyprctl activewindow -j | jq -r '
    (.floating == false) and (.fullscreen == 0)
  '
)

windows=$(hyprctl clients -j | jq --argjson wid "$workspace_id" '
  [.[] | select(.workspace.id == $wid)]
')

overfullscreen_pid=$(
  jq -r --argjson killed "$killed_pid" '
    [.[]
      | select(
          .overFullscreen == true
          and .floating == true
          and .pid != $killed
        )
    ]
    | sort_by(.focusHistoryID)
    | .[0].pid // empty
  ' <<<"$windows"
)

if [[ "$has_fullscreen" == "true" && -n "$overfullscreen_pid" ]]; then
  hyprctl dispatch killactive
  hyprctl dispatch focuswindow "pid:$overfullscreen_pid"
  exit 0
fi

fullscreen_pid=$(
  jq -r --argjson killed "$killed_pid" '
    [.[]
      | select(.fullscreen > 0 and .pid != $killed)
    ]
    | .[0].pid // empty
  ' <<<"$windows"
)

if [[ -n "$fullscreen_pid" ]]; then
  hyprctl dispatch killactive
  hyprctl dispatch focuswindow "pid:$fullscreen_pid"
  exit 0
fi

floating_pid=$(
  jq -r --argjson killed "$killed_pid" '
    [.[]
      | select(
          .floating == true
          and .pid != $killed
        )
    ]
    | sort_by(.focusHistoryID)
    | .[0].pid // empty
  ' <<<"$windows"
)

tiled_pid=$(
  jq -r --argjson killed "$killed_pid" '
    [.[]
      | select(
          .floating == false
          and .pid != $killed
        )
    ]
    | sort_by(.focusHistoryID)
    | .[0].pid // empty
  ' <<<"$windows"
)

if [[ "$killed_is_tiled" == "true" ]]; then
  hyprctl dispatch killactive
  hyprctl dispatch focuswindow "pid:$tiled_pid"
  exit 0
fi


if [[ -n "$floating_pid" ]]; then
  hyprctl dispatch killactive
  hyprctl dispatch focuswindow "pid:$floating_pid"
  exit 0
fi

hyprctl dispatch killactive
exit 0

