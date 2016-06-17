#!/bin/bash
wordsfile=/usr/share/dict/american-english
nwords=`wc -l ${wordsfile}| cut -d" " -f1`
head ${wordsfile} -n $((`cat /dev/urandom | hexdump -n4 -e '1/4 "%u"'`
* ${nwords} / 4294967295)) | tail -n1
