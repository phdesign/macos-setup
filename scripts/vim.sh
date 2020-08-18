#!/bin/bash

set -eu

function install_ctags {
    if should_install universal-ctags "has_formulae universal-ctags"; then
        brew install --HEAD universal-ctags/universal-ctags/universal-ctags
    fi
}

function configure_vim {
    if should_configure vim "test -d \"$HOME/.config/nvim\""; then
        mkdir -p "$HOME/.config/nvim"
        cp ../config/init.vim "$HOME/.config/nvim/"
    fi
}

function install_vim_plug {
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

install_formulae neovim
install_ctags
#install_esctags
install_vim_plug
configure_vim

