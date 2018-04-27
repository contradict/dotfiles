#!/bin/bash

apply () {
  filename=$1
  shift
  patch_args=$*

  gotSubject=no
  msg=""

  cat $filename | while read line; do
    if [ "$line" == "---" ]; then

      patch $patch_args -p1 < $filename
      git commit -a -m "$msg"

      break
    fi
    if [ "$gotSubject" == "no" ]; then
      hdr=(${line//:/ })
      if [ "${hdr[0]}" == "Subject" ]; then
        gotSubject=yes
        msg="${hdr[@]:3}"
      fi
    else
      msg="$msg $line"
    fi
  done
}

apply $*
