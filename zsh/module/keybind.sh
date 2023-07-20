bindkey -v

zle -N edit-command-line
bindkey '^v' edit-command-line

bindkey -r '^S'
bindkey -r '^Y'
bindkey -r '^D'

# bindkey "\e\e[D" backward-word
# bindkey "\e\e[C" forward-word

# prevent ctrl-d
set -o ignoreeof
