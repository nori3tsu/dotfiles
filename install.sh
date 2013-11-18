#!/bin/bash

# .dotfiles
if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing dotfiles for the first time"
    git clone https://github.com/norilicht/dotfiles "$HOME/.dotfiles"

else
    echo "dotfiles is already installed"
fi

# NeoBundle
if [ ! -d "$HOME/.vim/bundle" ]; then
    mkdir -p $HOME/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
else
    echo "NeoBundle is already installed"
fi

# vimrc
if [ ! -f "$HOME/.vimrc" ]; then
    ln -s $HOME/.dotfiles/.vimrc $HOME/.vimrc
else
    echo ".vimrc is already installed"
fi

# tmux
if [ ! -f "$HOME/.tmux.conf" ]; then
    ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
else
    echo ".tmux.conf is already installed"
fi
