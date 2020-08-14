#!/bin/bash

set -eu

function install_font() {
  local font="$1"
  local file="$2"

  if should_install $font "test -f $HOME/Library/Fonts/$file || test -f /System/Library/Fonts/$file"; then
    brew cask install $font
  fi
}

# Available fonts: https://github.com/Homebrew/homebrew-cask-fonts/tree/master/Casks
brew tap homebrew/cask-fonts
install_font font-fira-code FiraCode-Regular.ttf
install_font font-fira-mono FiraMono-Regular.ttf
install_font font-fira-sans FiraSans-Regular.ttf
install_font font-dejavu-sans-mono-for-powerline DejaVuSans.ttf

