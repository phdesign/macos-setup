#!/bin/bash

set -eu

function install_ohmyzsh {
    if should_install oh-my-zsh 'test -d "$HOME/.oh-my-zsh"'; then
        RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ""

        # Setup theme
        sed -i '' 's/^ZSH_THEME=.*$/ZSH_THEME="agnoster"/g' ~/.zshrc

        cat >>~/.zshrc <<-"EOM"
# Set default user to hide it in the prompt
export DEFAULT_USER="$(whoami)"

# Shorten longs paths
prompt_dir() {
  prompt_segment blue $CURRENT_FG '%(5~|%-1~/…/%3~|%4~)'
}

alias uuid='python3 -c "import uuid; print(uuid.uuid4())"'
alias dequote='python3 -c '\''import sys; print(sys.stdin.read().decode("unicode_escape"))'\'
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
        if should_configure z "grep '\/z\.sh' ~/.zshrc"; then
            echo "\n# Install z jump\n. $(brew --prefix)/etc/profile.d/z.sh" >>~/.zshrc
        fi
    fi
}

function configure_asdf {
    if has_formulae asdf; then
        if should_configure asdf "grep 'asdf\.sh' ~/.zshrc"; then
            echo "\n# Install asdf version manager\n. $(brew --prefix asdf)/libexec/asdf.sh" >>${ZDOTDIR:-~}/.zshrc
            . ~/.zshrc
            asdf plugin add nodejs
            asdf plugin add python
            asdf global nodejs latest
            asdf global python system
        fi
    fi
}

function configure_fzf {
    if has_formulae fzf; then
        if should_configure fzf "grep '\.fzf\.zsh' ~/.zshrc"; then
            echo "\n# Install fzf fuzzy completion\n[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >>~/.zshrc
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
configure_fzf
# install_formulae gh
install_formulae asdf
configure_asdf
