#!/bin/bash

sudo apt update
sudo apt install -y \
  wget curl git  \
  tmux zsh zsh-syntax-highlighting peco \
  lv

[[ -d ~/.dotfiles ]] || git clone https://github.com/tac0x2a/dotfiles.git ~/.dotfiles

# Zi ---------------------------------------------------------------------------------------
[[ -e "${HOME}/.zi/bin/zi.zsh" ]] || {
  sh -c "$(curl -fsSL https://git.io/get-zi)" -- -i skip
}

# Homebrew -----------------------------------------------------------------------------------
[[ -d /home/linuxbrew/ ]] || {
  sudo apt install -y build-essential curl file
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# brew packages
[[ -d /home/linuxbrew/ ]] && brew install bat exa q moreutils

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


# pyenv -----------------------------------------------------------------------------------
[[ -d ~/.pyenv ]] || {
  sudo apt install -y zlib1g-dev build-essential libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev liblzma-dev
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
}

# SDKMAN! -----------------------------------------------------------------------------------
[[ -d ~/.sdkman ]] || {
  sudo apt install -y zip
  curl -s "https://get.sdkman.io" | bash
  rm ~/.zshrc
}

# nvm --------------------------------------------------------------------------------------
[[ -d ~/.nvm ]] || {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
}

# dotfiles -----------------------------------------------------------------------------------

[[ -e ~/.gitconfig ]] || ln -s ~/.dotfiles/.gitconfig  ~/.gitconfig
[[ -e ~/.tmux.conf ]] || ln -s ~/.dotfiles/.tmux.conf  ~/.tmux.conf
[[ -e ~/.zshrc     ]] || ln -s ~/.dotfiles/.zshrc      ~/.zshrc

[[ -e ~/.config/peco/config.json ]] || {
  mkdir -p ~/.config/peco
  ln -s ~/.dotfiles/.config/peco/config.json ~/.config/peco/config.json
}

[[ -e ~/.zshrc.mine ]] || touch ~/.zshrc.mine

# symlinks -----------------------------------------------------------------------------------
echo "--------------------------------------------------------------------------"
echo "Setup is finished. Please run manually if it's necessary."
echo ""
echo "chsh -s $(which zsh)"
echo "ln -s /paty/to/your/.pypirc ~/.pypirc"
echo "ln -s /mnt/c/Users/$(whoami)/Desktop ~/Desktop"
echo "ln -s /mnt/c/Users/$(whoami)/GoogleDrive ~/GoogleDrive"
echo "ssh-keygen -t rsa"
