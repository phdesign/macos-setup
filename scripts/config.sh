#!/bin/bash

set -eu

# Vim
if should_configure vim 'test -d "$HOME/.vim"'; then
  git clone git@github.com:phdesign/vim.git ~/.vim
  echo "runtime vimrc" > ~/.vimrc
  local olddir=$(pwd)
  cd ~/.vim
  git submodule update --init
  cd "$olddir"
fi

# Git
if should_configure git 'test -f "$HOME/.gitconfig"'; then
  git config --global user.name "Paul Heasley"
  git config --global user.email "paul@phdesign.com.au"
  git config --global diff.tool bc3
  git config --global difftool.bc3.trustExitCode true
  git config --global merge.tool bc3
  git config --global mergetool.bc3.trustExitCode true
fi
