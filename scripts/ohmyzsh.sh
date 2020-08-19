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
    fi
}

function install_autosuggestions {
    local ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
    if should_install zsh-autosuggestions "has_folder $ZSH_CUSTOM/plugins/zsh-autosuggestions"; then
        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
        sed -i '' 's/^plugins=(git)$/plugins=(git zsh-autosuggestions)/g' ~/.zshrc
    fi
}

function configure_z {
    if has_formulae z; then
        if should_configure z "! grep 'profile\.d/z.sh' ~/.zshrc"; then
            echo '. $(brew --prefix)/etc/profile.d/z.sh'  >> ~/.zshrc
        fi
    fi
}

install_ohmyzsh
install_autosuggestions
configure_z
