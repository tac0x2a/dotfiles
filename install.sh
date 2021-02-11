cd ~/

sudo apt update
sudo apt upgrade
sudo apt install -y git lv tmux zsh zsh-syntax-highlighting wget peco

# Zinit ---------------------------------------------------------------------------------------
mkdir ~/.zinit
git clone https://github.com/zdharma/zinit.git ~/.zinit/bin


# Homebrew -----------------------------------------------------------------------------------
sudo apt install -y build-essential curl file
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

sudo apt install -y zlib1g-dev build-essential libssl-dev libbz2-dev libreadline-dev libsqlite3-dev

# Github -----------------------------------------------------------------------------------
ssh-keygen -t rsa

# dotfiles -----------------------------------------------------------------------------------
git clone https://github.com/tac0x2a/dotfiles.git ~/.dotfiles

ln -s ~/.dotfiles/.gitconfig  ~/.gitconfig
ln -s ~/.dotfiles/.tmux.conf  ~/.tmux.conf
ln -s ~/.dotfiles/.zshrc      ~/.zshrc
cp    ~/.dotfiles/.zshrc.mine ~/.zshrc.mine

mkdir -p ~/.config/peco
ln -s ~/.dotfiles/.config/peco/config.json ~/.config/peco/config.json

echo "Please run 'chsh -s $(which zsh)'"


# symlinks -----------------------------------------------------------------------------------
echo "RODO: Please run 'chsh -s $(which zsh)'"
echo "TODO: Please run 'ln -s /paty/to/your/.pypirc ~/.pypirc'"
echo "TODO: Please run 'ln -s /mnt/c/Users/tac/Desktop ~/Desktop'"
echo "TODO: Please run 'ln -s /mnt/c/Users/tac/GoogleDrive ~/GoogleDrive'"
echo 'TODO: Register your rsa key to Github'

