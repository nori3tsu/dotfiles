#!/bin/bash -e

install() {
  local pkg=$1
  if [[ ! -d $HOME/.atom/packages/$pkg ]]; then
    apm install "$pkg"
  fi
}


install atom-alignment
install atom-beautify
install atom-html-preview
install autocomplete-paths
install docblockr
install editorconfig
install file-icons
install file-types
install japanese-wrap
install jumpy
install last-cursor-position
install linter
install linter-csslint
install linter-erb
install linter-jsonlint
install linter-rubocop
install linter-ruby
install linter-shellcheck
install live-archive
install markdown-pdf
install multi-cursor
install no-caffeine-syntax
install open-recent
install preview
install rails-transporter
install recent-files-fuzzy-finder
install rspec
install rspec-snippets
install script
install show-ideographic-space
install sort-lines
install tabs-to-spaces
install toggle-quotes
install vim-mode
