# Activate pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# auto-activation if pyenv virtualenv in path
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init --path)"

current_pyenv_virtualenv() {
    # Check if we're in a .venv (most specific)
    if [[ -n "$VIRTUAL_ENV" ]]; then
        local venv_name=$(basename "$VIRTUAL_ENV")
        local python_version=$(python --version 2>&1 | cut -d' ' -f2)
        echo -en "venv:${venv_name}(${python_version})"
        return
    fi

    # Check if we're in a conda environment
    if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        local python_version=$(python --version 2>&1 | cut -d' ' -f2)
        echo -en "conda:${CONDA_DEFAULT_ENV}(${python_version})"
        return
    fi

    # Check if we're in a pyenv-virtualenv
    local pyenv_version=$(pyenv version-name 2>/dev/null)
    if [[ -n "$pyenv_version" && "$pyenv_version" != "system" ]]; then
        # If it contains a slash, it's likely a virtualenv
        if [[ "$pyenv_version" == *"/"* ]]; then
            local env_name=${pyenv_version##*/}  # Get part after last slash
            echo -en "pyenv:${env_name}"
        else
            echo -en "pyenv:${pyenv_version}"
        fi
        return
    fi

    # Fallback to system Python
    echo -en "sys:$(python --version 2>&1 | cut -d' ' -f2)"
}
