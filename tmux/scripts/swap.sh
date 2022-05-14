#!/bin/sh

CURRENT_SESSION=`tmux display-message -p '#S'`

if [ "$CURRENT_SESSION" == "popup" ]; then
    tmux switch-client -t popup
else
    tmux rename-session -t $CURRENT_SESSION _temp
    tmux rename-session -t popup $CURRENT_SESSION
    tmux rename-session -t _temp popup
    tmux switch-client -t $CURRENT_SESSION
fi

