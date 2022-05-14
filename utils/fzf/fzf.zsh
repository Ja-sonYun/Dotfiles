export FZF_PACKAGE_PATH=$MYDOTFILES/utils/fzf

# Setup fzf
# ---------
if [[ ! "$PATH" == *fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$FZF_PACKAGE_PATH/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_PACKAGE_PATH/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$FZF_PACKAGE_PATH/fzf/shell/key-bindings.zsh"
