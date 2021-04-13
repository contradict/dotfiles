SSH_DIR="$HOME/.ssh"
SSH_ENV="${SSH_DIR}/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    if [ ! -d "${SSH_DIR}" ]; then
        echo "Creating new SSH directory"
        mkdir -p "${SSH_DIR}"
        chmod 700 "${SSH_DIR}"
    fi
    touch "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    /usr/bin/ssh-agent | sed '/^echo/d' > "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    ALLIDS=$(find .ssh -path '*id_*' ! -path '*.pub')
    /usr/bin/ssh-add ${ALLIDS}
}

function should_start_agent {
    if [ -n "${SSH_AUTH_SOCK}" ]; then
        # have an auth sock
        if echo "${SSH_AUTH_SOCK}" | grep -q run >>/dev/null; then
            # auth sock is for gnome-keyring, start our own
            true
        elif echo "${SSH_AUTH_SOCK}" | grep -q 'ssh-' >>/dev/null; then
            # using ssh tunneled auth, no need to start an agent
            false
        else # ensure auth sock is for running agent
            if PID=$(pidof ssh-agent); then
                if echo ${SSH_AUTH_SOCK} | grep -q $PID; then
                    # ssh agent is running and pid appears in sock name,
                    # the running one is probably fine
                    false
                else
                    # A socket name is exported, but it does not correspond to
                    # the running ssh-agent, need to start a new one
                    true
                fi
            else
                # no ssh-agent running, need to start one
                true
            fi
        fi
    else
        # no auth sock, go for it
        true
    fi
}

# Source SSH settings, if applicable
if should_start_agent; then
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        pidof ssh-agent | grep -q "${SSH_AGENT_PID}" || {
            start_agent
        }
    else
        start_agent
    fi
fi

