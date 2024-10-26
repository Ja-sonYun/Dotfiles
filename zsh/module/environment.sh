# export python global venv
# Should be come before brew
export PATH="$PATH:/Users/jasony/.globalpip/.venv/bin"

export PATH="$PATH:$CONFIG/scripts"
export PATH="$PATH:$HOME/.bin"
export PATH="$PATH:/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:/usr/local/bin"

export PATH="$PATH:$CONFIG/shortcuts/scripts"

# Default flags
export LDFLAGS=""
export CPPFLAGS=""

# export XDG_CONFIG_HOME=".mydotfiles"
export ZSH="$HOME/.oh-my-zsh"

export EDITOR="nvim"

if [[ $(uname) == "Darwin" ]]; then
    source "$CONFIG"/zsh/module/homebrew.sh
    export OS_ENV=m1
    export PATH="$CONFIG/bin/m1:$PATH"

    # to support mysql_config
    export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

elif [[ $(uname) == "Linux" ]]; then
    export OS_ENV=wsl
    export PATH="$CONFIG/bin/wsl:$PATH"
fi

export PATH="$CONFIG/scripts:$PATH"
export PATH="$CONFIG/zellij/scripts:$PATH"

export TEMP_PATH="$HOME/.temp"
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"

export GOPATH=$HOME/go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

export WEECHAT_HOME="~/.weechat"

# OpenCV or etc build
export DYLD_FALLBACK_LIBRARY_PATH="$(xcode-select --print-path)/usr/lib/"

if [ "$OS_ENV" = "m1" ]; then
    export PYTHON_BASE_PATH="/opt/homebrew/bin/python3"
    export PIP_BASE_PATH="/opt/homebrew/bin/pip3"
fi

# ++++++++++++++++++++++++++++++
# load foreign package's hookers
# ++++++++++++++++++++++++++++++

# poetry
export PATH="$HOME/.poetry/bin:$PATH"
export PIPENV_VENV_IN_PROJECT=1
export ENV="jason"

# direnv
if command -v direnv 1>/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

# bzip
LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/bzip2/lib"
CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/bzip2/include"

# Poetry
export PATH="/Users/jasony/Library/Python/3.10/bin:$PATH"

# Gnutools
export PATH="$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH"
export PATH="$(brew --prefix)/opt/gnu-getopt/bin:$PATH"
export PATH="$(brew --prefix)/opt/gnu-time/bin:$PATH"
export PATH="$(brew --prefix)/opt/gnu-sed/bin:$PATH"
export PATH="$(brew --prefix)/opt/gnu-tar/bin:$PATH"
export PATH="$(brew --prefix)/opt/gnu-tar/libexec/gnubin:$PATH"
export PATH="$(brew --prefix)/opt/grep/bin:$PATH"
export PATH="$(brew --prefix)/opt/make/libexec/gnubin:$PATH"

# requirements to compile lxml
LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/libxml2/lib"
CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/libxml2/include"

LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/libxslt/lib"
CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/libxslt/include"

LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/zlib/lib"
CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/zlib/include"

LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/libpq/lib"
CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/libpq/include"

# Colima/orbstack
# export DOCKER_HOST="unix:///$HOME/.colima/docker.sock"
# export DOCKER_HOST="unix:///Users/jasony/.orbstack/run/docker.sock"

export GPG_TTY=$(tty)

# Created by `pipx` on 2023-04-13 09:31:33
export PATH="$PATH:/Users/jasony/.local/bin"

export PIPX_DEFAULT_PYTHON=$(which python3)

# Keybase
export PATH="/Applications/Keybase.app/Contents/SharedSupport/bin:$PATH"

# Navi
export NAVI_PATH="$CONFIG/navi"

export GLOBAL_PYTHON="$HOME/.globalpip/.venv/bin/python3"

# LLVM
export DYLD_LIBRARY_PATH=/opt/homebrew/opt/llvm/lib:$DYLD_LIBRARY_PATH
