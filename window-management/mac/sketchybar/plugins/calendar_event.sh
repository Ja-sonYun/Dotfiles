#!/bin/sh

schedules=$(shortcuts run GenerateSchedule | dasel -r toml -w json)

function render() {
    date=$(date '+%b %d, %Y')
    jq_query="[.[] | select(.start_date | contains(\"$date\"))]
        | sort_by(.start_date | strptime(\"%b %d, %Y %H:%M\"))
        | .[]
        | [.start_date, .end_date, .is_all_day, .title]
        | @tsv"
    events=$(echo "$schedules" | jq -r "$jq_query")

    args=(--remove '/calendar.lines\.*/')
    i=0
    while read -r sa sd sb start_time ea ed eb end_time is_all_day title; do
        i=$((i+1))

        if [ "$is_all_day" = "Yes" ]; then
            time="All day"
        else
            time="$start_time ~ $end_time"
        fi

        # Add a new line to the sketchybar popup
        args+=(--clone calendar.lines.$i calendar.template)
        args+=(--set   calendar.lines.$i                            \
                                         icon="$time"               \
                                         label="$title"             \
                                         position=popup.calendar    \
                                         drawing=on)
    done <<< "$events"

    args+=(--animate tanh 15 --set calendar icon.y_offset=5 icon.y_offset=0)
    sketchybar -m "${args[@]}"
}

function current_event() {
    FORMAT="%b %d, %Y %H:%M"
    CURRENT_DATE=$(date -v+10M +"${FORMAT}")
    events=$(echo "$schedules" | jq -r --arg current "${CURRENT_DATE}" --arg format "${FORMAT}" \
        '[.[]
            | select(
                (.is_all_day | contains("No"))
                and (.start_date | strptime($format)) <= ($current | strptime($format))
                and (.end_date | strptime($format)) >= ($current | strptime($format))
                )]
                | .[]
                | [.end_date, .title]
                | @tsv')

    formatted=""
    while read -r ea ed eb end_time event; do
        formatted="${formatted} ${event},"
    done <<< "$events"
    formatted=$(echo $formatted | sed 's/.$//')

    args=()

    if [ ${#formatted} -gt 17 ]; then
        formatted=$(echo $formatted | cut -c 1-17)
        formatted="${formatted}..."
    fi

    if [ "$formatted" == "" ]; then
        args+=(--set calendar y_offset=0)
        args+=(--set calendar.event label="" drawing=on icon="")
    else
        args+=(--set calendar y_offset=4)
        args+=(--set calendar.event label="$formatted" drawing=on icon="􀧞")
    fi

    sketchybar -m "${args[@]}"
}


render
current_event
