#!/bin/bash

DIR=$HOME/projects/dotFiles
EMACSDIR=$HOME/.emacs.d
VIMDIR=$HOME/.config/nvim
I3DIR=$HOME/.config/i3
RANGERDIR=$HOME/.config/ranger
CMUSDIR=$HOME/.cmus
FONTDIR=$HOME/.fonts
BACKGROUNDDIR=$HOME/.local/share/backgrounds

mkdir -p $VIMDIR
rm -f $VIMDIR/init.vim
ln -s $DIR/init.vim $VIMDIR

mkdir -p $EMACSDIR
rm -f $EMACSDIR/init.el
ln -s $DIR/init.el $EMACSDIR

mkdir -p $I3DIR
rm -f $I3DIR/config $I3DIR/i3blocks.conf
rm -rf $I3DIR/scripts
ln -s $DIR/config $I3DIR
ln -s $DIR/i3blocks.conf $I3DIR
ln -s $DIR/scripts $I3DIR

rm -f $HOME/.config/compton.conf
ln -s $DIR/compton.conf $HOME/.config

rm -f $HOME/.profile $HOME/.bash_profile $HOME/.bashrc $HOME/.tmux.conf $HOME/.gitconfig
ln -s $DIR/.profile $DIR/.bash_profile $DIR/.bashrc $DIR/.tmux.conf $DIR/.gitconfig $HOME/

mkdir -p $CMUSDIR
rm -f $CMUSDIR/cmus.theme
ln -s $DIR/cmus.theme $CMUSDIR/cmus.theme

rm -rf $HOME/.config/ranger
ln -s $DIR/ranger $RANGERDIR

rm -rf $FONTDIR
mkdir $FONTDIR
cp -r $DIR/fonts/* $FONTDIR

rm -rf $BACKGROUNDDIR
ln -s $DIR/backgrounds $BACKGROUNDDIR
