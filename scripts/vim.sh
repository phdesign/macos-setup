#!/bin/bash

set -eu

function install_ctags {
    if should_install universal-ctags "has_formulae universal-ctags"; then
        brew install --HEAD universal-ctags/universal-ctags/universal-ctags
    fi
}

function configure_vim {
    if should_configure vim "test -d \"$HOME/.vim\""; then
        git clone git@github.com:phdesign/vim.git ~/.vim
        echo "runtime vimrc" > ~/.vimrc
        local olddir=$(pwd)
        cd ~/.vim
        git submodule update --init
        cd "$olddir"
    fi
}

install_formulae neovim
install_ctags
#install_esctags
configure_vim

