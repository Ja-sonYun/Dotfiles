# ++++++++++++++++++++++++++++++
# load foreign package's hookers
# ++++++++++++++++++++++++++++++

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# nvm
# export NVM_DIR="$HOME/.nvm"
# if [ -d "$NVM_DIR" ]; then
#     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#     [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# fi

# poetry
export PATH="$HOME/.poetry/bin:$PATH"
export PIPENV_VENV_IN_PROJECT=1
export ENV="jason"

# direnv
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi
