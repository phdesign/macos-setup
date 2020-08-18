#!/bin/bash

set -eu

function install_ohmyzsh {
    if should_install oh-my-zsh 'test -d "$HOME/.oh-my-zsh"'; then
        RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""

        # Setup theme
        sed -i '' 's/^ZSH_THEME=.*$/ZSH_THEME="agnoster"/g' ~/.zshrc

        cat >> ~/.zshrc <<- EOM
# Set default user to hide it in the prompt
DEFAULT_USER="paul.heasley"

# Shorten longs paths
prompt_dir() {
  prompt_segment blue $CURRENT_FG '%(5~|%-1~/…/%3~|%4~)'
}
EOM

        # Setup zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
        sed -i '' 's/^plugins=(git)$/plugins=(git zsh-autosuggestions)/g' ~/.zshrc

        # Configure z if installed
        if $(brew ls --versions z > /dev/null); then
            echo '. $(brew --prefix)/etc/profile.d/z.sh'  >> ~/.zshrc
        fi
    fi
}

install_ohmyzsh
