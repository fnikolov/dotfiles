sudo apt update
sudo apt upgrade -y
sudo apt install neovim tig -y

# install kubectl
sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install kube-ps1
mkdir ~/bin
cd ~/bin
git clone git@github.com:jonmosco/kube-ps1.git

ln -s ~/dotfiles/.config        ~/.config
ln -s ~/dotfiles/.bash_aliases  ~/.bash_aliases
#ln -s ~/dotfiles/.vimrc         ~/.vimrc
echo "source ~/dotfiles/.bash_profile" >> ~/.bashrc

