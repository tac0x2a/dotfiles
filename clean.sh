#!/bin/bash

cd $HOME
rm -rf .zshrc .zcompdump .zcompdump.zwc\
       .gitconfig .tmux.conf \
       .pyenv .rbenv .sdkman .nvm \
       .config/starship.toml \
       ~/.config/sheldon ~/.local/share/sheldon
# rm -rf .dotfiles