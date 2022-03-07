#!/bin/bash

set -eu

function install_vscode {
    if should_install vscode "has_application 'Visual Studio Code'"; then
        brew install visual-studio-code --cask

        code --install-extension dbaeumer.vscode-eslint
        code --install-extension eamodio.gitlens
        code --install-extension esbenp.prettier-vscode
        code --install-extension ms-vsliveshare.vsliveshare
        code --install-extension ms-vsliveshare.vsliveshare-audio
        code --install-extension ms-vsliveshare.vsliveshare-pack
        code --install-extension vscodevim.vim

        mkdir -p "$HOME/Library/Application Support/Code/User"
        ln -s $(pwd)/config/settings.json  "$HOME/Library/Application Support/Code/User"
    fi
}

install_vscode
