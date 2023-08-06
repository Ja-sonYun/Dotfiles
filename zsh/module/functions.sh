function ssh_portforward() {
    case "$1"  in
        -h|--help)
            echo "Usage: ssh_portforward <port> [ssh options]"
            return 0
            ;;
    esac

    local PORT=$1
    shift
    ssh -L ${PORT}:localhost:${PORT} $@
}
