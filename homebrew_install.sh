#!/bin/bash

echo "installing homrebrew..."
which brew >/dev/null 2>&1 || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "run brew doctor..."
which brew >/dev/null 2>&1 && brew doctor

echo "run brew update..."
which brew >/dev/null 2>&1 && brew update

echo "ok. run brew upgrade..."

brew upgrade

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
    anyenv
    hub
    python3
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
    nativefier
    mkcert
)

echo "brew tap..."
brew tap homebrew/bundle
brew tap homebrew/cask
brew tap homebrew/services
brew tap sanemat/font

echo "start brew install apps..."
for formula in "${formulas[@]}"; do
    brew install $formula || brew upgrade $formula
done

casks=(
    1password
    alfred
    chromedriver
    cyberduck
    datagrip
    deepl
    discord
    docker
    firefox
    google-chrome
    google-drive-file-stream
    google-japanese-ime
    iterm2
    kindle
    krisp
    postman
    rubymine
    slack
    spotify
    visual-studio-code
    webstorm
    zoomus
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
