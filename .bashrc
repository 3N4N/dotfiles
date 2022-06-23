# Author: Enan Ajmain
# Email : 3nan.ajmain@gmail.com
# Github: https://github.com/3N4N




# ----------------------------------------------------------------------
#                             bash specific settings
# ----------------------------------------------------------------------

# do not continue if we are not in a bash shell
[ -z "$BASH_VERSION" ] && return
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

isWSL=0
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
    isWSL=1
fi

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

# remove XON/XOFF
stty -ixon


# ----------------------------------------------------------------------
#                                    aliases
# ----------------------------------------------------------------------

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
alias grep='grep --color=auto --exclude-dir=".git" --exclude-dir="node_modules" --exclude="tags"'

# shorthand for python executables
alias py2='python2'
alias py3='python3'

# spotify controls
alias spp="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
alias sprev="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
alias snext="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"

# Commands for for docker
alias dcbuild='docker-compose build'
alias dcup='docker-compose up'
alias dcdown='docker-compose down'
alias dockps='docker ps --format "{{.ID}}  {{.Names}}"'
docksh() { docker exec -it $1 /bin/bash; }

# miscellaneous
alias mkdir='mkdir -pv'
alias psgrep='ps aux | head -n 1 && ps aux | grep -v grep | grep --color -i'
alias reload='source ~/.bashrc'
alias tree='tree -nF --dirsfirst'
alias vi='nvim'
alias vimdiff='nvim -d'
alias o='xdg-open'
alias xclip='xclip -selection clipboard'
alias gdb='gdb --silent'

# WSL aliases
if [ $isWSL ]; then
    alias e='explorer.exe'
fi


# ----------------------------------------------------------------------
#                                   functions
# ----------------------------------------------------------------------

# elaborate digital clock
now() {
    echo -n 'date : '
    date "+%A, %B %d"
    echo -n 'time : '
    date "+%H:%M"
}

# Set the title of the terminal window or tab
set-title() {
    if [[ -z "$PS1_BAK" ]]; then
        PS1_BAK=$PS1
    fi

    TITLE="\[\e]2;$@\a\]"
    PS1=${PS1_BAK}${TITLE}
}

fmk() {
  kill `ps aux | grep -v grep | grep -i $1 | awk '{print $2}'`
}

# tmux starting script
t() {
    if [ -z "$1" ]; then
        session_name="enan"
    else
        session_name=$1
    fi

    cd ~
    tmux has-session -t="$session_name"

    if [ $? != 0 ]; then
        tmux new-session -s "$session_name" -d
        tmux rename-window -t "$session_name" shell
        tmux new-window -t "$session_name"

        if [ $session_name = "enan" ]; then
            tmux rename-window -t "$session_name" dots
            tmux send-keys -t "$session_name" 'cd ~/projects/dotFiles' C-m
            # tmux send-keys -t "$session_name" 'nvim' C-m
        fi


        tmux select-window -t 2
    fi

    tmux attach-session -t "$session_name"
}


# Open a file and detach the process
xopen() {
    xdg-open "$1" & disown
}

start() {
    if [ -z "$1" ]; then
        echo "FUCK!"
    else
        cmd.exe /C "open $(wslpath -aw $1)"
    fi
}


# ----------------------------------------------------------------------
#                                      fzf
# ----------------------------------------------------------------------

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
'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=light
    --color=fg:-1,bg:-1,hl:33,fg+:241,bg+:221,hl+:33
    --color=info:33,prompt:33,pointer:166,marker:166,spinner:33
'

if  hash ag 2>/dev/null ; then
    export FZF_DEFAULT_COMMAND='ag --nocolor -g "" 2> /dev/null'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
else
    export FZF_DEFAULT_COMMAND='find -type f'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# use fzf to open files
bind -x '"\C-o": file="$(fzf --height 40% --reverse)" && [ -f "$file" ] && xdg-open "$file"'


# ----------------------------------------------------------------------
#                              bash autocompletion
# ----------------------------------------------------------------------

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


# ----------------------------------------------------------------------
#                                  title string
# ----------------------------------------------------------------------

case "$TERM" in
    st*)
        PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}"'
        ;;
    xterm*)
        PROMPT_COMMAND='printf "\033]0;%s@%s\007" "${USER}" "${HOSTNAME%%.*}"'
        ;;
esac


# ----------------------------------------------------------------------
#                                   ROS STUFF
# ----------------------------------------------------------------------

ros_setup_script="/opt/ros/noetic/setup.bash"
gazebo_model_path="/home/enan/.gazebo/models/:/home/enan/code/gazebo_models/"

if [ -f "$ros_setup_script" ] ; then
  source "$ros_setup_script"
fi

export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:$gazebo_model_path


# ----------------------------------------------------------------------
#                                    set path
# ----------------------------------------------------------------------

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


# ----------------------------------------------------------------------
#                                  bash prompt
# ----------------------------------------------------------------------

turquoise=$(tput setaf 5)
magenta=$(tput setaf 5)
blue=$(tput setaf 4)
yellow=$(tput setaf 3)
green=$(tput setaf 2)
red=$(tput setaf 1)
reset=$(tput sgr0)

PS1='\[$blue\]\u\[$reset\]@\[$blue\]\h\[$reset\]:\[$yellow\]\w\[$reset\]\$ '
