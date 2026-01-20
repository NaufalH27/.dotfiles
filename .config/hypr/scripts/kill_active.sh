#!/usr/bin/env bash
set -euo pipefail

active_ws=$(hyprctl activeworkspace -j)
workspace_id=$(jq -r '.id' <<<"$active_ws")
has_fullscreen=$(jq -r '.hasfullscreen' <<<"$active_ws")

active=$(hyprctl activewindow -j)
killed_addr=$(jq -r '.address' <<<"$active")
killed_is_tiled=$(jq -r '
  (.floating == false) and (.fullscreen == 0)
' <<<"$active")

windows=$(hyprctl clients -j | jq --argjson wid "$workspace_id" '
  [.[] | select(.workspace.id == $wid)]
')

overfullscreen_addr=$(
  jq -r --arg killed "$killed_addr" '
    [.[]
      | select(
          .overFullscreen == true
          and .floating == true
          and .address != $killed
        )
    ]
    | sort_by(.focusHistoryID)
    | .[0].address // empty
  ' <<<"$windows"
)

if [[ "$has_fullscreen" == "true" && -n "$overfullscreen_addr" ]]; then
  hyprctl dispatch killactive
  hyprctl dispatch focuswindow address:"$overfullscreen_addr"
  exit 0
fi

fullscreen_addr=$(
  jq -r --arg killed "$killed_addr" '
    [.[]
      | select(.fullscreen > 0 and .address != $killed)
    ]
    | .[0].address // empty
  ' <<<"$windows"
)

if [[ -n "$fullscreen_addr" ]]; then
  hyprctl dispatch killactive
  hyprctl dispatch focuswindow address:"$fullscreen_addr"
  exit 0
fi

floating_addr=$(
  jq -r --arg killed "$killed_addr" '
    [.[]
      | select(
          .floating == true
          and .address != $killed
        )
    ]
    | sort_by(.focusHistoryID)
    | .[0].address // empty
  ' <<<"$windows"
)

tiled_addr=$(
  jq -r --arg killed "$killed_addr" '
    [.[]
      | select(
          .floating == false
          and .address != $killed
        )
    ]
    | sort_by(.focusHistoryID)
    | .[0].address // empty
  ' <<<"$windows"
)

if [[ "$killed_is_tiled" == "true" && -n "$tiled_addr" ]]; then
  hyprctl dispatch killactive
  hyprctl dispatch focuswindow address:"$tiled_addr"
  exit 0
fi

if [[ -n "$floating_addr" ]]; then
  hyprctl dispatch killactive
  hyprctl dispatch focuswindow address:"$floating_addr"
  exit 0
fi

hyprctl dispatch killactive
exit 0

