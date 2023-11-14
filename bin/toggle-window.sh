#!/bin/bash

WINDOW_ID_FILE=/tmp/window-id
WINDOW_STATE_FILE=/tmp/window-state
COMMAND=$1

WINDOW_ID=$(cat $WINDOW_ID_FILE || echo "")
WINDOW_STATE=$(cat $WINDOW_STATE_FILE || echo "")

case $COMMAND in
    "select")
        xdotool selectwindow > $WINDOW_ID_FILE
        ;;
    "toggle")
        if [ $WINDOW_STATE = "ACTIVE" ]; then
            xdotool windowminimize $WINDOW_ID
            echo "MINIMIZED" > $WINDOW_STATE_FILE
        else
            xdotool set_desktop_for_window $WINDOW_ID $(xdotool get_desktop)
            xdotool windowactivate $WINDOW_ID
            echo "ACTIVE" > $WINDOW_STATE_FILE
        fi
        ;;
esac
