#!/bin/bash

# vim syntax folder
if [ ! -f $HOME/.vim/syntax ]; then
    mkdir -p $HOME/.vim/syntax
fi

# NeoBundle
if [ ! -d "$HOME/.vim/bundle" ]; then
    mkdir -p $HOME/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
else
    echo "NeoBundle is already installed"
fi

# bashmarks
if [ ! -f $HOME/.local/bin/bashmarks.sh ]; then
    git clone https://github.com/huyng/bashmarks /tmp/bashmarks
    cd /tmp/bashmarks
    make install
    cd
    rm -rf /tmp/bashmarks
fi

# GitHub Flavored Markdown Syntax
if [ ! -f $HOME/.vim/syntax/ghmarkdown.vim ]; then
    cd ~/.vim/syntax/
    curl -LO https://raw.github.com/jtratner/vim-flavored-markdown/master/syntax/ghmarkdown.vim
fi

# dotfiles
DOT_FILES=(.bash_profile .bashrc .zprofile .zshrc .vimrc .tmux.conf)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/.dotfiles/$file $HOME/$file
done

# .env
if [ ! -f $HOME/.env ]; then
    touch $HOME/.env
fi

# bin
mkdir -p $HOME/bin

