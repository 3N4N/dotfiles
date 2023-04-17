#!/bin/env bash

DIR=$HOME/projects/dotfiles

if [ ! -d $HOME/.local/bin ]; then
  mkdir -p $HOME/.local/bin
fi

if [ ! -d $HOME/.local/man/man1 ]; then
  mkdir -p $HOME/.local/man/man1
fi

DOTFILES=(
    "bin"
    ".bashrc"
    ".bash_profile"
    ".gitconfig"
    ".inputrc"
    ".profile"
    ".ripgreprc"
    ".tmux.conf"
    ".uncrustify.cfg"
    ".xinitrc"
    ".sig"
    ".config/gdb"
    ".config/mpv"
    ".config/nvim"
    ".config/ranger"
    ".local/share/fonts"
)

for dotfile in "${DOTFILES[@]}";do
    rm -rf "${HOME}/${dotfile}"
    ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done

echo 'source $HOME/.config/gdb/gdbinit' > ~/.gdbinit

if [ "$1" == "-a" ]; then
    sudo apt install \
        acpi \
        curl \
        deluge \
        ffmpeg \
        git \
        htop \
        mpv \
        mupdf \
        p7zip-full \
        pavucontrol \
        rar \
        ripgrep \
        silversearcher-ag \
        tree \
        uncrustify \
        universal-ctags \
        valgrind \
        wget \
        x11-xkb-utils \
        xbacklight \
        xclip \
        zip
fi
