sudo apt install -y git

! [[ -d $HOME/.dotfiles ]] && git clone https://github.com/tac0x2a/dotfiles.git ~/.dotfiles

cd ~/

sudo apt update
sudo apt install -y git lv tmux zsh zsh-syntax-highlighting wget peco

# Zinit ---------------------------------------------------------------------------------------
mkdir ~/.zinit
git clone https://github.com/zdharma/zinit.git ~/.zinit/bin


# Homebrew -----------------------------------------------------------------------------------
sudo apt install -y build-essential curl file
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# brew packages -----------------------------------------------------------------------------------
# none ..

# rbenv -----------------------------------------------------------------------------------
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
~/.rbenv/bin/rbenv init

sudo apt install -y git curl libssl-dev libreadline-dev zlib1g-dev
mkdir -p "$(rbenv root)"/plugins
git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

# curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash


# pyenv -----------------------------------------------------------------------------------
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

sudo apt install -y zlib1g-dev build-essential libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-dev


# SDKMAN! -----------------------------------------------------------------------------------
curl -s "https://get.sdkman.io" | zsh


# dotfiles -----------------------------------------------------------------------------------

ln -s ~/.dotfiles/.gitconfig  ~/.gitconfig
ln -s ~/.dotfiles/.tmux.conf  ~/.tmux.conf
ln -s ~/.dotfiles/.zshrc      ~/.zshrc
touch                         ~/.zshrc.mine

mkdir -p ~/.config/peco
ln -s ~/.dotfiles/.config/peco/config.json ~/.config/peco/config.json

# symlinks -----------------------------------------------------------------------------------
echo "--------------------------------------------------------------------------"
echo "Dotfiles setup finish."
echo "Please run 'chsh -s $(which zsh)'"
echo "Please run 'ln -s /paty/to/your/.pypirc ~/.pypirc'"
echo "Please run 'ln -s /mnt/c/Users/tac/Desktop ~/Desktop'"
echo "Please run 'ln -s /mnt/c/Users/tac/GoogleDrive ~/GoogleDrive'"

echo "Please run 'ssh-keygen -t rsa'"
echo 'TODO: Register your rsa key to Github'

