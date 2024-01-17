#!/bin/zsh

start_timewarrior_after_cd() {
    local current_directory=$(pwd)
    if [[ "$current_directory" != $HOME/Project/* ]]; then
        if [[ "$current_directory" == $HOME/Project ]]; then
            local is_timewarrior_running=$(timew | grep "Tracking" | wc -l | awk '{print $1}')
            if [[ "$is_timewarrior_running" == "0" ]]; then
                return 0
            fi

            timew stop
        fi
        return 0
    fi

    local project_definition_file=$HOME/Project/projects.toml
    if [[ ! -f "$project_definition_file" ]]; then
        echo "Project definition file not found. Creating one."
        touch $project_definition_file
        return 0
    fi

    local current_window_name=$(tmux display-message -p '#S')
    if [[ "$current_window_name" != "default" ]]; then
        return 0
    fi

    local relative_path=${$(pwd)#~/Project/}
    local top_level_directory=${relative_path%%/*}

    local tagname=$(yq -oy '.[] | select(.folders[] == "'$top_level_directory'") | path | .[0]' $project_definition_file)

    if [[ -z "$tagname" ]]; then
        return 0
    fi

    local current_active=$(timew | awk 'NR == 1 { print $2 }')
    if [[ "$current_active" == "$tagname" ]]; then
        return 0
    fi

    echo "Starting timewarrior for project $tagname"
    timew start $tagname

    return 0
}

add-zsh-hook chpwd start_timewarrior_after_cd
