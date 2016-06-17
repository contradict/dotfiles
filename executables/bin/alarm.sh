#!/bin/bash

while true; do
  for snd in `ls /usr/share/sounds/*.ogg`; do
    play -v 10 -G $snd
  done
done

