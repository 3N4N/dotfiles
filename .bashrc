#    _               _
#   | |__   __ _ ___| |__
#   | '_ \ / _` / __| '_ \
#   | |_) | (_| \__ \ | | |
#   |_.__/ \__,_|___/_| |_|
#


## bash specific settings

# HIST* are bash-only variables, not environmental variables, so do not 'export'
HISTCONTROL=erasedups:ignoreboth
HISTSIZE=20000
HISTFILESIZE=20000
HISTIGNORE='exit:cd:ls:bg:fg:history:f:fd'
HISTTIMEFORMAT='%F %T '
shopt -s histappend
shopt -s cmdhist # store one command per line in history
PROMPT_COMMAND='history -a' # append history file after each command
PROMPT_DIRTRIM=3 # truncate long paths to ".../foo/bar/baz"

shopt -s checkwinsize # update $LINES and $COLUMNS after each command.
shopt -s globstar &> /dev/null # (bash 4+) enable recursive glob

bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-p": history-search-backward'
bind '"\C-n": history-search-forward'

## Personal customization

# add ~/Executables/bin to path
executables="~/Executables/bin"
[ -d "$executables" ] && [[ ":$PATH:" != *$executables* ]] && \
export PATH=$executables:${PATH}

# FZF settings
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS='--height 100%'

# aliases
alias ls='ls -CF --color=none'
alias ll='ls -AlF'
alias la='ls -AF'
alias tree='tree -F'
alias refresh='source ~/.bashrc'
alias screenfetch='screenfetch -t'
alias i3lock='sh ~/projects/dotFiles/lock.sh'
alias emacs='emacs -nw'
alias vi='nvim'
alias py2=python2
alias py3=python3
alias t='sh ~/projects/dotFiles/tmux.sh'
alias now="echo -n 'date: '; echo $(date "+%A, %B %d");\
  echo -n 'time: '; echo $(date "+%H:%M")"

# bash prompt
PS1='\[\033[00;34m\]\w\[\033[00m\]\n\$ '
