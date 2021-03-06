#!/bin/bash

STOW=/usr/bin/stow

if [ ! -x ${STOW} ]; then
    echo "Need to apt-get install stow"
    exit 1
fi

STOWARGS="-v -t ${HOME}"

VIM=/usr/bin/vim
VIMDIR=${HOME}/.vim
VUNDLEDIR=${VIMDIR}/bundle/Vundle.vim

easy_packages="bash gdb git readline tmux executables pylint terminfo"

install_easy() {
	${STOW} "${STOWARGS}" "${1}"
}

install_vim() {
    install_easy vim_full
    if [ -d "${VUNDLEDIR}" ]; then
        pushd "${VUNDLEDIR}"
        git pull
        popd
        ${VIM} +PluginInstall! +qall
    else
        git clone https://github.com/VundleVim/Vundle.vim.git "${VUNDLEDIR}"
        ${VIM} +PluginInstall +qall
    fi
    pushd "${VIMDIR}/bundle/YouCompleteMe"
    python3 install.py --clang-completer
    popd
}

install_julia() {
    mkdir -p "${HOME}/.julia/config"
    stow -t "${HOME}/.julia/config" julia
}

rm ~/.bash_logout ~/.bashrc ~/.profile

for pkg in ${easy_packages}; do
    install_easy "$pkg"
done
pushd git && cp .gitconfig.template .gitconfig ; popd

if [ -x "$(which vim)" ] && [ -x "$(which git)" ] && vim --version | grep -q +python; then
    echo "Installing complete vim config"
    install_vim
else
    echo "Installing simple vim config, need git and vim with python support for full config"
    install_easy vim
fi

install_julia
