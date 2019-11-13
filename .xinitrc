#!/bin/sh

[ -f "$HOME/.xprofile" ] && . ~/.xprofile

exec bspwm
# exec i3

