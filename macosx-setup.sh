#!/bin/bash

set -eu

olddir=$(pwd)
basedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$basedir"

source ./lib/shared.sh

source ./scripts/brew.sh

source ./scripts/ohmyzsh.sh

source ./scripts/fonts.sh

source ./scripts/config.sh

cd "$olddir"

