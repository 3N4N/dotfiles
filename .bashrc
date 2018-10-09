#
#  ██████╗  █████╗ ███████╗██╗  ██╗
#  ██╔══██╗██╔══██╗██╔════╝██║  ██║
#  ██████╔╝███████║███████╗███████║
#  ██╔══██╗██╔══██║╚════██║██╔══██║
#  ██████╔╝██║  ██║███████║██║  ██║
#  ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝

# -- bash specific settings ----------------------------------------------------

# do not continue if we are not in a bash shell
[ -z "$BASH_VERSION" ] && return
# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# automatically cd into directories
shopt -s autocd

# HIST* are bash-only variables, not environmental variables, so do not 'export'
HISTCONTROL=erasedups:ignoreboth
HISTSIZE=20000
HISTFILESIZE=20000
HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd'
HISTTIMEFORMAT='%F %T '
shopt -s histappend             # don't overwrite previous history
shopt -s cmdhist                # store one command per line in history
PROMPT_COMMAND='history -a'     # append history file after each command
PROMPT_DIRTRIM=4                # truncate long paths to ".../foo/bar/baz"

shopt -s checkwinsize           # update $LINES and $COLUMNS after each command
shopt -s globstar &> /dev/null  # (bash 4+) enable recursive glob
shopt -s extglob                # enable extended globbing

bind 'set show-all-if-unmodified'
bind 'set completion-ignore-case on'
bind 'set mark-symlinked-directories on'

# bind c-p and c-n keys for history navigation
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

# -- aliases -------------------------------------------------------------------

# useful ls aliases
alias l='ls -hF1 --group-directories-first'
alias la='l -A'
alias lh='la -d .[^.]*'
alias ld='la -d --indicator-style=none */ .[^.]*/'
alias ll='l -l --time-style=+'
alias lal='la -l --time-style=+'
alias lhl='lh -l --time-style=+'
alias ldl='ld -l --time-style=+'

# show colors in grep and ag
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias ag='ag --color-match "31"'

# shorthand for python executables
alias py2='python2'
alias py3='python3'

# miscellaneous
alias tree='tree -nF --dirsfirst'           # append indicators after filename
alias reload='source ~/.bashrc'             # reload bashrc
alias screenfetch='screenfetch -t'          # wrap output of screenfetch
alias emacs='emacs -nw'                     # use terminal emacs in terminal
alias vi='nvim'                             # old habits die hard
alias vimdiff='nvim -d'                     # used in .gitconfig
alias t='sh ~/projects/dotFiles/tmux.sh'    # run tmux start script
alias weather='curl wttr.in/dhaka?0'        # get weather report
alias i3lock='sh ~/projects/dotFiles/i3/lock.sh'

# elaborate digital clock
now() {
  echo -n 'date: '
  date "+%A, %B %d"
  echo -n 'time: '
  date "+%H:%M"
}

# -- bash prompt ---------------------------------------------------------------

PS1='\[\033[00;34m\]\u\[\033[00m\]@\[\033[00;34m\]\h\[\033[00m\]:\
\[\033[00;33m\]\w\[\033[00m\]\$ '
