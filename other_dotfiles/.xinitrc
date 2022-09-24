# setup taskbar

while true; do
	klang=""
	current_time="$(date '+%a %b %d %R')"
	bytes_down=$(ip -s link | grep wlan0 -A5 | tail -n4 | xargs | cut -d ' ' -f8)
	net_down=$(echo "scale=2; $bytes_down / 1073741824" | bc)
	dsku="$(df -h | grep /dev/nvme0n1p5 | xargs | cut -d' ' -f 4)"
	battery_level="$(cat /sys/class/power_supply/BAT0/capacity)"
	keyboard_lang="$(xset -q | grep LED | xargs | cut -d' ' -f10)"
	if [ $keyboard_lang -eq "00000000" ]
	then
		klang="English"
	else
		klang="Español"
	fi
	xsetroot -name "$klang | $battery_level % | net_usage: $net_down GB | /: $dsku | $current_time"
	sleep 1s	

done &

export _JAVA_AWT_WM_NONREPARENTING=1
redshift -O 4000 -g .8
exec dwm

