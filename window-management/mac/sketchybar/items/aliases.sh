#!/bin/sh


default_opts="alias.color=$LABEL_COLOR  \
              drawing=on                \
              padding_right=-20         \
              padding_left=-2"


sketchybar --add alias "TextInputMenuAgent,Item-0" right        \
           --set "TextInputMenuAgent,Item-0" $default_opts      \
                                             click_script="open /System/Library/PreferencePanes/Keyboard.prefPane"

sketchybar --add alias "Control Center,WiFi" right      \
           --set "Control Center,WiFi" $default_opts    \
                                       click_script="$PLUGIN_DIR/open_menubar_controlcenter"
