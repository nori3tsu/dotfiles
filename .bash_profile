#!/bin/bash

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -f ~/.env ]; then
    source ~/.env
fi

export PATH=$PATH:$HOME/bin
