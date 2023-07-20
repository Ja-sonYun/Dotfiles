#!/bin/bash

VIM="vim"
NVIM="nvim"
if [ "$1" = "$VIM" ] || [ "$1" = "$NVIM" ]; then
    if [ "$2" = "cur" ]; then
        echo ""
    else
        echo ""
    fi
elif [ "$1" = "zsh" ] || [ "$1" = "bash" ]; then
    if [ "$2" = "cur" ]; then
        echo ""
    else
        echo ""
    fi
elif [[ "$1" == *"ssh"* ]]; then
    if [ "$2" = "cur" ]; then
        echo ""
    else
        echo ""
    fi
elif [[ "$1" == *"gdb"* ]]; then
    if [ "$2" = "cur" ]; then
        echo ""
    else
        echo ""
    fi
elif [[ "$1" == *"docker"* ]]; then
    if [ "$2" = "cur" ]; then
        echo ""
    else
        echo ""
    fi
elif [[ "$1" == *"ruby"* ]]; then
    if [ "$2" = "cur" ]; then
        echo ""
    else
        echo ""
    fi
elif [[ "$1" == *"Python"* ]] || [[ "$1" == *"python"* ]]; then
    if [ "$2" = "cur" ]; then
        echo ""
    else
        echo ""
    fi
elif [[ "$1" == *"node"* ]]; then
    if [ "$2" = "cur" ]; then
        echo ""
    else
        echo ""
    fi
elif [[ "$1" == *"git"* ]]; then
    if [ "$2" = "cur" ]; then
        echo ""
    else
        echo ""
    fi
else
    echo $1
fi
