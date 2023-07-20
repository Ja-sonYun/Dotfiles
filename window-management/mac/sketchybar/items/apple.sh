#!/bin/sh

sketchybar --add item           apple.logo left                             \
           --set apple.logo     icon=$APPLE                                 \
                                icon.font="$FONT:Black:16.0"                \
                                icon.color=$GREEN                           \
                                padding_right=15                            \
                                label.drawing=off                           \
                                click_script="$PLUGIN_DIR/open_menubar_apple"
