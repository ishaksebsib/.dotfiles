#!/bin/bash

# Apply wallpaper using wal
# wal -b 282738 -i ~/Wallpaper/Aesthetic2.png &&

# reverse the touch pad scrolling
xinput set-prop 14 'libinput Natural Scrolling Enabled' 1 

# Tocuh pad click enable
xinput set-prop 14  "libinput Tapping Enabled" 1 

# change the wall papaer
# feh --bg-fill ./Wallpaper/background.jpg 

#change the theme to dark mood 
# darkman set dark 

# Start picom
picom --config ~/.config/picom/picom.conf &

# Start WIFI Manager
nm-applet &
