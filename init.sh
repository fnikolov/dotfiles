sudo apt update
sudo apt upgrade -y
sudo apt install neovim tig -y

ln -s ~/dotfiles/.config        ~/.config
ln -s ~/dotfiles/.bash_aliases  ~/.bash_aliases
#ln -s ~/dotfiles/.vimrc         ~/.vimrc
echo "source ~/dotfiles/.bash_profile" >> ~/.bashrc
