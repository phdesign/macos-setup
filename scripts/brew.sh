#!/bin/bash

set -eu

if should_install "brew"; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Install GNU core utilities (those that come with OS X are outdated).
brew install coreutils

# Install Python
brew install python3

# Custom tools
brew install jq
brew install the_silver_searcher
brew install tree

# iTerm2
if should_install iterm2 'test -e "/Applications/iTerm.app"'; then
  brew cask install iterm2
  echo "📝  TODO: Manually configure iTerm2"
  echo "    - iTerm2 > Preferences > Profiles > Other Actions > Import JSON Profiles > 'config/Tomorrow-Night-Eighties.json'"
  echo "    - iTerm2 > Preferences > Appearance > General > Theme: Minimal"
  echo "    - iTerm2 > Preferences > Appearance > Panes > Uncheck 'Show per-pane title bar with split panes'"
fi

# Java
if should_install java 'command -v "java" > /dev/null'; then
  brew cask install java
fi

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
# - Typora
# - Fork
# - Beyond Compare
# - VS Code
# - Insomnia
# - Dropbox

