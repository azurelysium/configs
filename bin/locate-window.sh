#!/bin/bash
set -ex

WINDOW_ID=$(xdotool getwindowfocus)

DISPLAY_WIDTH=$(xdotool getdisplaygeometry | cut -d' ' -f1)
DISPLAY_HEIGHT=$(xdotool getdisplaygeometry | cut -d' ' -f2)

COMMAND=$1
case $COMMAND in
    "center")
        WINDOW_WIDTH=$(expr $DISPLAY_WIDTH "/" 5 "*" 4)
        WINDOW_HEIGHT=$(expr $DISPLAY_HEIGHT "/" 5 "*" 4)

        WINDOW_X=$(expr $(expr $DISPLAY_WIDTH "-" $WINDOW_WIDTH) "/" 2)
        WINDOW_Y=$(expr $(expr $DISPLAY_HEIGHT "-" $WINDOW_HEIGHT) "/" 2)
        ;;
    "left")
        WINDOW_WIDTH=$(expr $DISPLAY_WIDTH "/" 2)
        WINDOW_HEIGHT=$DISPLAY_HEIGHT

        WINDOW_X=0
        WINDOW_Y=0
        ;;
    "right")
        WINDOW_WIDTH=$(expr $DISPLAY_WIDTH "/" 2)
        WINDOW_HEIGHT=$DISPLAY_HEIGHT

        WINDOW_X=$WINDOW_WIDTH
        WINDOW_Y=0
        ;;
esac

xdotool windowsize $WINDOW_ID $WINDOW_WIDTH $WINDOW_HEIGHT
xdotool windowmove $WINDOW_ID $WINDOW_X $WINDOW_Y
