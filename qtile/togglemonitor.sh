#!/bin/bash

# Define your monitor names
LAPTOP_MONITOR="eDP-1"
EXTERNAL_MONITOR="HDMI-1"

# Get the current status of the external monitor
EXTERNAL_STATUS=$(xrandr | grep "$EXTERNAL_MONITOR" | awk '{print $2}')

# Check if the external monitor is connected and is the current display
if [ "$EXTERNAL_STATUS" == "connected" ]; then
    CURRENT_DISPLAY=$(xrandr --listactivemonitors | grep "$EXTERNAL_MONITOR" | awk '{print $4}')
    if [ "$CURRENT_DISPLAY" == "$EXTERNAL_MONITOR" ]; then
        # If the external monitor is connected and is the current display, switch to the laptop monitor
        xrandr --output "$LAPTOP_MONITOR" --auto --output "$EXTERNAL_MONITOR" --off
    else
        # If the external monitor is connected but not the current display, switch to the external monitor
        xrandr --output "$EXTERNAL_MONITOR" --auto --output "$LAPTOP_MONITOR" --off
    fi
else
    # If the external monitor is not connected, switch back to the laptop monitor
    xrandr --output "$LAPTOP_MONITOR" --auto --output "$EXTERNAL_MONITOR" --off
fi


#RE SET THE WALLPAPER

feh --bg-fill ~/Wallpaper/background.jpg

