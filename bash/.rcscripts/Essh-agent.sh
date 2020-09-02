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
    (
      shopt -s extglob
      /usr/bin/ssh-add -q ~/.ssh/id_!(*.pub)
    )
}

function should_start_agent {
    if [ -n "${SSH_AUTH_SOCK}" ]; then
        # have an auth sock
        if echo ${SSH_AUTH_SOCK} | grep -q run >>/dev/null; then
            # auth sock is for gnome-keyring, start our own
            true
        else
            # good auth sock, no need
            false
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
        pidof ssh-agent | grep -q ${SSH_AGENT_PID} || {
            start_agent
        }
    else
        start_agent
    fi
fi

