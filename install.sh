#!/bin/bash

DIR=$HOME/Documents/projects/dotFiles
BINDIR=$HOME/bin
EMACSDIR=$HOME/.emacs.d
VIMDIR=$HOME/.config/nvim
I3DIR=$HOME/.config/i3
RANGERDIR=$HOME/.config/ranger
CMUSDIR=$HOME/.cmus
FONTDIR=$HOME/.fonts
TERMINALRC=$HOME/.config/xfce4/terminal
BACKGROUNDDIR=$HOME/Pictures/backgrounds

rm -rf $BINDIR
ln -s $DIR/bin $BINDIR

rm -rf $VIMDIR
ln -s $DIR/nvim $VIMDIR

mkdir -p $EMACSDIR
rm -f $EMACSDIR/init.el
ln -s $DIR/init.el $EMACSDIR

rm -rf $I3DIR
ln -s  $DIR/i3 $I3DIR

rm -f $HOME/.config/compton.conf
ln -s $DIR/compton.conf $HOME/.config

rm -f $HOME/.profile $HOME/.bash_profile $HOME/.bashrc
ln -s $DIR/.profile $DIR/.bash_profile $DIR/.bashrc $HOME/
rm -f $HOME/.tmux.conf $HOME/.gitconfig
ln -s $DIR/.tmux.conf $DIR/.gitconfig $HOME/

mkdir -p $CMUSDIR
rm -f $CMUSDIR/cmus.theme
ln -s $DIR/cmus.theme $CMUSDIR/cmus.theme

rm -rf $HOME/.config/ranger
ln -s $DIR/ranger $RANGERDIR

rm -rf $FONTDIR
mkdir $FONTDIR
cp -r $DIR/fonts/* $FONTDIR

mkdir -p $TERMINALRC
cp $DIR/terminalrc $TERMINALRC

rm -rf $BACKGROUNDDIR
ln -s $DIR/backgrounds $BACKGROUNDDIR
