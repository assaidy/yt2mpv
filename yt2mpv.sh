#!/bin/sh

# Define the menu command. You can switch between dmenu, rofi, and wofi by uncommenting the desired line.
# DMENU="dmenu -i"
# DMENU="rofi -dmenu -i"
DMENU="wofi --dmenu -i"

# Get the link from the clipboard.
# you can change to xclip for xorg
LINK=$(wl-paste)

# Define the available resolutions.
RESOLUTIONS="1080\n720\n480\n360\n240\n144\nAudio-only"

# Use the menu command to let the user select a resolution.
RESOLUTION=$(printf "$RESOLUTIONS" | $DMENU -p "streaming: $LINK")

# Check if a resolution was selected.
if [ -z "$RESOLUTION" ]; then
  exit 1
fi

# If the user selected "Audio-only", use "bestaudio/best". 
# Otherwise, use "bestvideo[height<=?$RESOLUTION]+bestaudio/best"
# The --ytdl-format option is used to specify the desired video and audio quality.
if [ "$RESOLUTION" = "Audio-only" ]; then
    # FORMAT="bestaudio/best"
    mpv --force-window --no-video $LINK
else
    mpv --ytdl-format="bestvideo[height<=?$RESOLUTION]+bestaudio/best" $LINK
fi
