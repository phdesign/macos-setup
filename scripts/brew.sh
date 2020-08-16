#!/bin/bash

set -eu

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
  return $(test -e "/Applications/$dependency.app")
}

function install_brew {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

function install_formulae {
  local dependency="$1"
  brew install "$dependency"
}

function install_cask {
  local dependency="$1"
  brew cask install "$dependency"
}

install brew needs_command install_brew

# Install GNU core utilities (those that come with OS X are outdated).
install coreutils needs_formulae install_formulae

# Install Python
install python needs_formulae install_formulae

# Custom tools
install jq needs_formulae install_formulae
install the_silver_searcher needs_formulae install_formulae
install tree needs_formulae install_formulae
install z needs_formulae install_formulae

# iTerm2
function install_iterm {
  install_cask iterm2
  echo "📝  TODO: Manually configure iTerm2"
  echo "    - iTerm2 > Preferences > Profiles > Other Actions > Import JSON Profiles > 'config/Tomorrow-Night-Eighties.json'"
  echo "    - iTerm2 > Preferences > Appearance > General > Theme: Minimal"
  echo "    - iTerm2 > Preferences > Appearance > Panes > Uncheck 'Show per-pane title bar with split panes'"
  echo "    - iTerm2 > Preferences > Appearance > Dimmin > Uncheck 'Dim inactive split panes'"
}
partial needs_iterm needs_application "iTerm"
install iterm2 needs_iterm install_iterm

# Java
install java needs_command install_formulae

# Beyond Compare 4
function install_beyond_compare {
  install_cask beyond-compare
  echo "📝  TODO: Enter Beyond Compare license"
  if needs_command bcompare; then
    ln -s /Applications/Beyond\ Compare.app/Contents/MacOS/bcomp /usr/local/bin/bcompare
    ln -s /Applications/Beyond\ Compare.app/Contents/MacOS/bcomp /usr/local/bin/bcomp
  fi
}
partial needs_beyond_compare needs_application "Beyond Compare"
install beyond-compare needs_beyond_compare install_beyond_compare

# Typora
function install_typora {
  install_cask typora
  curl -b cookies.txt -L \
    "https://github.com/elitistsnob/typora-gitlab-theme/releases/download/v1.1/typora-gitlab-theme-master-updated.zip" \
    -o typora-gitlab-theme-master-updated.zip
  unzip typora-gitlab-theme-master-updated -d typora-gitlab-theme-master-updated
  mv typora-gitlab-theme-master-updated/gitlab* "/Users/paul.heasley/Library/Application Support/abnerworks.Typora/themes"
  echo "📝  TODO: Manually configure Typora"
  echo "    - Typora > Preferences > General > On launch: Open custom folder"
  echo "    - Typora > Preferences > Image > When insert...: Copy image to ./\${filename}.assets"
}
partial needs_typora needs_application "Typora"
install typora needs_typora install_typora

# Todo
# ----
# - Chrome
# - Zap Proxy
#   - Export certificate
# - Firefox
#   - FoxyProxy http://localhost:8080
#   - Import Zap cert
# - Spark
# - Spotify
# - Fork
# - VS Code
# - Insomnia
# - Dropbox

