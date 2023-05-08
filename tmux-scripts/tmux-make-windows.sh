#!/bin/bash

for ix in $(seq 1 $1); do
    tmux split-window
    tmux select-layout tiled
done
