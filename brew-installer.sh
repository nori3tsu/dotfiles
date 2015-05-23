#!/bin/bash -e

brew tap homebrew/binary
brew tap caskroom/versions
brew install Caskroom/cask/tuntap
brew install caskroom/cask/brew-cask

install() {
  local pkg=$1
  if [[ ! -d /usr/local/Cellar/$pkg ]]; then
    brew install "$pkg"
  else
    echo "$pkg is already installed."
  fi
}

install awscli
install colordiff
install coreutils
install ctags
install erlang
install git
install gnu-tar
install go
install gnupg
install gradle
install heroku-toolbelt
install imagemagick
install jq
install ngrep
install node
install openssl
install peco
install rbenv
install reattach-to-user-namespace
install ruby-build
install shellcheck
install siege
install terminal-notifier
install tmux
install tsung
install vim
install zsh
install zsh-completions

cask_install() {
  local pkg=$1
  if [[ ! -d /opt/homebrew-cask/Caskroom/$pkg ]]; then
    brew cask install "$pkg"
  else
    echo "$pkg is already installed."
  fi
}

#cask_install electrum
cask_install alfred
cask_install appcleaner
cask_install asteroid
cask_install bartender
cask_install bettertouchtool
cask_install betterzipql
cask_install caffeine
cask_install cornerstone
cask_install cyberduck
cask_install dash
cask_install dropbox
cask_install easysimbl
cask_install evernote
cask_install filezilla
cask_install firefox
cask_install gimp
cask_install github
cask_install goofy
cask_install google-chrome
cask_install google-drive
cask_install google-japanese-ime
cask_install gyazo
cask_install handbrake
cask_install hyperswitch
cask_install ifunbox
cask_install insomniax
cask_install iterm2
cask_install karabiner
cask_install kindle
cask_install libreoffice
cask_install macvim
cask_install pandoc
cask_install qlcolorcode
cask_install qlmarkdown
cask_install qlstephen
cask_install quicklook-csv
cask_install quicklook-json
cask_install seil
cask_install shiftit
cask_install skitch
cask_install skype
cask_install slack
cask_install sourcetree
cask_install thunderbird
cask_install vagrant
cask_install virtualbox
cask_install xquartz
