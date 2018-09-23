#!/bin/bash

source $LIB

brewinstall vim
brewinstall macvim

info "==>" "config vimrc"
backup ~/.vimrc
linkconf $INSTALL_HOME/package/vim/vimrc ~/.vimrc

if [ ! -f ~/.vim/autoload/plug.vim ]; then
  info "==>" "install plug.vim"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

read -r -p "do you want to install vim plugins (y/n): " ans
if [ $ans = 'y' ]; then
  vim +PlugInstall +qall
fi

read -r -p "do you want to compile YouCompleteMe (y/n): " ans
if [ $ans = 'y' ]; then
  python3 ~/.vim/plug/YouCompleteMe/install.py --clang-completer --java-completer
fi
