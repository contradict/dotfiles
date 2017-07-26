#!/bin/bash
bucket=$1
key_prefix=$2
directory=$3

for x in $(ls ${directory}); do
    if ! real=$(aws s3api head-object \
                    --bucket ${bucket} \
                    --key ${key_prefix}/$x \
                    --query ETag 2>/dev/null); then
        continue
    fi;
    local=$(./s3etag.sh ${directory}/$x 8);
    echo $x $(echo $real | sed -e 's|["\\]||g') $local;
done
