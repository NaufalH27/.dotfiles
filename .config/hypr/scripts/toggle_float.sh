
floating=$(hyprctl activewindow -j | jq '.floating')
window=$(hyprctl activewindow -j | jq '.initialClass' | tr -d "\"")


function toggle_float() {
	width=$1
	height=$2

	if [ "$floating" == "false" ]; then
		hyprctl --batch \
		"dispatch togglefloating; \
		dispatch resizeactive exact ${width} ${height}; \
		"
	else
		hyprctl dispatch togglefloating
	fi
}




case $window in
swayimg|imv|Display) toggle_float "640" "480";;
mpv|vlc|org.kde.haruna|smplayer) toggle_float "960" "540";;
Code|zen-beta|vivaldi|Google-chrome) toggle_float "1280" "720";;
*) toggle_float "960" "540";;
esac

