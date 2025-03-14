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
  sudo apt install -y wget curl git tmux zsh
}

# Homebrew -----------------------------------------------------------------------------------
[[ -d $HOMEBREW_PREFIX ]] || {
  [[ $OS == "Linux" ]] && sudo apt install -y build-essential file
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# brew basic packages
[[ -d $HOMEBREW_PREFIX ]] && {
  brew update
  brew install bat eza jq gh mise moreutils starship fzf sheldon uv

  # Docker Environments
  [[ $OS == "Mac" ]] && {
    # https://github.com/abiosoft/colima
    brew install colima docker docker-compose
    # brew services start colima
  }

  # GNU commands for Mac
  [[ $OS == "Mac" ]] && {
    brew install wget curl git tmux zsh zsh-completions htop emacs
    brew install grep gawk gzip gnu-tar gnu-sed gnu-time gnu-getopt binutils findutils diffutils coreutils bash
  }
}

# dotfiles -----------------------------------------------------------------------------------
[[ -d ~/.dotfiles ]] || git clone https://github.com/tac0x2a/dotfiles.git ~/.dotfiles

[[ -e ~/.gitconfig ]] || ln -s ~/.dotfiles/.gitconfig  ~/.gitconfig
[[ -e ~/.tmux.conf ]] || ln -s ~/.dotfiles/.tmux.conf  ~/.tmux.conf
[[ -e ~/.zshrc     ]] || ln -s ~/.dotfiles/.zshrc      ~/.zshrc

mkdir -p ~/.config
[[ -e ~/.config/starship.toml ]] || ln -s ~/.dotfiles/.config/starship.toml ~/.config/starship.toml
[[ -e ~/.config/sheldon/plugins.toml ]] || {
  mkdir -p ~/.config/sheldon && ln -s ~/.dotfiles/.config/sheldon/plugins.toml ~/.config/sheldon/plugins.toml
}
[[ -e ~/.config/mise/config.toml ]] || {
  mkdir -p ~/.config/mise && ln -s ~/.dotfiles/.config/mise/config.toml ~/.config/mise/config.toml
}

[[ $OS == "Mac" ]] && {
  [[ ! -e ~/.gnubinrc ]] && ln -s ~/.dotfiles/.gnubinrc ~/.gnubinrc
  [[ ! -e ~/.bashrc ]] && ln -s ~/.dotfiles/.bashrc ~/.bashrc
  [[ ! -e ~/.emacs ]] && ln -s ~/.dotfiles/.emacs ~/.emacs
  [[ -e ~/.config/ghostty/config ]] || {
    mkdir -p ~/.config/ghostty && ln -s ~/.dotfiles/.config/ghostty/config ~/.config/ghostty/config
  }
  [[ -e ~/.config/karabiner ]] || ln -s ~/.dotfiles/.config/karabiner ~/.config/karabiner
}

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
