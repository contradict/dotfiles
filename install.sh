#!/bin/bash

STOW=/usr/bin/stow
STOWARGS="-v -t ${HOME}"

VIM=/usr/bin/vim
VIMDIR=${HOME}/.vim
VUNDLEDIR=${VIMDIR}/bundle/Vundle.vim

easy_packages="bash gdb git readline vim tmux"

install_easy() {
	${STOW} ${STOWARGS} ${1}
}

install_vim() {
    if [ -d ${VUNDLEDIR} ]; then
        pushd ${VUNDLEDIR}
        git pull
        popd
        ${VIM} +PluginInstall! +qall
    else
        git clone https://github.com/VundleVim/Vundle.vim.git ${VUNDLEDIR}
        ${VIM} +PluginInstall +qall
    fi
    pushd ${VIMDIR}/bundle/YouCompleteMe
    ./install.py --clang-completer
    popd
}

for pkg in ${easy_packages}; do
    install_easy $pkg
done

install_vim
