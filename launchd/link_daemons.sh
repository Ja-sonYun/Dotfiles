#!/bin/sh

LAUNCH_AGENTS="./LaunchAgents/*.plist"

for f in $LAUNCH_AGENTS; do
    if [ "$LAUNCH_AGENTS" != "$f" ]; then
        sudo cp -f `realpath $f` "/Library/LaunchAgents/$(basename $f)"
        if [ "$1" == "--activate" ]; then
            launchctl load -w /Library/LaunchAgents/$(basename $f)
        elif [ "$1" == "--deactivate" ]; then
            launchctl unload -w /Library/LaunchAgents/$(basename $f)
        fi
    fi
done


LAUNCH_DAEMONS="./LaunchDaemons/*.plist"

for f in $LAUNCH_DAEMONS; do
    if [ "$LAUNCH_DAEMONS" != "$f" ]; then
        sudo cp -f `realpath $f` "/Library/LaunchDaemons/$(basename $f)"
        if [ "$1" == "--activate" ]; then
            launchctl load -w /Library/LaunchDaemons/$(basename $f)
        elif [ "$1" == "--deactivate" ]; then
            launchctl unload -w /Library/LaunchDaemons/$(basename $f)
        fi
    fi
done
