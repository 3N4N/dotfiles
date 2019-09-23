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
	".config/cmus/cmus.theme"
	".config/compton.conf"
	".config/dunst"
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
		cmus \
		curl \
		deluge \
		dmenu \
		dunst \
		easytag \
		evince \
		ffmpeg \
		hsetroot \
		htop \
		mpv \
		pavucontrol \
		rar \
		scrot \
		sxiv \
		tree \
		x11-xkb-utils \
		xbacklight \
		xclip \
		zip
fi
