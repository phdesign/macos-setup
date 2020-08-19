#!/bin/bash

set -eu

function install_ctags {
    if should_install universal-ctags "has_formulae universal-ctags"; then
        brew install --HEAD universal-ctags/universal-ctags/universal-ctags
    fi
}

function configure_vim {
    if should_configure vim "has_folder \"$HOME/.config/nvim\""; then
        mkdir -p "$HOME/.config/nvim"
        ln -s $(pwd)/config/init.vim ~/.config/nvim/init.vim

        # Install pynvim
        python3 -m pip install --user --upgrade pynvim

        cat << EOM
📝  TODO: Setup NeoVim macOS shortcut
    - Create applescript application using './config/neovim.applescript'
    - Copy icon from https://github.com/neovim/neovim.github.io/blob/master/logos/neovim-mark.png
    - Right click on application, click 'Get Info', select icon and paste
    - Drag application to Dock
EOM
    fi
}

function install_vim_plug {
    # Must be run after configure_vim so that the init.vim exists
    local dest="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim"
    if should_install vim-plug "has_file \"$dest\""; then
        sh -c "curl -fLo \"$dest\" --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
        # Install the plugins
        nvim -es -i NONE -c "PlugInstall" -c "qa" | true
    fi
}

function install_coc_extensions {
    if should_configure coc-extensions "has_folder \"$HOME/.config/coc/extensions\""; then
        local olddir=$(pwd)
        mkdir -p ~/.config/coc/extensions
        cd ~/.config/coc/extensions
        echo '{"dependencies":{}}'> package.json
        #npm install \
           #--global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod \
            #coc-tsserver \
            #coc-json \
            #coc-html \
            #coc-css \
            #coc-snippets \
            #coc-python
        nvim -es -u ~/.config/nvim/init.vim -i NONE -c "CocInstall -sync
            \ coc-tsserver
            \ coc-json
            \ coc-html
            \ coc-css
            \ coc-snippets
            \ coc-python
            \|q"
        cd "$olddir"
    fi
}

install_formulae neovim
install_ctags
#install_esctags
configure_vim
install_vim_plug
install_coc_extensions
