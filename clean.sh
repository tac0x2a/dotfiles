#!/bin/bash

stow -v -d "$HOME/.dotfiles" -t "$HOME" -D .home_base
if [ "$(uname)" == 'Darwin' ]; then
  stow -v -d "$HOME/.dotfiles" -t "$HOME" -D .home_mac
fi

rm -rf "$HOME/.zcompdump" "$HOME/.zcompdump.zwc" "$HOME/.local/share/sheldon"
# rm -rf .dotfiles
