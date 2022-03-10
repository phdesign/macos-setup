#!/bin/bash

set -eu

function install_ohmyzsh {
    if should_install oh-my-zsh 'test -d "$HOME/.oh-my-zsh"'; then
        RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""

        # Setup theme
        sed -i '' 's/^ZSH_THEME=.*$/ZSH_THEME="agnoster"/g' ~/.zshrc

        cat >> ~/.zshrc <<- EOM
# Set default user to hide it in the prompt
export DEFAULT_USER="$(whoami)"

# Shorten longs paths
prompt_dir() {
  prompt_segment blue $CURRENT_FG '%(5~|%-1~/…/%3~|%4~)'
}

# Install z jump
. /opt/homebrew/etc/profile.d/z.sh

# Install fzf fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
EOM

        echo ". $(brew --prefix)/opt/asdf/libexec/asdf.sh" >> ~/.zshenv
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

# Install GNU core utilities (those that come with OS X are outdated).
install_formulae coreutils

# Command line tools
install_formulae jq
install_formulae the_silver_searcher
install_formulae tree
install_ohmyzsh
install_autosuggestions
install_formulae z
configure_z
install_formulae fzf
install_formulae gh
