#!/bin/sh

topmost_off() {
    flock -en /tmp/sketchybar_show_native_bar.lock -c "sketchybar --bar hidden=on && sleep 3 && sketchybar --bar hidden=off"
}

case "$SENDER" in
  "mouse.entered") topmost_off ;;
esac
