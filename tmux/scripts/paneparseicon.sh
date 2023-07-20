ARG=$1
ISVIM=""
NOTVIM=0
NOTBON=0
LA=""
# shell.sh + (~/.s/dwd) - NVIM
if [[ $ARG == *"NVIM"* ]]; then
    if [[ $ARG == *" + ("* ]]; then
        ISVIM=" "
        LA=" #[fg=colour196]#[fg=default]"
    else
        ISVIM=" "
        LA=" "
    fi
else
    NOTVIM=1
fi


arrIN=(${ARG/ - / })
INF=${arrIN[1]}
if [ $NOTVIM -eq 0 ] && [ "${arrIN[1]}" == "+" ]; then
    INF=${arrIN[2]}
fi
# PWD="${arrIN[2]/NVIM/}"

OUTPUT="$ISVIM$arrIN"
BONJOURN=`scutil --get LocalHostName`.
if [[ $OUTPUT == *$BONJOURN* ]]; then
    OUTPUT="${OUTPUT/$BONJOURN/ }"
else
    NOTBON=1
    TE=`$CONFIG/tmux/scripts/getshortenpwd.sh $INF/`\)
    TE=${TE:1}
    OUTPUT=$OUTPUT$TE
fi

if [ $NOTVIM -eq 1 ] && [ $NOTBON -eq 1 ]; then
    # echo " no info"
    echo $1
else
    echo $OUTPUT$LA
fi
