#!/bin/bash

DIR=$HOME/projects/dotFiles
BACKGROUNDDIR=$HOME/Pictures/backgrounds
BINDIR=$HOME/.bin
CMUSDIR=$HOME/.cmus
DUNSTDIR=$HOME/.config/dunst
FEHDIR=$HOME/.config/feh
MPVDIR=$HOME/.config/mpv
VIFMDIR=$HOME/.config/vifm
VIMDIR=$HOME/.config/nvim

rm -f $HOME/.profile $HOME/.bash_profile $HOME/.bashrc
ln -s $DIR/.profile $DIR/.bash_profile $DIR/.bashrc $HOME/
rm -f $HOME/.tmux.conf $HOME/.gitconfig $HOME/.xinitrc
ln -s $DIR/.tmux.conf $DIR/.gitconfig $DIR/.xinitrc $HOME/

rm -f $HOME/.config/compton.conf
ln -s $DIR/compton.conf $HOME/.config

rm -rf $BINDIR
ln -s $DIR/bin $BINDIR

rm -rf $VIMDIR
ln -s $DIR/nvim $VIMDIR

mkdir -p $CMUSDIR
rm -f $CMUSDIR/cmus.theme
ln -s $DIR/cmus.theme $CMUSDIR/cmus.theme

rm -rf $BACKGROUNDDIR
ln -s $DIR/backgrounds $BACKGROUNDDIR

rm -rf $DUNSTDIR
mkdir -p $DUNSTDIR
ln -s $DIR/dunstrc $DUNSTDIR

rm -rf $MPVDIR
ln -s $DIR/mpv $MPVDIR

rm -rf $VIFMDIR
ln -s $DIR/vifm $VIFMDIR

rm -rf $FEHDIR
ln -s $DIR/feh $FEHDIR

if [ "$1" == "-a" ]; then
	sudo apt install \
		acpi \
		cmus \
		curl \
		deluge \
		easytag \
		feh \
		ffmpeg \
		htop \
		imagemagick \
		mpv \
		pavucontrol \
		rar \
		scrot \
		silversearcher-ag \
		tree \
		x11-xkb-utils \
		xbacklight \
		xclip \
		zip
fi
