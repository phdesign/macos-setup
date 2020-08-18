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

