if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi
fi
