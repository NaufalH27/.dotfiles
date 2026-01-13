workspace_id=$(hyprctl activeworkspace -j | jq -r '.id')
hyptctl dispath togglefullscreen

floatings=$(
  hyprctl clients -j | jq \
    --argjson wid "$workspace_id" \
    '[.[] | select(.workspace.id == $wid and .floating)]'
)

echo "$floatings" | jq -c '.[]' | while read -r client; do
  hyprctl dispatch focuswindow pid:$earliest_floating_pid
  hyprrctl dispatch bringactivetotop
done
