#!/bin/sh

# Trigger the brew_udpate event when brew update or upgrade is run from cmdline
# e.g. via function in .zshrc

sketchybar --add       event          task_update                      \
           --add       item           task right                       \
           --set       task           script="$PLUGIN_DIR/task.sh"     \
                                      icon.color=$MAGENTA              \
                                      icon=􀷾                           \
                                      label=?                          \
                                      popup.align=right                \
                                      popup.height=30                  \
                                      click_script="flock -en /tmp/sketchybar_task_fetch.lock -c \
                                      \"$HOME/config/shortcuts/scripts/task_fetch && \
        SENDER=forced $HOME/config/window-management/mac/sketchybar/plugins/task.sh\"" \
           --subscribe task           mouse.entered                    \
                                      mouse.exited                     \
                                      mouse.exited.global              \
                                      task_update                      \
                                                                       \
           --add       item           task.template popup.task         \
           --set       task.template  drawing=off                      \
                                      padding_left=7                   \
                                      padding_right=7                  \
                                      icon.color=$MAGENTA              \
                                      icon.background.height=2         \
                                      icon.background.y_offset=-12
                                      # label.font="BigBlue_TerminalPlus Nerd Font:Book:10.0"

