#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config

monitors=$(xrandr --listactivemonitors | sed "/Monitor/ d" | awk '{print $4}' | tr '\n' ':')
num=$(expr $(xrandr --listactivemonitors | wc -l) - 1)

# if [ "$num" = 1 ]; then
# 	mainmonitor=$(echo $monitors | tr ':' '\n')
# 	polybar top-$mainmonitor &
# elif echo $monitors | grep 'DP2-3'; then
# 	mainmonitor='eDP1'
# 	secondmonitor='DP2-3'
# 	polybar top-$mainmonitor &
# 	polybar top-$secondmonitor &
# elif echo $monitors | grep 'DP2'; then
# 	mainmonitor='eDP1'
# 	secondmonitor='DP2'
# 	polybar top-$mainmonitor &
# 	polybar top-$secondmonitor &
# else
# 	mainmonitor='DP2'
# 	secondmonitor='eDP1'
# 	polybar top-$mainmonitor &
# 	polybar top-$secondmonitor &
# fi


if [ "$num" = 1 ]; then
	mainmonitor=$(echo $monitors | tr ':' '\n')
	polybar top-$mainmonitor &
elif echo $monitors | grep 'DP2-3'; then
	mainmonitor='DP2-3'
	secondmonitor='eDP1'
	polybar top-$mainmonitor &
	polybar top-$secondmonitor &
elif echo $monitors | grep 'DP2'; then
	mainmonitor='DP2'
	secondmonitor='eDP1'
	polybar top-$mainmonitor &
	polybar top-$secondmonitor &
else
	mainmonitor='eDP1'
	if echo $monitors | grep 'DP2-3'; then
	    secondmonitor='DP2-3'
	else
	    secondmonitor='DP2'
	fi
	polybar top-$mainmonitor &
	polybar top-$secondmonitor &
fi

notify-send "Polybar launched"
