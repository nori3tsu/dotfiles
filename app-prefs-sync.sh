#!/bin/bash

ln -sf ~/Dropbox/Library/Preferences/com.googlecode.iterm2.plist ~/Library/Preferences/.
# dotfiles
PREFS=(
  com.googlecode.iterm2.plist
)

echo "Create symbolic link:"
for pref in ${PREFS[@]}
do
    if [ ! -L $HOME/Library/Preferences/$pref ]; then
        echo $HOME/Library/Preferences/$pref
        ln -sf $HOME/Dropbox/Library/Preferences/$pref $HOME/Library/Preferences/.
    fi
done
