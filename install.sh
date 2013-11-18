#!/bin/bash

# NeoBundle
if [ ! -d "$HOME/.vim/bundle" ]; then
    mkdir -p $HOME/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
else
    echo "NeoBundle is already installed"
fi

# dotfiles
DOT_FILES=(.bash_profile .bashrc .vimrc .tmux.conf)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/.dotfiles/$file $HOME/$file
done

# bin
mkdir -p $HOME/bin
