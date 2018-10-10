#
#  ██╗      ██████╗  ██████╗██╗  ██╗
#  ██║     ██╔═══██╗██╔════╝██║ ██╔╝
#  ██║     ██║   ██║██║     █████╔╝
#  ██║     ██║   ██║██║     ██╔═██╗
#  ███████╗╚██████╔╝╚██████╗██║  ██╗
#  ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝

#!/bin/bash

# set the icon and a temporary location for the screenshot to be stored
lighticon="$HOME/Documents/projects/dotFiles/i3/icons/locklight.png"
darkicon="$HOME/Documents/projects/dotFiles/i3/icons/lockdark.png"
tmpbg='/tmp/screen.png'

# take a screenshot
scrot "$tmpbg"

# threshold value to determine if we should use the light icon or dark icon
VALUE="60" #brightness value to compare to

# determine the color of the screenshot
# idea of getting the background color to change the icons
COLOR=$(convert "$tmpbg" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
    -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');

# set the icon to use either dark or light colors based on the screenshot
if [ "$COLOR" -gt "$VALUE" ]; then #light background, use dark icon
    icon="$darkicon"
else # dark background so use the light icon
    icon="$lighticon"
fi

# blur the screenshot by resizing and scaling back up
convert "$tmpbg" -filter Gaussian -thumbnail 20% -sample 500% "$tmpbg"

# overlay the icon onto the screenshot
convert "$tmpbg" "$icon" -gravity center -composite "$tmpbg"

# lock the screen with the blurred screenshot
i3lock -i "$tmpbg"
