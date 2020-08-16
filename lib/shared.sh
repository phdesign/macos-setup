#!/bin/bash

set -eu

compose() {
  result_fun=$1; shift
  f1=$1; shift
  f2=$1; shift
  eval "$result_fun() {
    $f1 \$($f2 \$*);
  }"
}

function partial() {
  result_fun=$1; shift
  fun=$1; shift
  params=$*
  eval "$result_fun() {
    more_params=\$*;
    $fun $params \$more_params;
  }"
}

function install() {
  local dependency="$1"
  local test_func="$2"
  local install_func="$3"

  if $test_func $dependency; then
    echo "⏩  $dependency is already installed"
  else
    echo "✅  Installing $dependency..."
    $install_func $dependency
  fi
}

function should_install() {
  local dependency="$1"
  local test="$2"

  if [ "$(eval "$test"; echo $?)" ]; then
    echo "⏩  $dependency is already installed"
    return 1
  else
    echo "✅  Installing $dependency..."
    return 0
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
    return 0
  fi
}

