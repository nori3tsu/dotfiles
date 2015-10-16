#!/bin/bash

# alias
alias vi='vim'
alias ll='ls -laG --color=auto'
alias diff='colordiff'
alias less='less -R'
alias tar='gtar'
alias popup='terminal-notifier -message'
alias be='bundle exec'
alias grep='ggrep'

# JSON Format
alias jf='pbpaste | jq . | pbcopy'
# SQL Format
alias sf="pbpaste | python -c \"import sys;import sqlparse;print sqlparse.format(sys.stdin.read(), reindent=True, keyword_case='upper')\" | pbcopy"

if [ `uname` = "Darwin" ];then
    alias updatedb='sudo /usr/libexec/locate.updatedb'
fi
