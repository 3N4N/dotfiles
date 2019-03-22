#!/usr/bin/env bash
# Author: Enan Ajmain
# Email : 3nan.ajmain@gmail.com
# Github: https://github.com/enanajmain

VERSION=26.1

sudo apt remove emacs
sudo apt build-dep emacs25

cd /tmp
wget http://ftp.gnu.org/gnu/emacs/emacs-"${VERSION}".tar.gz
tar xzvf emacs-"${VERSION}".tar.gz
cd emacs-"${VERSION}"
./configure
make
sudo make install
