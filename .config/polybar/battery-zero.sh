#!/bin/sh

BAT0=$(cat /sys/class/power_supply/BAT0/capacity)
AC=$(cat /sys/class/power_supply/BAT0/status)

if [ "$AC" = "Charging" ]; then
	echo "0:    > $BAT0%"
else
	case "$BAT0" in
		100|9[0-9])	echo "0:    > $BAT0%" ;;
		8[0-9]|7[0-9])	echo "0:    > $BAT0%" ;;
		6[0-9]|5[0-9])	echo "0:    > $BAT0%" ;;
		4[0-9]|3[0-9])	echo "0:    > $BAT0%" ;;
		*)		echo "0:    > $BAT0%" ;;
	esac
fi

