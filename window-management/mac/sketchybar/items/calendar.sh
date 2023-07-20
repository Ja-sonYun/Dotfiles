#!/bin/sh

sketchybar --add event    calendar_fetch                          \
           --add item     calendar right                          \
           --set calendar icon=cal                                \
                          icon.font="$FONT:Black:12.0"            \
                          icon.padding_right=0                    \
                          label.width=45                          \
                          label.align=right                       \
                          padding_left=12                         \
                          update_freq=30                          \
                          popup.align=right                       \
                          popup.height=25                         \
                          script="$PLUGIN_DIR/calendar.sh"        \
                          click_script="open -a Calendar"         \
           --subscribe calendar                                   \
                          system_woke                             \
                          mouse.entered                           \
                          mouse.exited                            \
                          mouse.exited.global                     \
           --add item     calendar.template popup.calendar        \
           --set calendar.template                                \
                          drawing=off                             \
                          icon.color=$ORANGE                      \
           --add item     calendar.event right                    \
           --set calendar.event                                   \
                          y_offset=-10                            \
                          width=0                                 \
                          update_freq=300                         \
                          script="$PLUGIN_DIR/calendar_event.sh"  \
                          label.font="$FONT:Black:7.0"            \
                          icon.font="$FONT:Heavy:7.0"             \
                          icon.color=$ORANGE                      \
                          icon.padding_right=-1                   \
                          icon=""                                 \
                          padding_right=-135                      \
                          drawing=on                              \
           --subscribe calendar.event                             \
                          calendar_fetch


                          # label.font="BigBlue_TerminalPlus Nerd Font:Book:12.0" \
                          # popup.height=15                   \
