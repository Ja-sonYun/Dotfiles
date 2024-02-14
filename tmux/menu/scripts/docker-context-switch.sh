#!/bin/bash

TEMP_MENU="/tmp/ps_menu.yaml"
rm -f $TEMP_MENU
cat > $TEMP_MENU << EOM
title: " docker context "
border: "simple"
items:
  - Seperate: {}
  - NoDim:
      name: "current context: \$(\$CONFIG/tmux/menu/scripts/docker-menu-parse.sh current_context)"
  - Seperate: {}
EOM

docker context ls | while read line
do
    context=$(echo $line | awk '{print $1}')

    if [ "$context" != "NAME" ]; then
        cat >> $TEMP_MENU <<- EOM

  - Menu:
      name: "> $context"
      shortcut: ""
      command: "docker context use $context > /dev/null 2>&1"
      background: true

EOM
    fi
done

tmux-menu show --menu $TEMP_MENU
rm -f $TEMP_MENU
