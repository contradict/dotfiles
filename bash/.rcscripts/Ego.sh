if [ -z ${GOPATH} ]; then
    export GOPATH=${HOME}/src/gopath
    export PATH=${GOPATH}/bin:$PATH
fi
