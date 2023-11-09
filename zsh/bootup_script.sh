#!/bin/zsh

# tmux set status on

cat << EOF

======================================================
    ███       ▄▄▄▄███▄▄▄▄   ███    █▄  ▀████    ▐████▀
▀█████████▄ ▄██▀▀▀███▀▀▀██▄ ███    ███   ███▌   ████▀
   ▀███▀▀██ ███   ███   ███ ███    ███    ███  ▐███
    ███   ▀ ███   ███   ███ ███    ███    ▀███▄███▀
    ███     ███   ███   ███ ███    ███    ████▀██▄
    ███     ███   ███   ███ ███    ███   ▐███  ▀███
    ███     ███   ███   ███ ███    ███  ▄███     ███▄
   ▄████▀    ▀█   ███   █▀  ████████▀  ████       ███▄
======================================================

EOF
echo "OS_ENV : "$OS_ENV
if [ $OS_ENV = "m1" ]; then
    echo "cheking brew..."
    sketchybar --trigger brew_update > /dev/null 2>&1 & disown
    sketchybar --trigger task_update > /dev/null 2>&1 & disown
    sketchybar --trigger calendar_fetch > /dev/null 2>&1 & disown
    # echo "dumping all..."
    # cd $CONFIG && make dump > /dev/null 2>&1 & disown
    # echo "syncing nvim..."
    # vi --headless "+Lazy! sync" +qa 2> /dev/null & disown
fi
echo "whoami : "`whoami`
echo "uptime : "`uptime`
echo "date   : "`date`
echo ""
echo ""

rm -f /tmp/tmux_popup_log
