#!/bin/bash

# font
# Ricty Diminished
if [ ! -d $HOME/.font/RictyDiminished ]; then
    git clone git@github.com:yascentur/RictyDiminished.git $HOME/.font/RictyDiminished
    cp -f $HOME/.font/RictyDiminished/*.ttf $HOME/Library/Fonts/.
fi

# homebrew
if [ ! -f /usr/local/bin/brew ]; then
    echo "Install Homebrew:"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    echo "Install Hombrew libraries:"
    bash `dirname $0`/brew-installer.sh
fi

# vim syntax folder
if [ ! -d $HOME/.vim/syntax ]; then
    echo "Create a vim syntax directory."
    mkdir -p $HOME/.vim/syntax
fi

# NeoBundle
if [ ! -d "$HOME/.vim/bundle" ]; then
    echo "Install NeoBundle:"
    mkdir -p $HOME/.vim/bundle
    git clone git://github.com/Shougo/neobundle.vim $HOME/.vim/bundle/neobundle.vim
fi

# bashmarks
if [ ! -f $HOME/.local/bin/bashmarks.sh ]; then
    echo "Install Bashmarks:"
    git clone https://github.com/huyng/bashmarks /tmp/bashmarks
    pushd /tmp/bashmarks
    make install
    popd
    rm -rf /tmp/bashmarks
fi

# GitHub Flavored Markdown Syntax
if [ ! -f $HOME/.vim/syntax/ghmarkdown.vim ]; then
    echo "Install ghmarkdown.vim:"
    cd ~/.vim/syntax/
    curl -LO https://raw.github.com/jtratner/vim-flavored-markdown/master/syntax/ghmarkdown.vim
fi

# Tmux Plugin Manager
if [[ -d $HOME/.tmux/plugins/tpm ]]; then
    echo "Install Tmux Plugin Manager:"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# rbenv-default-gems
if [ ! -d ~/.rbenv/plugins/rbenv-default-gems ]; then
    echo "Install rbenv-default-gems:"
    git clone https://github.com/sstephenson/rbenv-default-gems.git ~/.rbenv/plugins/rbenv-default-gems
fi

# dotfiles
DOT_FILES=(.bash_profile .bashrc .zprofile .zshrc .vimrc .tmux.conf .pryrc .rbenv/default-gems)

echo "Create symbolic link:"
for file in ${DOT_FILES[@]}
do
    if [ ! -f $HOME/$file ]; then
        echo $HOME/$file
        ln -s $HOME/.dotfiles/$file $HOME/$file
    fi
done

# .env
if [ ! -f $HOME/.env ]; then
    touch $HOME/.env
fi

# bin
mkdir -p $HOME/bin

