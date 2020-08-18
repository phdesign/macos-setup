#!/bin/bash

set -eu

function has_command {
  return $(command -v "$1" > /dev/null)
}

function has_formulae {
  return $(brew ls --versions "$1" > /dev/null)
}

function has_application {
  return $(test -e "/Applications/$1.app")
}

function install_brew {
  if should_install brew "has_command brew"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi
}

function install_formulae {
  local dependency="$1"
  if should_install $dependency "has_formulae $dependency"; then
    brew install "$dependency"
  fi
}

function install_iterm {
  if should_install iterm "has_application 'iTerm'"; then
    brew cask install iterm
    echo "📝  TODO: Manually configure iTerm2"
    echo "    - iTerm2 > Preferences > Profiles > Other Actions > Import JSON Profiles > 'config/Tomorrow-Night-Eighties.json'"
    echo "    - iTerm2 > Preferences > Appearance > General > Theme: Minimal"
    echo "    - iTerm2 > Preferences > Appearance > Panes > Uncheck 'Show per-pane title bar with split panes'"
    echo "    - iTerm2 > Preferences > Appearance > Dimmin > Uncheck 'Dim inactive split panes'"
  fi
}

function install_beyond_compare {
  if should_install beyond-compare "has_application 'Beyond Compare'"; then
    brew cask install beyond-compare
    echo "📝  TODO: Enter Beyond Compare license"
    if [ ! has_command bcompare ]; then
      ln -s /Applications/Beyond\ Compare.app/Contents/MacOS/bcomp /usr/local/bin/bcompare
      ln -s /Applications/Beyond\ Compare.app/Contents/MacOS/bcomp /usr/local/bin/bcomp
    fi
  fi
}

function install_node {
  if should_install nvm "has_command nvm"; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
    # Start nvm in current shell
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    nvm install node
  fi
}

function install_java {
  if should_install java "has_command java"; then
    brew cask install java
  fi
}

function install_ctags {
  if should_install universal-ctags "has_formulae universal-ctags"; then
    brew install --HEAD universal-ctags/universal-ctags/universal-ctags
  fi
}

function install_typora {
  if should_install typora "has_application 'Typora'"; then
    brew cask install typora
    curl -b cookies.txt -L \
      "https://github.com/elitistsnob/typora-gitlab-theme/releases/download/v1.1/typora-gitlab-theme-master-updated.zip" \
      -o typora-gitlab-theme-master-updated.zip
    unzip typora-gitlab-theme-master-updated -d typora-gitlab-theme-master-updated
    mv typora-gitlab-theme-master-updated/gitlab* "/Users/paul.heasley/Library/Application Support/abnerworks.Typora/themes"
    echo "📝  TODO: Manually configure Typora"
    echo "    - Typora > Preferences > General > On launch: Open custom folder"
    echo "    - Typora > Preferences > Image > When insert...: Copy image to ./\${filename}.assets"
  fi
}

install_brew

# Install GNU core utilities (those that come with OS X are outdated).
install_formulae coreutils

# Install Python
install_formulae python

# Command line tools
install_formulae jq
install_formulae the_silver_searcher
install_formulae tree
install_formulae z

# iTerm2
install_iterm

# Java
install_java

# Beyond Compare 4
install_beyond_compare

# Typora
install_typora

# Node
#install_node

# Vim
install_formulae neovim
install_ctags
#install_esctags

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

