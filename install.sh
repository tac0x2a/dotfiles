#!/bin/bash

if [ "$(uname)" == 'Darwin' ]; then OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then OS='Linux'
else
  echo "Unknown uname '$(uname)'. Exit."
  exit -1
fi;

echo "### Setup for ${OS} ###"

# Setup
[[ $OS == "Linux" ]] && {
  sudo apt update
  sudo apt install -y wget curl git tmux zsh stow
}

# Homebrew -----------------------------------------------------------------------------------
[[ -d $HOMEBREW_PREFIX ]] || {
  [[ $OS == "Linux" ]] && sudo apt install -y build-essential file
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# brew basic packages
[[ -d $HOMEBREW_PREFIX ]] && {
  brew bundle install

  # for Mac Environment
  [[ $OS == "Mac" ]] && {
    brew bundle install --file Brewfile.mac
  }
}

# dotfiles -----------------------------------------------------------------------------------
[[ -d ~/.dotfiles ]] || git clone https://github.com/tac0x2a/dotfiles.git ~/.dotfiles

stow -v -d "$HOME/.dotfiles" -t "$HOME" .home_base
[[ $OS == "Mac" ]] && stow -v -d "$HOME/.dotfiles" -t "$HOME" .home_mac

[[ -e ~/.zshrc.mine ]] || touch ~/.zshrc.mine

# symlinks -----------------------------------------------------------------------------------
echo "--------------------------------------------------------------------------"
echo "Setup is finished. Please run manually if it's necessary."
echo ""
[[ $OS == "Linux" ]] && {
  echo "chsh -s $(which zsh)"
  echo "ln -s /mnt/c/Users/$(whoami)/Desktop ~/Desktop"
  echo "ln -s /mnt/c/Usersj/$(whoami)/GoogleDrive ~/GoogleDrive"
}
[[ $OS == "Mac" ]] && {
  [[ -d ~/Google\ Drive ]] && {
    GDRIVE_PATH_TMP=$(ls -l ~/Google\ Drive | awk '{ print $12 }')
    echo "ln -s ${GDRIVE_PATH_TMP}/マイドライブ ~/GoogleDrive"
    echo "rm ~/Google\ Drive"
  }
}
echo "ssh-keygen -t rsa"
echo 'ssh-copy-id ${user}@${remote_host}'
