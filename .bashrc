#!/bin/bash

# alias
alias ll='ls -laG --color=auto'
alias diff='colordiff'
alias less='less -R'
alias tar='gtar'

if [ `uname` = "Darwin" ];then
    alias updatedb='sudo /usr/libexec/locate.updatedb'
fi
