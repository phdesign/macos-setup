#!/bin/bash

set -eu

function configure_git {
    if should_configure git 'test -f "$HOME/.gitconfig"'; then
        git config --global user.name "Paul Heasley"
        git config --global user.email "paul@phdesign.com.au"
        git config --global diff.tool bc3
        git config --global difftool.bc3.trustExitCode true
        git config --global merge.tool bc3
        git config --global mergetool.bc3.trustExitCode true
        git config --global mergetool.keepBackup false
    fi
}

configure_git
