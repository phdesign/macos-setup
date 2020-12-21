#!/bin/bash

set -eu

vim_dir="$HOME/.vim"

function configure_vim {
    if should_configure vim "has_folder \"$vim_dir\""; then
        mkdir $vim_dir 
        # Temp folder is required for swap files
        mkdir "$vim_dir/tmp"
        ln -s $(pwd)/config/vimrc $vim_dir
    fi
}

function install_vim_plug {
    local dest="$vim_dir/autoload/plug.vim"
    if should_install vim-plug "has_file \"$dest\""; then
        sh -c "curl -fLo \"$dest\" --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        echo "✅  Installing vim plugins..."
        vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa" || true
    fi
}

function configure_vim_docs {
    local vim_docs_dir="$vim_dir/doc"
    if should_configure vim-docs "has_folder \"$vim_docs_dir\""; then
        mkdir -p $vim_docs_dir
        ln -s $(pwd)/config/vim-cheatsheet.txt $vim_docs_dir
        vim -es -u ~/.vimrc -i NONE -c "helptags $vim_docs_dir" -c "qa" || true
    fi
}

install_formulae macvim
configure_vim
install_vim_plug
configure_vim_docs
