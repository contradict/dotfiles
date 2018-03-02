#!/bin/bash
if [ "0" = "`id -u`" ]; then
    apt-get install $(grep -vE "^\s*#" packages.txt | tr "\n" " ")
    wget -q https://bootstrap.pypa.io/get-pip.py
    python get-pip.py
    pip install -r requirements.txt
    python3 get-pip.py
    pip3 install -r requirements.txt
    rm get-pip.py
else
    echo "Need root permissions"
fi
