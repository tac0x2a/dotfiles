cd ~/

sudo apt update
sudo apt upgrade -y
sudo apt install git tmux zsh zsh-syntax-highlighting -y

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

ssh-keygen -t rsa
# TODO: Register to Github

git clone https://github.com/tac0x2a/dotfiles.git ~/.dotfiles

ln -s ~/.dotfiles/gitconfig   ~/.gitconfig
ln -s ~/.dotfiles/.tmux.conf  ~/.tmux.conf
ln -s ~/.dotfiles/.zshrc      ~/.zshrc
ln -s ~/.dotfiles/.zshrc.mine ~/.zshrc.mine

echo "Please run 'chsh -s $(which zsh)'"
