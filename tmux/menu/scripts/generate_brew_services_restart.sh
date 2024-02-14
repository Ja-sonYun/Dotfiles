#!/bin/bash

TEMP_PS_MENU_FILE="/tmp/ps_menu.yaml"
rm -f $TEMP_PS_MENU_FILE
cat > $TEMP_PS_MENU_FILE << EOM
title: " docker services "
border: "simple"
items:
  - Seperate: {}
  - NoDim:
      name: "#[align=centre]Running Processes"
  - Seperate: {}
EOM

brew services list | while read line
do
    program=$(echo $line | awk '{print $1}')
    status=$(echo $line | awk '{print $2}')

    if [ "$status" == "started" ]; then
        cat >> $TEMP_PS_MENU_FILE <<- EOM

  - Menu:
      name: "$program"
      shortcut: ""
      command: "brew services restart $program"

      position:
        w: 80
        h: 10

EOM
    fi
done

tmux-menu show --menu $TEMP_PS_MENU_FILE
rm -f $TEMP_PS_MENU_FILE
