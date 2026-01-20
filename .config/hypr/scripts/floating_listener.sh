
X_OFFSET=20
Y_OFFSET=20
WIDTH_PADDING=50
HEIGHT_PADDING=100

stdbuf -oL socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock |
grep --line-buffered -E "^(changefloatingmode>>|openwindow>>)" |
while read -r line; do
    echo $line
    addr="0x$(echo "$line" | cut -d'>' -f3 | cut -d',' -f1)"
    json="$(hyprctl clients -j)"
    client="$(jq -c --arg addr "$addr" '.[] | select(.address==$addr)' <<< "$json")"
    floating="$(jq -r '.floating // false' <<< "$client")"
    pid="$(jq -r '.pid' <<< "$client")"
    initTitle="$(jq -r '.initialTitle' <<< "$client")"

    if [[ "$floating" != "true" ]]; then
        continue
    fi
    workspace_id="$(jq -r '.workspace.id' <<< "$client")"
    monitor_id=$(jq -r '.monitor' <<< "$client")
    monitor_json="$(hyprctl monitors -j)"
    monitor="$(jq -c --argjson id $monitor_id '.[] | select(.id==$id)' <<< "$monitor_json")"
    monitor_width=$(jq -r '.width' <<< "$monitor") 
    monitor_height=$(jq -r '.height' <<< "$monitor") 

  at_anchors=$(
  hyprctl clients -j | jq -r -c \
    --argjson ws $workspace_id \
    --arg addr "$addr" \
    --arg initTitle "$initTitle" \
    --argjson mw $monitor_width \
    --argjson mh $monitor_height \
    --argjson wp $WIDTH_PADDING \
    --argjson hp $HEIGHT_PADDING \
    --argjson x_off $X_OFFSET \
    --argjson y_off $Y_OFFSET '
    [
    .[]
    | select(
      .workspace.id == $ws
      and .floating
      and .address != $addr
      and .initialTitle == $initTitle
      )
    ]
    | max_by(.at[0]) as $max
    | if
      ($max.at[0] + $max.size[0] + $x_off) > ($mw - $wp)
    then
      null
    elif
      ($max.at[1] + $max.size[1] + $y_off) > ($mh - $hp)
    then
      [
      $max.at[0] + 1,
      50
      ]
    else
      $max.at
    end

    '
  )

  if [[ "$at_anchors" == "null" || -z "$at_anchors" ]]; then
    max_x=$((monitor_width / 7))
    max_y=$((monitor_height / 7))

    x=$((RANDOM % max_x + 10))
    y=$((RANDOM % max_y + 50))

  else
    x=$(jq -r '.[0]' <<< "$at_anchors")
    y=$(jq -r '.[1]' <<< "$at_anchors")

    x=$((x + $X_OFFSET))
    y=$((y + $Y_OFFSET))
  fi

  hyprctl dispatch "movewindowpixel exact $x $y,pid:$pid" >> /dev/null

done
