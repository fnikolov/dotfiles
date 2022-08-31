#!/bin/bash

if command -v apt-get >/dev/null; then
  echo "apt-get is used here"
  PCK_MAN=apt
elif command -v dnf >/dev/null; then
  echo "dnf is used here"
  PCK_MAN=dnf
else
  echo "I have no Idea what im doing here"
  exit 1
fi

if $PCK_MAN=dnf; then
  sudo dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
  sudo dnf install -y neovim python3-neovim

sudo $PCK_MAN update
sudo $PCK_MAN upgrade -y
sudo $PCK_MAN install neovim tig -y

# install kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install kube-ps1
mkdir -p ~/.src
cd ~/.src
git clone https://github.com/jonmosco/kube-ps1.git

ln -s ~/dotfiles/.config        ~/.config
ln -s ~/dotfiles/.bash_aliases  ~/.bash_aliases
#ln -s ~/dotfiles/.vimrc         ~/.vimrc

if ! grep -Fxq "source ~/dotfiles/.bash_profile" ~/.bashrc
then
    echo "source ~/dotfiles/.bash_profile" >> ~/.bashrc
fi


