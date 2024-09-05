#!/usr/bin/env bash

# Apply WallPaper 
feh --bg-fill ~/.config/qtile/Assets/Wallpaper/background.jpg

#change the theme to dark mood 
darkman set dark 

# Start picom
picom --config ~/.config/picom/picom.conf &

# Start WIFI Manager
nm-applet &
