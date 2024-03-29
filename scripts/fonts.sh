#!/bin/bash

set -eu

function install_font {
    local font="$1"
    local file="$2"

    if should_install $font "test -n \"\$(find $HOME/Library/Fonts -maxdepth 1 -name '$file*' -print -quit)\" \
        || test -n \"\$(find /System/Library/Fonts -maxdepth 1 -name '$file*' -print -quit)\""; then
        brew install $font --cask
    fi
}

function install_cask_fonts {
    if should_install cask-fonts "brew tap-info homebrew/cask-fonts | grep -q -v 'Not installed'"; then
        brew tap homebrew/cask-fonts
    fi
}

# Available fonts: https://github.com/Homebrew/homebrew-cask-fonts/tree/master/Casks
install_cask_fonts
install_font font-fira-code FiraCode
install_font font-fira-mono FiraMono
install_font font-fira-sans FiraSans
#install_font font-dejavu-sans-mono-for-powerline "DejaVu Sans Mono for Powerline"

