floating=$(hyprctl activewindow -j | jq '.floating')
window=$(hyprctl activewindow -j | jq '.initialClass' | tr -d "\"")


curr_workspace=$(hyprctl activeworkspace -j | jq -r ".id")
clients_at=$(hyprctl clients -j | jq --argjson ws "$curr_workspace" '[.[] | select(.workspace.id == $ws and .floating == true) | .at]')


is_same_position_exist() {
    active_at=$(hyprctl activewindow -j | jq -c '.at')
	if echo "$clients_at" | jq -e --argjson target "$active_at" '.[] | select(. == $target)' > /dev/null; then
		return 0
	else
		return 1
	fi
}

unstack() {
    while is_same_position_exist; do
      	hyprctl --batch \
			"dispatch focuswindow initialClass:"$window_pid";\
			dispatch moveactive 20 20"
    done
}