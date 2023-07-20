#!/bin/sh

function update() {
    sketchybar --set calendar icon="$(date '+%a %d. %b')" label="$(date '+%H:%M')"
}

function popup() {
    sketchybar --set calendar popup.drawing=$1
}

case "$SENDER" in
    "routine"|"system_woke"|"forced") update
    ;;
    "mouse.entered") popup on
    ;;
    "mouse.exited"|"mouse.exited.global") popup off
    ;;
esac
