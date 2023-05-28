# setup taskbar

while true; do
	klang=""
	current_time="$(date '+%a %b %d %R')"
	bytes_down=$(ip -s link | grep wlan0 -A5 | tail -n4 | xargs | cut -d ' ' -f8)
	net_down=$(echo "scale=2; $bytes_down / 1073741824" | bc)
	battery_level="$(cat /sys/class/power_supply/BAT0/capacity)"
	xsetroot -name "$battery_level % | net_usage: $net_down GB | $current_time"
	sleep 1s	

done &

export _JAVA_AWT_WM_NONREPARENTING=1
redshift -O 4000 -g .8
feh --bg-fill ~/Downloads/bg.jpg
exec dwm

