bindkey -v

zle -N edit-command-line
bindkey '^v' edit-command-line

bindkey -r '^S'
bindkey -r '^Y'
bindkey -r '^D'

bindkey -r '^j'
bindkey -r '^l'
bindkey -r '^k'
bindkey -r '^h'

# bindkey "\e\e[D" backward-word
# bindkey "\e\e[C" forward-word

# prevent ctrl-d
set -o ignoreeof
