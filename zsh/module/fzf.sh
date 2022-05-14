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

# fzf stuff
[ -f $MYDOTFILES/utils/fzf/fzf.zsh ] && source $MYDOTFILES/utils/fzf/fzf.zsh
