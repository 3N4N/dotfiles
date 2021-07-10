#!/usr/bin/env bash

# Author : Enan Ajmain
# Email  : 3nan.ajmain@gmail.com
# Github : https://github.com/3N4N

VERSION=2.2.0

sudo apt remove silversearcher-ag
sudo apt install automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev

wget https://geoff.greer.fm/ag/releases/the_silver_searcher-"${VERSION}".tar.gz
tar xzf the_silver_searcher-"${VERSION}".tar.gz
rm -f the_silver_searcher-"${VERSION}".tar.gz
cd the_silver_searcher-"${VERSION}"
./configure
make
sudo make install

cd -
rm -rf the_silver_searcher-"${VERSION}"
