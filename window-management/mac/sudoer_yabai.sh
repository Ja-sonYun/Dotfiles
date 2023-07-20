#!/bin/sh

YABAI_PATH=$(which yabai)
YABAI_HASH=$(shasum -a 256 $YABAI_PATH | awk '{print $1}')
WHOAMI=$(whoami)

echo "$WHOAMI ALL=(root) NOPASSWD: sha256:$YABAI_HASH $YABAI_PATH --load-sa"
echo
echo "Open visudo and paste the above line into the file."
echo "\$ sudo visudo -f /etc/private/sudoers.d/yabai"
