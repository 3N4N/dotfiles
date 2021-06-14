#!/usr/bin/env bash

DIR=$HOME/projects/dotFiles

DOTFILES=(
	"bin"
	".bashrc"
	".bash_profile"
	".gitconfig"
	".profile"
	".tmux.conf"
	".xinitrc"
	".config/mpv"
	".config/nvim"
	".config/ranger"
	".local/share/fonts"
)

for dotfile in "${DOTFILES[@]}";do
	rm -rf "${HOME}/${dotfile}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done

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
		pavucontrol \
		rar \
		silversearcher-ag \
		tree \
		wget \
		x11-xkb-utils \
		xbacklight \
		xclip \
		zip
fi
