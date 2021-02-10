cd ~/

sudo apt update
sudo apt upgrade
sudo apt install -y git tmux zsh zsh-syntax-highlighting wget peco


# Homebrew -----------------------------------------------------------------------------------
sudo apt -y install build-essential curl file
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew packages -----------------------------------------------------------------------------------


# rbenv -----------------------------------------------------------------------------------
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
~/.rbenv/bin/rbenv init

sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash


# pyenv -----------------------------------------------------------------------------------
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

sudo apt install zlib1g-dev build-essential libssl-dev libbz2-dev libreadline-dev libsqlite3-dev

# Github -----------------------------------------------------------------------------------
ssh-keygen -t rsa
# TODO: Register to Github# TODO: Register to Github
echo 'TODO: Register to Github'


# dotfiles -----------------------------------------------------------------------------------
git clone https://github.com/tac0x2a/dotfiles.git ~/.dotfiles

ln -s ~/.dotfiles/.gitconfig  ~/.gitconfig
ln -s ~/.dotfiles/.tmux.conf  ~/.tmux.conf
ln -s ~/.dotfiles/.zshrc      ~/.zshrc
ln -s ~/.dotfiles/.zshrc.mine ~/.zshrc.mine

echo "Please run 'chsh -s $(which zsh)'"
