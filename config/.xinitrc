# start DE

sh ~/.bashrc

export DISPLAY=:0
sleep 1 && xrandr --output Virtual1 --mode 1920x1080

exec i3
