#!/bin/bash
. common.sh
trap 'closeTunnel' EXIT
HOSTNAME=$1
PORT=$2
deviceUUID=${HOSTNAME#bd-}
tunnelPort=$(getFreePort $deviceUUID)
startTunnel ${deviceUUID} ${tunnelPort}
ssh -p $tunnelPort root@127.0.0.1 nc 127.0.0.1 ${PORT}
