#!/bin/sh

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add       item            github.bell right                  \
           --add       event           github_update                      \
           --set       github.bell     update_freq=180                    \
                                       icon.font="$FONT:Bold:15.0"        \
                                       icon=$BELL                         \
                                       icon.color=$BLUE                   \
                                       label=$LOADING                     \
                                       label.highlight_color=$BLUE        \
                                       popup.align=right                  \
                                       script="$PLUGIN_DIR/github.sh"     \
                                       click_script="open https://github.com/notifications" \
           --subscribe github.bell     mouse.entered                      \
                                       mouse.exited                       \
                                       mouse.exited.global                \
                                       github_update                      \
                                                                          \
           --add       item            github.template popup.github.bell  \
           --set       github.template drawing=off                        \
                                       background.corner_radius=12        \
                                       padding_left=7                     \
                                       padding_right=7                    \
                                       icon.background.height=2           \
                                       icon.background.y_offset=-12
