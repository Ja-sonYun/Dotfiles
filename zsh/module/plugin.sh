export ZPLUG_HOME=~/.zplug
if [ ! -d "$ZPLUG_HOME" ]; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "plugins/brew", from:oh-my-zsh
zplug "plugins/brew-cask", from:oh-my-zsh
zplug "plugins/tmux", from:oh-my-zsh
zplug "plugins/tmuxinator", from:oh-my-zsh
zplug "docker/compose", use:contrib/completion/zsh
zplug "docker/cli", use:contrib/completion/zsh

zplug "jeffreytse/zsh-vi-mode"

if [[ `uname` == "Darwin" ]]; then
    zplug "plugins/osx", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
fi

zplug "Aloxaf/fzf-tab", from:github
zplug "plugins/git", from:oh-my-zsh
zplug "Seinh/git-prune", from:github

zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh", defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
