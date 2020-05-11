#!/bin/sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile

exec bspwm
# exec sowm
# systemctl --user import-environment DISPLAY
# exec i3

