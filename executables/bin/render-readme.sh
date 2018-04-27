#!/bin/bash
jq --slurp --raw-input '{"text": "\(.)", "mode": "markdown"}' < ${1} | \
    curl --data @- https://api.github.com/markdown > $(basename ${1} .md).html
