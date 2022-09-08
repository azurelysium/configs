#!/bin/bash

POPUP_NAME="popup"
SESSION_NAME=$(tmux display-message -p -F "#{session_name}")

if [ $SESSION_NAME = $POPUP_NAME ]; then
	tmux detach-client
else
	tmux popup -d '#{pane_current_path}' -w 90% -h 80% -E "tmux attach -t $POPUP_NAME || tmux new -s $POPUP_NAME"
fi
