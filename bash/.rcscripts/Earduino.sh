if echo $PATH | grep -vq arduino; then
    export PATH=${HOME}/arduino-1.8.8:${PATH}
fi
