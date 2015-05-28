#!/bin/bash -e

install() {
  local pkg=$1
  if [[ ! -d $HOME/.atom/packages/$pkg ]]; then
    apm install "$pkg"
  fi
}

install Sublime-Style-Column-Selection
install atom-alignment
install atom-beautify
install atom-lint
install autocomplete-paths
install autocomplete-plus
install autocomplete-snippets
install docblockr
install editorconfig
install fancy-new-file
install file-icons
install jumpy
install markdown-pdf
install no-caffeine-syntax
install preview
install project-manager
install rails-transporter
install recent-files
install rspec
install rspec-snippets
install script
install show-ideographic-space
install sort-lines
install tabs-to-spaces
install vim-mode
