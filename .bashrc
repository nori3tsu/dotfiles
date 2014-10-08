#!/bin/bash

# alias
alias ll='ls -laG'

if [ `uname` = "Darwin" ];then
    alias updatedb='sudo /usr/libexec/locate.updatedb'
fi
