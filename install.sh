#!/bin/bash

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing dotfiles for the first time"
    git clone https://github.com/norilicht/dotfiles "$HOME/.dotfiles"
    cd "$HOME/.dotfiles"
    
    # NeoBundle
    mkdir -p $HOME/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
    
    # vimrc
    ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
else
    echo "dotfiles is already installed"
fi