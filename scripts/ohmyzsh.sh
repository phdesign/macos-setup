#!/bin/bash

set -eu

if should_install oh-my-zsh 'test -d "$HOME/.oh-my-zsh"'; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  sed -i '' 's/^ZSH_THEME=.*$/ZSH_THEME="agnoster"/g' ~/.zshrc

  echo "\n# Set default user to hide it in the prompt" >> ~/.zshrc
  echo "DEFAULT_USER=\"paul.heasley\"" >> ~/.zshrc

  # Set zsh as default shell
  # chsh -s $(which zsh)
fi

