#!/bin/bash
obj_name="$(git rev-parse --verify $1)"
shift
git log "$@" --pretty=format:'%T %h %cd %s' \
| while read tree commit date subject ; do
    if git ls-tree -r $tree | grep -q "$obj_name" ; then
        echo $commit "$date" "$subject"
    fi
done
