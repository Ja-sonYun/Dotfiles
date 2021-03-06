# autocompletes
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

# terraform
enable_completer terraform terraform

# gh
gh_autocomp_path=/usr/local/share/zsh/site-functions/_gh
if (( $+commands[ghw] )) && [ -f $gh_autocomp_path ]; then
    gh completion -s zsh > $gh_autocomp_path
fi
