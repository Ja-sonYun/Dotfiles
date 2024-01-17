# alias Python3.9=
# alias Python3.10="$(brew --prefix)/opt/python@3.10/bin/python3.10"
# alias Python3.11="$(brew --prefix)/opt/python@3.11/bin/python3.11"

function pythonv() {
    if [ -z "$1" ]; then
        echo "Usage: PythonV <version>"
        return 1
    fi

    echo "$(brew --prefix)/opt/python@${1}/bin/python${1}"
}

function rdm() {
    help="Usage: rdm <open type> <open path>
    open type:
        tui: open with tui
        gui: open with gui"

    if [[ -z "$2" ]]; then
        echo "$help"
        return 1
    fi

    case $1 in
        "tui")
            pandoc $2 | lynx -stdin
            ;;
        "gui")
            grip -b $2
            ;;
        *)
            echo "$help"
            return 1
            ;;
    esac
}
