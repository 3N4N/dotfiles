#!/usr/bin/env bash

# Author : Enan Ajmain
# Email  : 3nan.ajmain@gmail.com
# Github : https://github.com/3N4N

# install dependencies
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
	libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev \
	libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
	libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev xutils-dev autoconf

# install xcb-util-xrm
cd /tmp
git clone https://github.com/Airblader/xcb-util-xrm.git
cd xcb-util-xrm
git submodule update --init
./autogen.sh --prefix=/usr
make
sudo make install

# install i3-gaps
cd /tmp
git clone https://www.github.com/Airblader/i3.git i3-gaps
cd i3-gaps
git checkout gaps-next
autoreconf --force --install
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install
