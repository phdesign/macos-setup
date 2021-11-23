#!/bin/bash

set -eu

function configure_nvim {
    if should_configure vim "has_folder \"$HOME/.config/nvim\""; then
        ln -s $(pwd)/config/nvim ~/.config

        # Install pynvim
        python3 -m pip install --user --upgrade pynvim
    fi
}

function configure_nvim_docs {
    local vim_docs_dir="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/doc"
    if should_configure vim-docs "has_folder \"$vim_docs_dir\""; then
        mkdir -p $vim_docs_dir
        ln -s $(pwd)/config/vim-cheatsheet.txt $vim_docs_dir
        nvim -es -u ~/.config/nvim/init.vim -i NONE -c "helptags $vim_docs_dir" -c "qa" || true
    fi
}

function install_nvim_plug {
    # Must be run after configure_vim so that the init.vim exists
    local dest="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
    if should_install vim-plug "has_file \"$dest\""; then
        sh -c "curl -fLo \"$dest\" --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        echo "✅  Installing vim plugins..."
        nvim -es -u ~/.config/nvim/init.vim -i NONE -c "PlugInstall" -c "qa" || true
    fi
}

install_formulae neovim
#install_cask vimr
configure_nvim
install_nvim_plug
configure_nvim_docs
