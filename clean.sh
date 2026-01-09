#!/bin/bash

cd ~/.dotfiles
stow -D home
if [ "$(uname)" == 'Darwin' ]; then
  stow -D macos
fi

cd $HOME
rm -rf .zcompdump .zcompdump.zwc ~/.local/share/sheldon
# rm -rf .dotfiles
