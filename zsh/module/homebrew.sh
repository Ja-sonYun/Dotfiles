if [ -e /opt/homebrew ]; then
    HOMEBREW_ROOT=/opt/homebrew
    export PATH="/opt/homebrew/opt/llvm@11/bin:$PATH"
    export PATH="/opt/homebrew/bin:$PATH"
else
    HOMEBREW_ROOT=/usr/local
fi
export HOMEBREW_ROOT
eval $(${HOMEBREW_ROOT}/bin/brew shellenv)
