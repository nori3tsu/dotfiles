#!/bin/bash

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

# dotfiles
DOT_FILES=(.bash_profile .bashrc .vimrc .tmux.conf)

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

