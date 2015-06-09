#!/bin/bash

# alias
alias vi='vim'
alias ll='ls -laG --color=auto'
alias diff='colordiff'
alias less='less -R'
alias tar='gtar'
alias git_soft_rest='git reset --soft HEAD^'

if [ `uname` = "Darwin" ];then
    alias updatedb='sudo /usr/libexec/locate.updatedb'
fi
