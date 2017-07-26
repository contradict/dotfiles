#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 file partSizeInMb";
    exit 0;
fi

file=$1

if [ ! -f "$file" ]; then
    echo "Error: $file not found." 
    exit 1;
fi

partSizeInMb=$2
fileSizeInMb=$(du -m "$file" | cut -f 1)
parts=$((fileSizeInMb / partSizeInMb))
if [[ $((fileSizeInMb % partSizeInMb)) -gt 0 ]]; then
    parts=$((parts + 1));
fi

if [[ parts -eq 1 ]]; then
    md5sum -b $file | cut -d' ' -f1
    exit
fi

checksumFile=$(mktemp -t s3md5XXXXX)

for (( part=0; part<$parts; part++ ))
do
    skip=$((partSizeInMb * part))
    $(dd bs=1M count=$partSizeInMb skip=$skip if="$file" 2>/dev/null |\
      md5sum -b |\
      cut -d' ' -f 1 >>"$checksumFile")
done

echo $(xxd -r -p $checksumFile | md5sum -b | cut -d' ' -f 1)-$parts
rm $checksumFile
