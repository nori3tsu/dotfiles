#!/bin/bash

if [ -f ~/.env ]; then
  source ~/.env
fi

# coreutils
if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# rbenv
if [ -f /usr/local/bin/rbenv ]; then
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/shims:$PATH"
fi

# node.js
export NVM_DIR=~/.nvm
source /usr/local/opt/nvm/nvm.sh

# git
git config --global color.ui auto
git config --global http.sslVerify false

# bashmarks
if [ -f $HOME/.local/bin/bashmarks.sh ]; then
  source $HOME/.local/bin/bashmarks.sh
fi

export LANG=en_US.UTF-8
export PATH=$PATH:$HOME/bin:/usr/local/bin:/usr/local/sbin

# prompt
export PS1="[\D{%d %H:%M} \u\[\e[${PS_COLOR-1;34}m\]@\[\e[00m\]\h \w]\$ "

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

