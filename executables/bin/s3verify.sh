#!/bin/bash
bucket=$1
key_prefix=$2
directory=$3
partsize=64
success=$(true)

for x in $(ls ${directory}); do
    if ! real=$(aws s3api head-object \
                    --bucket ${bucket} \
                    --key ${key_prefix}/$x \
                    --query ETag 2>/dev/null); then
        echo ${x} not in bucket
        continue
    fi;
    s3_tag=$(echo $real | sed -e 's|["\\]||g')
    local_tag=$(s3etag.sh ${directory}/$x ${partsize});
    if [ "${s3_tag}" != "${local_tag}" ]; then
        success=$(false)
        echo mismatch: ${x} ${s3_tag} ${local_tag};
    fi
done

exit ${success}
