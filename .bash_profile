#!/bin/bash

# pythonz
if [ -d $HOME/.pythonz ]; then
    source $HOME/.pythonz/etc/bashrc
fi

# virtualenv
if [ -d $HOME/.virtualenvs ]; then
    # virtualenv
    source `which virtualenvwrapper.sh`
    export WORKON_HOME=$HOME/.virtualenvs
    export PIP_RESPECT_VIRTUALENV=true
fi

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

export PATH=$PATH:$HOME/bin
