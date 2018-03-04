if [ -d  ~/.rbenv ]; then
    export PATH=~/.rbenv/bin:${PATH}
    eval "$(rbenv init -)"
fi

