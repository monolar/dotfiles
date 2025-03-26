# Activate pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# auto-activation if pyenv virtualenv in path
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"

current_pyenv_virtualenv() {
      echo -en `pyenv version-name`
}
