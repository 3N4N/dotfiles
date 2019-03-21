#!/usr/bin/env bash

DIR=$HOME/projects/dotFiles

DOTFILES=(
	".bin"
	".bashrc"
	".bash_profile"
	".gitconfig"
	".profile"
	".tmux.conf"
	".xinitrc"
	".config/cmus/cmus.theme"
	".config/compton.conf"
	".config/dunst"
	".config/feh"
	".config/mpv"
	".config/nvim"
	".local/share/fonts"
)

for dotfile in "${DOTFILES[@]}";do
	rm -rf "${HOME}/${dotfile}"
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done

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
		mpv \
		pavucontrol \
		rar \
		scrot \
		tree \
		x11-xkb-utils \
		xbacklight \
		xclip \
		zip
fi
