# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -f "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# append user specified directories to PATH
append_to_path() {
	if [ -d "$1" ] ; then
		new_entry="$1"
		case ":$PATH:" in
			*":$new_entry:"*) :;;
			*) PATH="$new_entry:$PATH";;
		esac
	fi
}

# set PATH so it includes user's private bin if it exists
append_to_path "$HOME/bin"
# set PATH so it includes installed packages with pip
append_to_path "$HOME/.local/bin"
