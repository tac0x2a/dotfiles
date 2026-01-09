#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then OS='Linux'
else
  echo "Unknown uname '$(uname)'. Exit."
  exit -1
fi;

echo "### Cleanup for ${OS} ###"

stow -v -d "$HOME/.dotfiles" -t "$HOME" -D .home_base
[[ $OS == "Mac" ]] && {
  stow -v -d "$HOME/.dotfiles" -t "$HOME" -D .home_mac
}

rm -rf "$HOME/.zcompdump" "$HOME/.zcompdump.zwc" "$HOME/.local/share/sheldon"
# rm -rf .dotfiles
