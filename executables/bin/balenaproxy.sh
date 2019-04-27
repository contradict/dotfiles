#!/bin/bash
trap 'kill $(jobs -p)' EXIT
. ~/.rcscripts/Dnvm.sh
HOSTNAME=$1
PORT=$2
deviceUUID=${HOSTNAME#bd-}
nonce=0
while true; do
    tunnelPort=$(echo ${deviceUUID}${nonce} | md5sum | tr -d abcdef | cut -b -4)
    if ! echo $tunnelPort | grep -q ^0 &&\
       [ ${#tunnelPort} -ge 4 ] &&\
       ! nc -z 127.0.0.1 ${tunnelPort} ; then
                break
    else
        echo bad tunnelPort $tunnelPort
        ! echo $tunnelPort | grep -q ^0; echo zeros: $?
        [ ${#tunnelPort} -ge 4 ]; echo length: $?
        ! nc -z 127.0.0.1 ${tunnelPort} ; echo connect: $?
    fi
    nonce=$(($nonce + 1))
done
balena tunnel $deviceUUID -p 22222:${tunnelPort} &
until nc -z 127.0.0.1 $tunnelPort; do
    sleep 1
done
ssh -p $tunnelPort root@127.0.0.1 nc 127.0.0.1 $PORT
