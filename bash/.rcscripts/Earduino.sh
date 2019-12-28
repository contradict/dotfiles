ARDUINO_VERSION=1.8.10
if echo $PATH | grep -vq arduino; then
    export PATH=${HOME}/arduino-${ARDUINO_VERSION}:${PATH}
fi
