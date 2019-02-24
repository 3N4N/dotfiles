#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)


# setup keyboard mappings
setxkbmap -option ''
setxkbmap -option 'caps:ctrl_modifier'
setxkbmap -option 'shift:both_capslock'

# setup natural scrolling in touchpad
xinput set-prop 'DELL0767:00 06CB:7E92 Touchpad' 'libinput Tapping Enabled' 1
xinput set-prop 'DELL0767:00 06CB:7E92 Touchpad' 'libinput Natural Scrolling Enabled' 1

# setup background
feh --bg-fill ~/Pictures/backgrounds/deer.jpg

# setup compositor
compton --config $HOME/.config/compton.conf </dev/null &>/dev/null &

# start window manager or desktop environment
exec i3
