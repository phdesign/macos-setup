#!/bin/bash

set -eu

DRYRUN=0
PARAMS=""
while (( "$#" )); do
    case "$1" in
        -n)
            DRYRUN=1
            echo "Dry run is on, I won't actually install anything"
            shift
            ;;
        *) # preserve remaining arguments
            PARAMS="$PARAMS $1"
            shift
            ;;
    esac
done
eval set -- "$PARAMS"

olddir=$(pwd)
basedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$basedir"

source ./lib/shared.sh

source ./scripts/brew.sh

source ./scripts/ohmyzsh.sh

source ./scripts/fonts.sh

source ./scripts/config.sh

cd "$olddir"

