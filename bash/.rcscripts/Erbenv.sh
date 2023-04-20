if [ -d  ~/.rbenv ] && echo $PATH | grep -vq rbenv ; then
    export PATH=~/.rbenv/bin:${PATH}
    eval "$(rbenv init -)"
fi

