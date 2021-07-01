#!/usr/bin/env bash
# Author: Enan Ajmain
# Email : 3nan.ajmain@gmail.com
# Github: https://github.com/enanajmain

VERSION=3.2a

sudo apt remove tmux
sudo apt install wget tar gcc g++ make libevent-dev libncurses-dev

wget https://github.com/tmux/tmux/releases/download/""${VERSION}""/tmux-$VERSION.tar.gz
tar xvzf tmux-"${VERSION}".tar.gz
rm -f tmux-"${VERSION}".tar.gz
cd tmux-"${VERSION}"
./configure
make
sudo make install

cd -
rm -rf tmux-"${VERSION}"
