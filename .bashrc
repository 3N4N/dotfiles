# Author: Enan Ajmain
# Email : 3nan.ajmain@gmail.com
# Github: https://github.com/enanajmain

# -- bash specific settings ----------------------------------------------------

# do not continue if we are not in a bash shell
[ -z "$BASH_VERSION" ] && return
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export VISUAL=nvim
export EDITOR="$VISUAL"
export GEM_HOME=$HOME/gems
export LESS="-iSMR"
export PAGER="less"

# HIST* are bash-only variables, not environmental variables, so do not 'export'
HISTCONTROL=erasedups:ignoreboth
HISTSIZE=20000
HISTFILESIZE=20000
HISTIGNORE='exit:cd:ls:l:la:lh:bg:fg:history:f:fd:clear'
HISTTIMEFORMAT='%F %T '
shopt -s histappend             # don't overwrite previous history
shopt -s cmdhist                # store one command per line in history
PROMPT_COMMAND='history -a'     # append history file after each command
PROMPT_DIRTRIM=2                # truncate long paths to ".../foo/bar/baz"

shopt -s checkwinsize           # update $LINES and $COLUMNS after each command
shopt -s globstar &> /dev/null  # (bash 4+) enable recursive glob
shopt -s extglob                # enable extended globbing

bind 'set show-all-if-unmodified'
bind 'set completion-ignore-case on'
bind 'set mark-symlinked-directories on'

# bind c-p and c-n keys for history navigation
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

# remove XON/XOFF
stty -ixon

# -- aliases -------------------------------------------------------------------

# safety features
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# useful ls aliases
alias l='ls -NvhFl --group-directories-first --time-style=+'
alias la='l -A'
alias lh='la -d .[^.]* 2> /dev/null'

# show colors in grep and ag
alias ag='ag --color-match "31"'
alias grep='grep --color=auto --exclude-dir=".git" --exclude="tags"'

# shorthand for python executables
alias py2='python2'
alias py3='python3'

# spotify controls
alias spp="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
alias sprev="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
alias snext="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"

# miscellaneous
alias mkdir='mkdir -pv'
alias psgrep='ps aux | grep -v grep | grep'
alias reload='source ~/.bashrc'
alias tree='tree -nF --dirsfirst'
alias vi='nvim'
alias vimdiff='nvim -d'
# alias xopen='xdg-open'
alias xclip='xclip -selection clipboard'
alias gdb='gdb --silent'

# -- functions -----------------------------------------------------------------

# elaborate digital clock
now() {
	echo -n 'date : '
	date "+%A, %B %d"
	echo -n 'time : '
	date "+%H:%M"
	curl wttr.in/dhaka?0
}

# Set the title of the terminal window or tab
set-title() {
    if [[ -z "$PS1_BAK" ]]; then
        PS1_BAK=$PS1
    fi

    TITLE="\[\e]2;$@\a\]"
    PS1=${PS1_BAK}${TITLE}
}

# Open a file and detach the process
xopen() {
    xdg-open "$1" & disown
}

# -- fzf -----------------------------------------------------------------------

if [ ! -d "$HOME/.fzf" ]; then
	git clone https://github.com/junegunn/fzf.git ~/.fzf
	cd ~/.fzf
	./install --all --no-completion
	cd -
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export FZF_DEFAULT_OPTS='
	--height 40% --multi --layout=reverse --border
	--bind ctrl-f:page-down,ctrl-b:page-up,?:toggle-preview
    --color=bg:#FDF6E3,bg+:#EEE8D5
    --color=fg:#657B83,fg+:#839496
    --color=hl:#DC322F,hl+:#DC322F
'

if  hash ag 2>/dev/null ; then
	export FZF_DEFAULT_COMMAND='ag --nocolor -g "" 2> /dev/null'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
else
	export FZF_DEFAULT_COMMAND='find -type f'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# bind capitalize-word to Alt-I
# in reference to Initcap
# to unshadow Alt-C provided by fzf
bind '"\ei": capitalize-word'

# use fzf to open files
bind -x '"\C-o": file="$(fzf --height 40% --reverse)" && [ -f "$file" ] && xdg-open "$file"'

# -- bash autocompletion -------------------------------------------------------

# using fzf messes with bash completion files
# needs to manually source them again
# might need to add more checks if used on more systems
# or could use ~/.fzf/install --all --no-completion
# this will make fzf leave bash completion alone

if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# -- title string --------------------------------------------------------------

case "$TERM" in
	st*)
		PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}"'
		;;
	xterm*)
		PROMPT_COMMAND='printf "\033]0;%s@%s\007" "${USER}" "${HOSTNAME%%.*}"'
		;;
esac

# -- bash prompt ---------------------------------------------------------------

turquoise=$(tput setaf 5)
magenta=$(tput setaf 5)
blue=$(tput setaf 4)
yellow=$(tput setaf 3)
green=$(tput setaf 2)
red=$(tput setaf 1)
reset=$(tput sgr0)

PS1='\[$blue\]\u\[$reset\]@\[$blue\]\h\[$reset\]:\[$yellow\]\w\[$reset\]\$ '
