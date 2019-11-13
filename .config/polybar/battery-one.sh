#!/bin/sh

BAT1=$(cat /sys/class/power_supply/BAT1/capacity)
AC=$(cat /sys/class/power_supply/BAT1/status)

if [ "$AC" = "Charging" ]; then
	echo "1:    > $BAT1% "
else
	case "$BAT1" in
		100|9[0-9])	echo "1:    > $BAT1% " ;;
		8[0-9]|7[0-9])	echo "1:    > $BAT1%" ;;
		6[0-9]|5[0-9])	echo "1:    > $BAT1%" ;;
		4[0-9]|3[0-9])	echo "1:    > $BAT1%" ;;
		*)		echo "1:    > $BAT1%" ;;
	esac
fi
