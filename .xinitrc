#!/bin/sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile

exec bspwm
systemctl --user import-environment DISPLAY
# exec i3

