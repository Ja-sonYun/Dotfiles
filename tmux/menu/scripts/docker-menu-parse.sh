case "$1" in
    "current_context")
        docker context ls | awk '{ if ($2 == "*" ) print "#[fg=yellow]" $1 }'
        ;;
esac
