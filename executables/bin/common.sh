getFreePort()
{
    # find a port that is not presently in use
    local deviceUUID=${1}
    local nonce=0
    local tunnelPort
    while true; do
        tunnelPort=$(echo ${deviceUUID}${nonce} | md5sum | tr -d abcdef | cut -b -4)
        if ! echo $tunnelPort | grep -q ^0 &&\
            [ ${#tunnelPort} -ge 4 ] &&\
            ! nc -z 127.0.0.1 ${tunnelPort} ; then
            break
        else
            echo bad tunnelPort $tunnelPort
        fi
        nonce=$(($nonce + 1))
    done
    echo $tunnelPort
}

closeTunnel()
{
    # kill any tunnels to this device
    pkill -f -- "balena tunnel $deviceUUID"
}

startTunnel()
{
    local deviceUUID=${1}
    local tunnelPort=${2}
    _=$(echo '' | balena tunnel $deviceUUID -p 22222:${tunnelPort}) &
    until nc -z 127.0.0.1 $tunnelPort; do
        sleep 1
    done
}
