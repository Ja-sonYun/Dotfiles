#!/bin/bash

if [ "$1" = "start" ]; then

    colima start &>/dev/null && tmux display-message "Colima started" || tmux display-message "Colima already running"

elif [ "$1" = "stop" ]; then

    colima stop &>/dev/null && tmux display-message "Colima stopped" || tmux display-message "Colima already stopped"

elif [ "$1" = "status" ]; then

    colima status &>/dev/null && echo "#[fg=green]" || echo "#[fg=red]stopped"

else
    echo "Usage: colima.sh [start|stop|delete|status]"
fi
