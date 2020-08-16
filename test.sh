#!/bin/bash

lambda() {
    lam() {
        unset last
        unset ars
        for last; do
            shift
            if [[ $last = "." || $last = ":" || $last = "->" || $last = "→" ]]; then
                echo "$@"
                return
            else
                echo "read $last;"
            fi
        done
    }
    y="stdin"
    for i in "$@"; do
        if [[ $i = "." || $i = ":" || $i = "->" || $i = "→" ]]; then
            y="args"
        fi
    done
    if [[ "$y" = "stdin" ]]; then
        read fun
        eval $(lam "$@ : $fun")
    else
        eval $(lam "$@")
    fi
    unset y
    unset i
    unset fun
}

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
    $fun \"$params\" \"\$more_params\";
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

function needs_formulae {
    local dependency="$1"
    return $(brew ls --versions $dependency > /dev/null)
}

function needs_command {
  local dependency="$1"
  return $(command -v "$dependency" > /dev/null)
}

function needs_application {
  local dependency="$1"
  echo "/Applications/$dependency.app"
  return $(test -e "/Applications/$dependency.app")
}

function noop {
  local dependency="$1"
  echo "I'm in a funk with $dependency"
}

function writeline {
  echo $1
  echo $2
  echo $3
  echo $4
}

partial spaces writeline "Beyond Compare" next
spaces "last" "after last"

echo yo | lambda a : 'noop $a'

install jq needs_formulae noop
partial install_jq noop "test"
install jqa needs_formulae install_jq
install brew needs_command noop
partial has_iterm needs_application "iTerm"
install iterm2 has_iterm noop
partial needs_beyond_compare needs_application "Beyond Compare"
install beyond-compare needs_beyond_compare noop


if $(command -v bcompare > /dev/null); then
  echo "bcompare is installed"
else
  echo "Installing bcompare..."
fi

if needs_command bcompare2; then
  echo "bcompare is installed"
else
  echo "Installing bcompare..."
fi
