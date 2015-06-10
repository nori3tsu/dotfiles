#!/bin/bash

# alias
alias vi='vim'
alias ll='ls -laG --color=auto'
alias diff='colordiff'
alias less='less -R'
alias tar='gtar'
alias git_soft_rest='git reset --soft HEAD^'
alias jf='pbpaste | jq . | pbcopy'
alias fin='terminal-notifier -message "Fin"'

if [ `uname` = "Darwin" ];then
    alias updatedb='sudo /usr/libexec/locate.updatedb'
fi
