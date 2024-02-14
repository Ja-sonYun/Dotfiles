#!/bin/zsh

export _WAS_VENV_ACTIVATED=0
export _VENV_LOGGED_FILE_PATH = ~/.once_activate_venv
touch $_VENV_LOGGED_FILE_PATH

activate_venv_after_cd() {
    if [[ -f ".venv/bin/activate" && ! -n "$VIRTUAL_ENV" ]]; then
        local current_dir="$(pwd)"
        echo "Activate $current_dir/.venv/bin/activate"
        source .venv/bin/activate
        _WAS_VENV_ACTIVATED=1
        echo "$current_dir" >> $venv_logged_file_path
    elif [[ "$(pwd)" != "$(dirname \"$VIRTUAL_ENV\")"* ]]; then
        if [[ $_WAS_VENV_ACTIVATED -eq 1 ]]; then
            echo "Deactivate $VIRTUAL_ENV"
            deactivate
            _WAS_VENV_ACTIVATED=0
        fi
    fi
}

add-zsh-hook chpwd activate_venv_after_cd
