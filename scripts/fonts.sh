#!/bin/bash

set -eu

# Available fonts: https://github.com/Homebrew/homebrew-cask-fonts/tree/master/Casks
brew tap homebrew/cask-fonts
brew cask install font-fira-code
brew cask install font-fira-mono
brew cask install font-fira-sans-condensed
brew cask install font-fira-sans-extra-condensed
brew cask install font-fira-sans
brew cask install font-dejavu-sans-mono-for-powerline

