#!/bin/bash

sudo apt update
sudo apt install -y \
  wget curl git \
  tmux zsh


[[ -d ~/.dotfiles ]] || git clone https://github.com/tac0x2a/dotfiles.git ~/.dotfiles

# Homebrew -----------------------------------------------------------------------------------
[[ -d /home/linuxbrew/ ]] || {
  sudo apt install -y build-essential curl file
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# brew packages
[[ -d /home/linuxbrew/ ]] && brew install bat jq gh moreutils gh starship fzf sheldon

# rbenv -----------------------------------------------------------------------------------
[[ -d ~/.rbenv ]] || {
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  ~/.rbenv/bin/rbenv init
}

[[ -d ~/.rbenv/plugins/ruby-build ]] || {
  sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev
  mkdir -p ~/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
}
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-doctor | bash


# Python
# pyenv -----------------------------------------------------------------------------------
[[ -d ~/.pyenv ]] || {
  sudo apt install -y zlib1g-dev build-essential libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev liblzma-dev tk-dev
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
}

# uv -----------------------------------------------------------------------------------
[[ -d /home/linuxbrew/ ]] || {
  brew install uv
}

# SDKMAN! -----------------------------------------------------------------------------------
[[ -d ~/.sdkman ]] || {
  sudo apt install -y zip
  curl -s "https://get.sdkman.io" | bash
  rm ~/.zshrc
}

# nvm --------------------------------------------------------------------------------------
[[ -d ~/.nvm ]] || {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
}

# dotfiles -----------------------------------------------------------------------------------
[[ -e ~/.gitconfig ]] || ln -s ~/.dotfiles/.gitconfig  ~/.gitconfig
[[ -e ~/.tmux.conf ]] || ln -s ~/.dotfiles/.tmux.conf  ~/.tmux.conf
[[ -e ~/.zshrc     ]] || ln -s ~/.dotfiles/.zshrc      ~/.zshrc

mkdir -p ~/.config
[[ -e ~/.config/starship.toml ]] || ln -s ~/.dotfiles/.config/starship.toml ~/.config/starship.toml
[[ -e ~/.config/sheldon/plugins.toml ]] || {
  mkdir -p ~/.config/sheldon && ln -s ~/.dotfiles/.config/sheldon/plugins.toml ~/.config/sheldon/plugins.toml
}

[[ -e ~/.zshrc.mine ]] || touch ~/.zshrc.mine

# symlinks -----------------------------------------------------------------------------------
echo "--------------------------------------------------------------------------"
echo "Setup is finished. Please run manually if it's necessary."
echo ""
echo "chsh -s $(which zsh)"
echo "ln -s /mnt/c/Users/$(whoami)/Desktop ~/Desktop"
echo "ln -s /mnt/c/Usersj/$(whoami)/GoogleDrive ~/GoogleDrive"
echo "ssh-keygen -t rsa"
echo 'ssh-copy-id ${user}@${remote_host}'
