#!/bin/sh

# Author: Enan Ajmain
# Email : 3nan.ajmain@gmail.com
# Github: https://github.com/enanajmain


# setup keyboard mappings
setxkbmap -option ''
setxkbmap -option 'caps:ctrl_modifier'
setxkbmap -option 'shift:both_capslock'
setxkbmap -option 'numpad:microsoft'

# setup natural scrolling in touchpad
xinput set-prop 'DELL0767:00 06CB:7E92 Touchpad' 'libinput Tapping Enabled' 1
xinput set-prop 'DELL0767:00 06CB:7E92 Touchpad' 'libinput Natural Scrolling Enabled' 1

# setup compositor
compton &> /dev/null &

exec startxfce4

## setup background
#hsetroot -full ~/projects/dotFiles/backgrounds/deer.jpg

## setup notification widget
#dunst &> /dev/null &

## fix broken java applications
#export _JAVA_AWT_WM_NONREPARENTING=1

## setup status bar
#dwm_status &> /dev/null &

#while true; do
#	# Log stderror to a file
#	#dwm 2> ~/.dwm.log
#	# No error logging
#	dwm >/dev/null 2>&1
#done
