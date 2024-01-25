#!/bin/zsh

activate_venv_after_cd() {
  if [[ -f ".venv/bin/activate" ]]; then
    echo "Activate $(pwd)/.venv/bin/activate"
    source .venv/bin/activate
  elif [ -n "$VIRTUAL_ENV" ]; then
    deactivate
    echo "Python venv deactivated"
  fi
}

add-zsh-hook chpwd activate_venv_after_cd
