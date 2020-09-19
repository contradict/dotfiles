#!/bin/bash

install_julia_executable() {
    local JULIA_VERSION="1.5"
    local JULIA_PATCH="1"
    local JULIA_MACHINE
    JULIA_MACHINE=$(uname -m)
    case ${JULIA_MACHINE} in
        x86_64)
            JULIA_ARCH="x64"
            ;;
        aarch64)
            JULIA_ARCH="aarch64"
            ;;
        *)
            echo "No julia configuration known for machine=${JULIA_MACHINE}"
            return
            ;;
    esac
    JULIA_ARCH="x64"
    JULIA_BASE_URL="https://julialang-s3.julialang.org/bin/linux/${JULIA_ARCH}/${JULIA_VERSION}/"
    JULIA_ARCHIVE="julia-${JULIA_VERSION}.${JULIA_PATCH}-linux-${JULIA_MACHINE}.tar.gz"
    cd /tmp || (echo "Unable to cd /tmp" && return)
    curl -O "${JULIA_BASE_URL}${JULIA_ARCHIVE}"
    tar -C /usr/local/stow -xzf "${JULIA_ARCHIVE}"
    stow "julia-${JULIA_VERSION}.${JULIA_PATCH}"
    cd - || (echo "Unable to restore working directory" && return)
}

if [ "0" = "$(id -u)" ]; then
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -yq $(grep -vE "^\s*#" packages.txt | tr "\n" " ")
    wget -q https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py
    pip3 install -r requirements.txt
    rm get-pip.py
    install_julia_executable
else
    echo "Need root permissions"
fi
