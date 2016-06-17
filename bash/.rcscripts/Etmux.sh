# TMUX
# Sensibly nest one level of tmux over ssh.
# Assuming tmux everywhere defualts to C-b escape,
# set local escape to C-a before connecting to remote host.
# If not running interactively, do not do anything
[[ $- != *i* ]] && return
if which tmux 2>&1 >/dev/null; then
    _set_tmux_option() {
        local SAVED
        if [ -n "$TMUX" ]; then
            SAVED=$(tmux show-options -wqv $1)
            if [ -n "$2" ]; then
                tmux set-option -wq $1 $2
            else
                tmux set-option -wqu $1
            fi
        fi
        echo ${SAVED}
    }
    _set_alternate_prefix() {
        _set_tmux_option prefix C-a
    }
    _set_alternate_color() {
        _set_tmux_option status-bg colour22
    }
    ssh_inside_tmux() {
        local SAVEDPREFIX=$(_set_alternate_prefix)
        local SAVEDCOLOR=$(_set_alternate_color)
        ssh $@
        _set_tmux_option prefix ${SAVEDPREFIX} >>/dev/null
        _set_tmux_option status-bg ${SAVEDCOLOR} >>/dev/null
    }
    alias ssh=ssh_inside_tmux
fi
