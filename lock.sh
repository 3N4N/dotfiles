#!/bin/bash

tmpbg='/tmp/screen.png'
scrot "$tmpbg"
convert "$tmpbg" -filter Gaussian -thumbnail 40% -sample 250% "$tmpbg"
i3lock -i "$tmpbg"
