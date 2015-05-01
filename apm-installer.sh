#!/bin/bash -e

install() {
  local pkg=$1
  if [[ ! -d $HOME/.atom/packages/$pkg ]]; then
    apm install $pkg
  fi
}

install atom-beautify
install autocomplete-plus
install autocomplete-snippets
install editorconfig
install file-icons
install jumpy
install preview
install project-manager
install recent-files
install regex-railroad-diagram
install script
