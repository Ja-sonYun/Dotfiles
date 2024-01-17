#!/bin/sh

source "$HOME/.config/sketchybar/colors.sh"

function update() {
    left_todos=$(task count status:pending | tr -d ' ')
    COUNT="$left_todos"
    COLOR=$WHITE
    if [ "$COUNT" -eq "0" ]; then
        COUNT=􀆅
        COLOR=$GREEN
    fi

    args+=(--remove '/task.items\.*/')
    tasks=$(task status:pending export | jq -r '. |= sort_by(.urgency) | reverse | .[] | [.tags[0], .urgency, .id, .description] | @sh')
    items=""
    i=0
    while read -r tag urgency id desc; do
        i=$((i+1))
        # Escape single quotes, $ and empty spaces
        if [ "$tag" = "null" ]; then
            tag=""
        else
            tag="[$tag] "
        fi
        description=$(echo "$desc" | sed -e "s/^'//" -e "s/'$//")
        urgency=$(echo "$urgency" | sed -e "s/^'//" -e "s/'$//")
        args+=(--clone task.items.$i task.template)
        args+=(--set   task.items.$i label="$tag$description, $urgency"        \
                                     icon="􀀀"                              \
                                     drawing=on                            \
                                     position=popup.task                   \
                                     click_script="sketchybar              \
                                                       --set task.items.$i \
                                                             icon=􀝜;       \
                                                   task done $id &&        \
SENDER=forced /Users/jasony/config/window-management/mac/sketchybar/plugins/task.sh")
    done <<< "$tasks"

    args+=(--clone task.items.fetcher task.template)
    args+=(--set   task.items.fetcher \
        label="Open Reminder"         \
        icon="􀷾"                      \
        label.font="SF Pro:Bold:14.0"  \
        drawing=on                    \
        position=popup.task           \
        click_script="open -a Reminders")

    args+=(--set task label=$COUNT label.color=$COLOR)
    args+=(--animate tanh 15 --set task label.y_offset=5 label.y_offset=0)

    sketchybar -m "${args[@]}"
}

function popup() {
    sketchybar --set $NAME popup.drawing=$1
}

case "$SENDER" in
    "routine"|"forced") update
    ;;
    "mouse.entered") popup on
    ;;
    "mouse.exited"|"mouse.exited.global") popup off
    ;;
    "mouse.clicked") popup toggle
    ;;
    *) update
    ;;
esac
