# dotfiles
dotfiles

```sh
sudo apt install git
git clone https://github.com/tac0x2a/dotfiles.git ~/.dotfiles
cd .dotfiles
chmod +x ./install.sh
./install.sh
```

## Install Packages

```sh
sudo apt update
sudo apt upgrade
sudo apt install git tmux zsh zsh-syntax-highlighting

# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv

ssh-keygen -t rsa
# TODO: Register to Github

git clone https://github.com/tac0x2a/dotfiles.git ~/.dotfiles

ln -s ~/.dotfiles/gitconfig      ~/.gitconfig
ln -s ~/.dotfiles/dot.tmux.conf  ~/.tmux.conf
ln -s ~/.dotfiles/dot.zshrc      ~/.zshrc
ln -s ~/.dotfiles/dot.zshrc.mine ~/.zshrc.mine

echo "Please run 'chsh -s $(which zsh)'"
```
