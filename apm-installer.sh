#!/bin/bash -e

install() {
  local pkg=$1
  if [[ ! -d $HOME/.atom/packages/$pkg ]]; then
    apm install $pkg
  fi
}

install Sublime-Style-Column-Selection
install atom-beautify
install atom-lint
install autocomplete-plus
install autocomplete-snippets
install editorconfig
install file-icons
install highlight-line
install jumpy
install linter-rubocop
install no-caffeine-syntax
install preview
install project-manager
install recent-files
install regex-railroad-diagram
install script
