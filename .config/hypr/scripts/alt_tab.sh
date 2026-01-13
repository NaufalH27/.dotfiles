hyprctl dispatch cyclenext
is_floating=$(hyprctl activewindow -j | jq -r '.floating // false')




