#!/bin/bash

# coreutils
if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

# pythonz
if [ -d $HOME/.pythonz ]; then
    source $HOME/.pythonz/etc/bashrc
fi

# rbenv
if [ -f /usr/local/bin/rbenv ]; then
    eval "$(rbenv init -)"
    export PATH="$HOME/.rbenv/shims:$PATH"
fi

# virtualenv
if [ -d $HOME/.virtualenvs ]; then
    # virtualenv
    source `which virtualenvwrapper.sh`
    export WORKON_HOME=$HOME/.virtualenvs
    export PIP_RESPECT_VIRTUALENV=true
fi

# git
git config --global color.ui auto
git config --global http.sslVerify false

# bashmarks
if [ -f $HOME/.local/bin/bashmarks.sh ]; then
    source $HOME/.local/bin/bashmarks.sh
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f ~/.env ]; then
    source ~/.env
fi

export PATH=$PATH:$HOME/bin:/usr/local/bin

# prompt
export PS1="[\D{%d %H:%M} \u\[\e[${PS_COLOR-1;34}m\]@\[\e[00m\]\h \w]\$ "

