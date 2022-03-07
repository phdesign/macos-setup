#!/bin/bash

set -eu

function install_vscode {
    if should_install vscode "has_application 'Visual Studio Code'"; then
        brew install visual-studio-code --cask

        code --install-extension baeumer.vscode-eslint
        code --install-extension amodio.gitlens
        code --install-extension sbenp.prettier-vscode
        code --install-extension kjustjoshing.vscode-text-pastry
        code --install-extension s-vsliveshare.vsliveshare
        code --install-extension s-vsliveshare.vsliveshare-audio
        code --install-extension s-vsliveshare.vsliveshare-pack
        code --install-extension scodevim.vim

        mkdir -p "$HOME/Library/Application Support/Code/User"
        ln -s $(pwd)/config/settings.json  "$HOME/Library/Application Support/Code/User"
    fi
}

install_vscode
