#!/bin/bash

set -eu

function has_pip3_package {
    return $(pip3 show "$1" > /dev/null)
}

function install_pip3_package {
    local dependency="$1"
    if should_install $dependency "has_pip3_package $dependency"; then
        pip3 install $dependency
    fi
}

install_formulae python

install_pip3_package csvkit
