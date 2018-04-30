#!/bin/bash

DIR=$HOME/Git-repos/dotFiles
EMACSDIR=$HOME/.emacs.d
VIMDIR=$HOME/.config/nvim
I3DIR=$HOME/.config/i3
RANGERDIR=$HOME/.config/ranger
CMUSDIR=$HOME/.cmus

mkdir -p $VIMDIR
rm $VIMDIR/init.vim
ln -s $DIR/init.vim $VIMDIR

mkdir -p $EMACSDIR
rm $EMACSDIR/init.el
ln -s $DIR/init.el $EMACSDIR

mkdir -p $I3DIR
rm $I3DIR/config $I3DIR/i3blocks.conf
rm -rf $I3DIR/scripts
ln -s $DIR/config $I3DIR
ln -s $DIR/i3blocks.conf $I3DIR
ln -s $DIR/scripts $I3DIR

rm $HOME/.config/compton.conf
ln -s $DIR/compton.conf $HOME/.config

rm -rf $HOME/.config/ranger
ln -s $DIR/ranger $RANGERDIR

rm -rf $HOME/.zshrc $HOME/.Xresources $HOME/.tmux.conf $HOME/.gitconfig
ln -s $DIR/.zshrc $DIR/.Xresources $DIR/.tmux.conf $DIR/.gitconfig $HOME/

rm -rf $HOME/.gitconfig
ln -s $DIR/.gitconfig $HOME/

mkdir -p $CMUSDIR
rm -rf $CMUSDIR/cmus.theme
ln -s $DIR/cmus.theme $CMUSDIR/cmus.theme
