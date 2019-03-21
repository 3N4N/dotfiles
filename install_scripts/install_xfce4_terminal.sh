#!/usr/bin/env bash
# Author: Enan Ajmain
# Email : 3nan.ajmain@gmail.com
# Github: https://github.com/enanajmain

VERSION=0.8.7.4

sudo apt remove xfce4-terminal
sudo apt build-dep xfce4-terminal
cd /tmp
wget http://archive.xfce.org/src/apps/xfce4-terminal/0.8/xfce4-terminal-"${VERSION}".tar.bz2
tar xvjf xfce4-terminal-"${VERSION}".tar.bz2
cd xfce4-terminal-"${VERSION}"
./configure --prefix=/usr
make
sudo make clean install
