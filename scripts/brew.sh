#!/bin/bash

set -eu

function install_brew {
    if should_install brew "has_command brew"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
}

function install_iterm {
    if should_install iterm "has_application 'iTerm'"; then
        brew cask install iterm
        cat << EOM
📝  TODO: Manually configure iTerm2
    - iTerm2 > Preferences > Profiles > Other Actions > Import JSON Profiles > 'config/Tomorrow-Night-Eighties.json'
    - iTerm2 > Preferences > Appearance > General > Theme: Minimal
    - iTerm2 > Preferences > Appearance > Panes > Uncheck 'Show per-pane title bar with split panes'
    - iTerm2 > Preferences > Appearance > Dimmin > Uncheck 'Dim inactive split panes'
EOM
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

function install_typora {
    if should_install typora "has_application 'Typora'"; then
        brew cask install typora
        curl -b cookies.txt -L \
            "https://github.com/elitistsnob/typora-gitlab-theme/releases/download/v1.1/typora-gitlab-theme-master-updated.zip" \
            -o typora-gitlab-theme-master-updated.zip
        unzip typora-gitlab-theme-master-updated -d typora-gitlab-theme-master-updated
        mv typora-gitlab-theme-master-updated/gitlab* "/Users/paul.heasley/Library/Application Support/abnerworks.Typora/themes"
        cat << EOM
📝  TODO: Manually configure Typora
    - Typora > Preferences > General > On launch: Open custom folder
    - Typora > Preferences > Image > When insert...: Copy image to ./${filename}.assets
EOM
    fi
}

function install_vscode {
    if should_install vscode "has_application 'Visual Studio Code'"; then
        brew cask install visual-studio-code
    fi
}

function install_rectangle {
    if should_install rectangle "has_application 'Rectangle'"; then
        brew cask install rectangle
    fi
}

# Install homebrew first
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

# Install applications
# Rectangle is a window resizer app
install_rectangle
install_iterm
install_cask java
install_beyond_compare
install_typora
#install_node
install_vscode
# TODO: Configure VS Code

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
# - Insomnia
# - Dropbox

