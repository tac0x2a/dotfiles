#!/bin/bash

UNAME=$(uname)

if [ "$(uname)" == 'Darwin' ]; then OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then OS='Linux'
else
  echo "Unknown uname '${UNAME}'. Exit."
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
  brew install bat jq gh mise moreutils starship fzf sheldon

  # GNU commands for Mac
  [[ $OS == "Mac" ]] && brew install wget curl git tmux zsh zsh-completions htop
  # [[ $OS == "Mac" ]] && brew install grep gawk gzip gnu-tar gnu-sed gnu-time gnu-getopt binutils findutils diffutils coreutils moreutils
}

# rbenv -----------------------------------------------------------------------------------
# [[ -d ~/.rbenv ]] || {
#   git clone https://github.com/rbenv/rbenv.git ~/.rbenv
#   ~/.rbenv/bin/rbenv init
# }
# [[ -d ~/.rbenv/plugins/ruby-build ]] || {
#   sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev
#   mkdir -p ~/.rbenv/plugins
#   git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
# }
# curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-doctor | bash

# Python
# pyenv -----------------------------------------------------------------------------------
# [[ -d ~/.pyenv ]] || {
#   [[ $OS == "Linux" ]] && {
#     sudo apt install -y zlib1g-dev build-essential libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev liblzma-dev tk-dev
#     git clone https://github.com/pyenv/pyenv.git ~/.pyenv
#   }
#   [[ $OS == "Mac" ]] && brew install pyenv && mkdir ~/.pyenv
# }

# uv -----------------------------------------------------------------------------------
[[ -d $HOMEBREW_PREFIX ]] && brew install uv

# SDKMAN! -----------------------------------------------------------------------------------
# [[ -d ~/.sdkman ]] || {
#   [[ $OS == "Linux" ]] && sudo apt install -y zip
#   curl -s "https://get.sdkman.io" | bash
#   rm ~/.zshrc
# }

# nvm --------------------------------------------------------------------------------------
[[ -d ~/.nvm ]] || {
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
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
