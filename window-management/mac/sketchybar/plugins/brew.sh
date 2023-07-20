#!/bin/sh

source "$HOME/.config/sketchybar/colors.sh"

COUNT=$(brew outdated | wc -l | tr -d ' ')

COLOR=$RED

case "$COUNT" in
  [3-5][0-9]) COLOR=$ORANGE
  ;;
  [1-2][0-9]) COLOR=$YELLOW
  ;;
  [1-9]) COLOR=$WHITE
  ;;
  0) COLOR=$GREEN
     COUNT=􀆅
  ;;
esac

args+=(--set $NAME label=$COUNT icon.color=$COLOR)
args+=(--animate tanh 15 --set $NAME label.y_offset=5 label.y_offset=0)
sketchybar -m "${args[@]}"
