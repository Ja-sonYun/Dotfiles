# autocompletes
AUTOCOMP_PATH="$(brew --prefix)/share/zsh/site-functions"
FPATH="${AUTOCOMP_PATH}:${FPATH}"

autoload -Uz compinit && compinit

# Arguments
#   $1 : completer
#   $2 : command
function enable_completer() {
    if command -v $1 &> /dev/null; then
        complete -C $1 $2
    else
        echo "Completer of $2 is not found."
    fi
}

# aws
enable_completer aws_completer aws

# azure
source "${HOMEBREW_PREFIX}/etc/bash_completion.d/az"

# terraform
enable_completer terraform terraform

# gh
gh_autocomp_path=$AUTOCOMP_PATH/_gh
if (( $+commands[ghw] )) && [ -f $gh_autocomp_path ]; then
    gh completion -s zsh > $gh_autocomp_path
fi

# poetry
poetry_autocomp_path=$AUTOCOMP_PATH/_poetry
if [ ! -f $poetry_autocomp_path ]; then
    poetry completions zsh > $poetry_autocomp_path
    chmod +x $poetry_autocomp_path
fi
