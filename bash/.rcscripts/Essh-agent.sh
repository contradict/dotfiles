SSH_DIR="$HOME/.ssh"
SSH_ENV="${SSH_DIR}/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    if [ ! -d ${SSH_DIR} ]; then
        echo "Creating new SSH directory"
        mkdir -p ${SSH_DIR}
        chmod 700 ${SSH_DIR}
    fi
    touch ${SSH_ENV}
    chmod 600 "${SSH_ENV}"
    /usr/bin/ssh-agent | sed '/^echo/d' > "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
}

function should_start_agent {
    if [ -n ${SSH_AUTH_SOCK} ]; then
        # have an auth sock
        if echo ${SSH_AUTH_SOCK} | grep -q run >>/dev/null; then
            # auth sock is for gnome-keyring, start our own
            true
        else
            # good auth sock, no need
            false
        fi
    fi
    # no auth sock, go for it
    true
}

# Source SSH settings, if applicable
if should_start_agent; then
    if [ -f "${SSH_ENV}" ]; then
        . "${SSH_ENV}" > /dev/null
        kill -0 $SSH_AGENT_PID 2>/dev/null || {
            start_agent
        }
    else
        start_agent
    fi
fi

