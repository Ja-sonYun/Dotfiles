#!/bin/sh

sketchybar --add       item            togglenativebar center             \
           --set       togglenativebar                                    \
                                       icon.font="$FONT:Bold:15.0"        \
                                       icon=􀋰                             \
                                       icon.color=$BLUE                   \
                                       script="$PLUGIN_DIR/togglenativebar.sh"   \
                                       click_script="$PLUGIN_DIR/togglenativebar.sh" \
           --subscribe togglenativebar mouse.entered
