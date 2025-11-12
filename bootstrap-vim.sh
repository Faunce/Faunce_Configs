#!/usr/bin/env bash
# bootstrap-vim.sh

echo "Setting up Vim..."

# Link your vimrc
ln -sf "$(pwd)/.vimrc" ~/.vimrc

# Ensure curl and git exist
if ! command -v curl >/dev/null; then
  echo "Please install curl first."
  exit 1
fi
if ! command -v git >/dev/null; then
  echo "Please install git first."
  exit 1
fi

# Launch Vim to trigger vim-plug bootstrap + install
vim +PlugInstall +qall
