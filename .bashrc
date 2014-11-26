#!/bin/bash

# alias
alias ll='ls -laG'
alias diff='colordiff'
alias less='less -R'

if [ `uname` = "Darwin" ];then
    alias updatedb='sudo /usr/libexec/locate.updatedb'
fi
