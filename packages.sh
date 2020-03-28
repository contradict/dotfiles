#!/bin/bash
if [ "0" = "`id -u`" ]; then
    export DEBIAN_FRONTEND=noninteractive
    apt-get install -yq $(grep -vE "^\s*#" packages.txt | tr "\n" " ")
    wget -q https://bootstrap.pypa.io/get-pip.py
    python3 get-pip.py
    pip3 install -r requirements.txt
    rm get-pip.py
else
    echo "Need root permissions"
fi
