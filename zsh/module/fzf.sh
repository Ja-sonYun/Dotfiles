#!/bin/zsh


# zsh-vi-mode override these key bindings
# load below codes after zsh-vi-mode
# https://github.com/jeffreytse/zsh-vi-mode#execute-extra-commands
function zvm_after_init() {
    #fzf-tab config
    zstyle ":completion:*:git-checkout:*" sort false
    zstyle ':completion:*:descriptions' format '[%d]'
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    zstyle ':fzf-tab:*' switch-group ',' '.'

    # zstyle ':fzf-tab:*' fzf-bindings 'space:accept,backward-eof:abort'   # Space as accept, abort when deleting empty space
    zstyle ':fzf-tab:*' print-query ctrl-c        # Use input as result when ctrl-c
    # zstyle ':fzf-tab:*' accept-line enter         # Accept selected entry on enter
    zstyle ':fzf-tab:*' fzf-pad 4
    zstyle ':fzf-tab:*' prefix ''                 # No dot prefix
    zstyle ':fzf-tab:*' single-group color header # Show header for single groups
    zstyle ':fzf-tab:complete:(cd|ls|lsd|lsdd|j):*' fzf-preview '[[ -d $realpath ]] && exa --icons -1 --color=always -- $realpath'
    zstyle ':fzf-tab:complete:((micro|cp|rm|bat|less|code|nano|atom):argument-rest|kate:*)' fzf-preview 'bat --color=always -- $realpath 2>/dev/null || ls --color=always -- $realpath'
    zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-preview "git --git-dir=$UPDATELOCAL_GITDIR/\${word}/.git log --color --date=short --pretty=format:'%Cgreen%cd %h %Creset%s %Cred%d%Creset ||%b' ..FETCH_HEAD 2>/dev/null"
    zstyle ':fzf-tab:complete:updatelocal:argument-rest' fzf-flags --preview-window=down:5:wrap

    enable-fzf-tab


    # Setup fzf
    # ---------
    if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
      PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
    fi

    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/opt/homebrew/opt/fzf/shell/completion.zsh" 2> /dev/null

    # Key bindings
    # ------------
    source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

    # CTRL-/ to toggle small preview window to see the full command
    # CTRL-Y to copy the command into clipboard using pbcopy
    export FZF_CTRL_R_OPTS="
      --preview 'echo {}' --preview-window up:3:hidden:wrap
      --bind 'ctrl-/:toggle-preview'
      --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
}
