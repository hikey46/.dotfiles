#!/bin/bash

echo "installing homrebrew..."
which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "run brew doctor..."
which brew >/dev/null 2>&1 && brew doctor

echo "run brew update..."
which brew >/dev/null 2>&1 && brew update

echo "ok. run brew upgrade..."

brew upgrade --all

formulas=(
    git
    wget
    curl
    tree
    openssl
    telnet
    cmake
    gmp
    z
    colordiff
    zsh
    zplug
    tmux
    peco
    ansible
    hub
    ndenv
    yarn
    python3
    rbenv
    ruby-build
    lua
    redis
    mysql@5.7
    postgresql
    sqlite
    ricty
    ssh-copy-id
    diff-so-fancy
    ImageMagick
    ffmpeg
)

"brew tap..."
brew tap homebrew/bundle
brew tap homebrew/cask
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/services
brew tap sanemat/font

echo "start brew install apps..."
for formula in "${formulas[@]}"; do
    brew install $formula || brew upgrade $formula
done

casks=(
    google-chrome
    chromedriver
    firefox
    google-drive-file-stream
    visual-studio-code
    rubymine
    boostnote
    slack
    iterm2
    kindle
    cyberduck
    zoomus
    scroll-reverser
    virtualbox
    vagrant
    vagrant-manager
    google-japanese-ime
)

echo "start brew cask install apps..."
for cask in "${casks[@]}"; do
    brew cask install $cask
done

brew cleanup
brew cask cleanup

cat << END

**************************************************
HOMEBREW INSTALLED! bye.
**************************************************

END
