source ~/.config/hypr/scripts/unstack_window.sh


floating=$(hyprctl activewindow -j | jq '.floating')
window=$(hyprctl activewindow -j | jq '.initialClass' | tr -d "\"")


function toggle_top_right() {
	width=$1
	height=$2

	if [ "$floating" == "false" ]; then
		hyprctl --batch \
		"dispatch togglefloating; \
		dispatch resizeactive exact ${width} ${height}; \
		dispatch centerwindow ;\
		dispatch movewindow l;\
		dispatch movewindow u;\
		dispatch moveactive 10 10'"
		unstack
	else
		hyprctl dispatch togglefloating
	fi
}


function toggle_center() {
	width=$1
	height=$2

	if [ "$floating" == "false" ]; then
		hyprctl --batch \
		"dispatch togglefloating; \
		dispatch resizeactive exact ${width} ${height}; \
		dispatch movewindow l;\
		dispatch movewindow u;\
		dispatch moveactive 150 115;"
		unstack
	else
		hyprctl dispatch togglefloating
	fi
}


case $window in
swayimg|imv|Display) toggle_top_right "640" "480";;
mpv|vlc|org.kde.haruna|smplayer) toggle_top_right "960" "540";;
Code|zen-beta|vivaldi|Google-chrome) toggle_center "1280" "720";;
*) toggle_center "960" "540";;
esac

