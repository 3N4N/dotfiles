#!/bin/bash

DIR=$HOME/projects/dotFiles
BINDIR=$HOME/.bin
VIMDIR=$HOME/.config/nvim
I3DIR=$HOME/.config/i3
CMUSDIR=$HOME/.cmus
FONTDIR=$HOME/.fonts
BACKGROUNDDIR=$HOME/Pictures/backgrounds
DUNSTDIR=$HOME/.config/dunst
MPVDIR=$HOME/.config/mpv
VIFMDIR=$HOME/.config/vifm
FEHDIR=$HOME/.config/feh

rm -f $HOME/.profile $HOME/.bash_profile $HOME/.bashrc
ln -s $DIR/.profile $DIR/.bash_profile $DIR/.bashrc $HOME/
rm -f $HOME/.tmux.conf $HOME/.gitconfig $HOME/.xinitrc
ln -s $DIR/.tmux.conf $DIR/.gitconfig $DIR/.xinitrc $HOME/

rm -rf $BINDIR
ln -s $DIR/bin $BINDIR

rm -rf $VIMDIR
ln -s $DIR/nvim $VIMDIR

rm -rf $I3DIR
ln -s  $DIR/i3 $I3DIR

rm -f $HOME/.config/compton.conf
ln -s $DIR/compton.conf $HOME/.config

mkdir -p $CMUSDIR
rm -f $CMUSDIR/cmus.theme
ln -s $DIR/cmus.theme $CMUSDIR/cmus.theme

rm -rf $FONTDIR
mkdir $FONTDIR
cp -r $DIR/fonts/* $FONTDIR

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
		rar \
		scrot \
		silversearcher-ag \
		tree \
		x11-xkb-utils \
		xbacklight \
		xclip \
		zip
fi
