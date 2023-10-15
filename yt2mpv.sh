#!/bin/sh

# Define the menu command. You can switch between dmenu, rofi, and wofi by uncommenting the desired line.
# DMENU="dmenu -i"
# DMENU="rofi -dmenu -i"
DMENU="wofi --dmenu -i"

# Get the link from the clipboard.
# you can change to xclip for xorg
LINK=$(wl-paste)

# Define the available resolutions.
RESOLUTIONS="1080\n720\n480\n360\n240\n144"

# Use the menu command to let the user select a resolution.
RESOLUTION=$(printf "$RESOLUTIONS" | $DMENU -p "streaming: $LINK")

# Check if a resolution was selected.
if [ -z "$RESOLUTION" ]; then
  exit 1
fi

# Play the video with mpv at the selected resolution.
# The --ytdl-format option is used to specify the desired video and audio quality.
mpv --ytdl-format="bestvideo[height<=?$RESOLUTION]+bestaudio/best" $LINK
