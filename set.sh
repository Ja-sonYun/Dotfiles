#/bin/sh

# PARAMETER
# - $1 : file destination
# - $2 : source file
link_file () {
    if [ -f "$1" ]; then
        echo "[*] $1 exist. please remove it manually."
    else
        echo "[+] $2 -> $1"
        ln -s $2 $1
    fi
}

# link dotfiles
link_file $HOME/.zshrc $MYDOTFILES/zsh/zshrc
link_file $HOME/.bashrc $MYDOTFILES/bash/bashrc
link_file $HOME/.tmux.conf $MYDOTFILES/tmux/tmux.conf
link_file $HOME/.config/alacritty.yml $MYDOTFILES/configurations/alacritty/alacritty.yml

# link config files
if [ "$OS_ENV" = "m1" ]; then
    link_file $HOME/.config/alacritty.yml $MYDOTFILES/configurations/alacritty/alacritty.yml
    link_file $HOME/.config/gitui/key_bindings.ron $MYDOTFILES/configurations/gitui/key_bindings.ron
fi

# update global gitignore
echo "[!] update global gitignore"
git config --global core.excludesfile $MYDOTFILES/global_gitignore


# gh extensions
# -------------
# gh extension install dlvhdr/gh-dash
