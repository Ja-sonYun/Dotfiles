#!/bin/bash

TEMP_GIT_BRANCH_MENU="/tmp/gitbranch_menu.yaml"
rm -f $TEMP_GIT_BRANCH_MENU
cat > $TEMP_GIT_BRANCH_MENU << EOM
title: " git branch "
items:
  - Seperate: {}
EOM

git branch | while read line
do
    cat >> $TEMP_GIT_BRANCH_MENU <<- EOM
  - Menu:
      name: "$line"
      shortcut: ""
      command: "git checkout $line"
      close_after_command: false

      position:
        w: 120
        h: 20

EOM
done

tmux-menu show --menu $TEMP_GIT_BRANCH_MENU
rm -f $TEMP_GIT_BRANCH_MENU
