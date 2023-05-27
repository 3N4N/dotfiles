#!/bin/env bash

DIR=$HOME/projects/dotfiles

if [ ! -d $HOME/.local/bin ]; then
  mkdir -p $HOME/.local/bin
fi

if [ ! -d $HOME/.local/man/man1 ]; then
  mkdir -p $HOME/.local/man/man1
fi


# Create symlinks to config
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
    ".local/share/fonts"
)

for dotfile in "${DOTFILES[@]}";do
    rm -rf "${HOME}/${dotfile}"
    ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done


# Config location for gdb is not fixed
# Sometimes it's $XDG_CONFIG_HOME/gdb/gdbinit
# Sometimes it's $HOME/.gdbinit
# So use sourcing on all possible gdb init files
echo 'source $HOME/.config/gdb/gdbinit' > ~/.gdbinit


# Create symlinks for bram's vim to use neovim config
ln -sf "${DIR}/.config/nvim/" "${HOME}/.vim"
ln -sf "${DIR}/.config/nvim/init.vim" "${HOME}/.vim/vimrc"


# Install oft-used software
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
