#!/bin/bash

set -eu

function should_install() {
    local dependency="$1"
    local test="$2"

    if [ "$(eval "$test"; echo $?)" ]; then
        echo "⏩  $dependency is already installed"
        return 1
    else
        echo "✅  Installing $dependency..."
        return $DRYRUN
    fi
}

function should_configure() {
    local dependency="$1"
    local test="$2"

    if [ "$(eval "$test"; echo $?)" ]; then
        echo "⏩  $dependency is already configured"
        return 1
    else
        echo "✅  Configuring $dependency..."
        return $DRYRUN
    fi
}

function has_command {
    return $(command -v "$1" > /dev/null)
}

function has_formulae {
    return $(brew ls --versions "$1" > /dev/null)
}

function has_cask {
    return $(brew cask ls --version "$1" > /dev/null)
}

function has_application {
    return $(test -e "/Applications/$1.app")
}

function has_folder {
    return $(test -d "$1")
}

function has_file {
    return $(test -f "$1")
}

function install_formulae {
    local dependency="$1"
    if should_install $dependency "has_formulae $dependency"; then
        brew install "$dependency"
    fi
}

function install_cask {
    local dependency="$1"
    if should_install $dependency "has_command $dependency"; then
        brew install --cask $dependency
    fi
}

