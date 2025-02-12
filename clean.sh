#!/bin/bash

cd $HOME
rm -rf .zshrc .zcompdump .zcompdump.zwc\
       .gitconfig .tmux.conf \
       .config/starship.toml \
       .config/mise/config.toml \
       ~/.config/sheldon ~/.local/share/sheldon
# rm -rf .dotfiles