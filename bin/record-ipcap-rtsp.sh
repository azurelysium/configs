#!/bin/bash

VIDEO_DIR="/home/azurelysium/Videos/ipcam/"

ffmpeg -i rtsp://192.1.1.1/live/ch00_0 \
        -vf "drawtext=fontfile=DroidSansMono.ttf: text='%{localtime}': x=(w-tw)/2: y=h-(2*lh): fontcolor=white: box=1: boxcolor=0x00000099" \
        -r 10 -t 3600 -y $VIDEO_DIR/$(date +\%Y-\%m-\%d-\%H).mp4

find $VIDEO_DIR -type f -mtime +14 -exec rm {} \;
