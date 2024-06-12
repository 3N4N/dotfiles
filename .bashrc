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

isWSL=false
isMSYS=false
if grep -qEi "(Microsoft|WSL)" /proc/version &> /dev/null ; then
  isWSL=true
elif grep -qEi "(MINGW64_NT|MSYS_NT)" /proc/version &> /dev/null ; then
  isMSYS=true
fi

# ENV variables
export VISUAL=vim
export EDITOR="$VISUAL"
export GEM_HOME=$HOME/gems
export LESS="-iSMRF"
export PAGER="less"
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:range1=32:range2=34:locus=35:quote=33:path=01;36:fixit-insert=32:fixit-delete=31:diff-filename=35:diff-hunk=32:diff-delete=31:diff-insert=32:type-diff=01;32:fnname=35;32:targs=35"

# HIST* are bash-only variables, not environmental variables, so do not 'export'
HISTCONTROL=erasedups:ignoreboth
HISTSIZE=20000
HISTFILESIZE=20000
HISTIGNORE='exit:cd:ls:l:la:lh:bg:fg:history:f:fd:clear'
HISTTIMEFORMAT='%F %T '

# Misc
PROMPT_DIRTRIM=4                # truncate long paths to ".../foo/bar/baz"
PROMPT_COMMAND='history -a'     # append history file after each command
shopt -s histappend             # don't overwrite previous history
shopt -s cmdhist                # store one command per line in history
shopt -s checkwinsize           # update $LINES and $COLUMNS after each command
shopt -s globstar &> /dev/null  # (bash 4+) enable recursive glob
shopt -s extglob                # enable extended globbing
stty -ixon                      # remove XON/XOFF
printf '\033[?12l'              # for xterm-like terms: unblinking block cursor


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
alias rg='rg --smart-case -g "!tags" -g "!build" -g "!release" -g "!po"'
alias grep='grep --color=auto --exclude-dir={".git","node_modules",".cache"} --exclude="tags"'

# shorthand for python executables
alias py='python'
alias py2='python2'
alias py3='python3'

# spotify controls
alias spp="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause"
alias sprev="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous"
alias snext="dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next"

# ffmpeg hide banner
alias ffmpeg='ffmpeg -hide_banner'
alias ffplay='ffplay -hide_banner -noborder'
alias ffprobe='ffprobe -hide_banner'

# Commands for for docker
alias dcbuild='docker compose build'
alias dcup='docker compose up'
alias dcdown='docker compose down'
alias dockps='docker ps --format "{{.ID}}  {{.Names}}"'
docksh() { docker exec -it $1 /bin/bash; }

# miscellaneous
alias md='mkdir -pv'
alias psgrep='ps aux | head -n 1 && ps aux | grep -v grep | grep --color -i'
alias reload='source ~/.bashrc'
alias tree='tree -nF --dirsfirst'
alias vi='$VISUAL'
alias xclip='xclip -selection clipboard'
alias gdb='gdb --silent'
alias xargs='xargs '    # to expand aliases in "<cmd> | xargs <alias>"

# WSL and MSYS aliases
if [[ $isWSL == 'true' || $isMSYS == 'true' ]]; then
  alias e='explorer.exe'
  alias xclip='win32yank'
fi

if [ $isMSYS == 'true' ]; then
  # SSH shipped with msys is prissy about .ssh/ permissions
  # which is hard to change in windows (no chmod)
  # And OpenSSH shipped with Windows has a bug:
  # It doesn't catch C-Space, which is my tmux prefix
  # So gotta use uptodate OpenSSH from Scoop
  alias ssh='$HOME/scoop/shims/ssh'
  alias scp='$HOME/scoop/shims/scp'

  if [ ! -z ${TMUX} ]; then
    # git-for-windows in tmux causes less to behave weird
    # It sends warning: terminal is not fully functional
    # And paging back causes the screen to refresh very slowly
    alias git='TERM=xterm git'
  fi
fi

# clang's colored warnings/errors can't be seen in white background
alias clang='clang -fno-diagnostics-color'
alias clang++='clang++ -fno-diagnostics-color'

alias cmakec='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1'
alias cmaked='cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -DCMAKE_BUILD_TYPE=Debug'


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
  kill -9 `ps aux | grep -v grep | grep -i "$1" | awk '{print $2}'`
}

mcd() {
    if [ -z "$1" ]; then
      echo '[ERROR] Directory name not provided'
      return
    else
        DIRNAME=$1
    fi

    mkdir -p "$DIRNAME"
    cd "$DIRNAME"
}

myip() {
  curl -s https://icanhazip.com
}

# tmux starter function
t() {
  if [ -z "$1" ]; then
    session_name="enan"
  else
    session_name=$1
  fi

  tmux has-session -t="$session_name"

  if [ $? != 0 ]; then
    tmux new-session -s "$session_name" -d
    tmux rename-window -t "$session_name" shell
    tmux new-window -t "$session_name"

    if [[ $session_name == "enan" && $isMSYS == 'false' ]]; then
      tmux rename-window -t "$session_name" dots
      tmux send-keys -t "$session_name" 'cd ~/projects/dotfiles' C-m
    fi

    tmux select-window -t 2
  fi

  if [ -n $WT_SESSION ] && [ $isMSYS == 'true' ]; then
    script -q -c 'tmux attach-session -t "$session_name"'
  else
    tmux attach-session -t "$session_name"
  fi
}

_t_completions() {
  SUGGESTIONS=$(tmux ls -F '#{session_name}')
  COMPREPLY=($(compgen -W "$SUGGESTIONS" -- "${COMP_WORDS[1]}"))
}
complete -F _t_completions t

# Open a file and detach the process
o() {
  if [ -z "$1" ]; then
    echo "FUCK!"
  else
    if [ $isMSYS == 'true' ]; then
      start "$@"
    elif [ $isWSL == 'true' ]; then
      cmd.exe /C "start "" $(wslpath -aw $1)"
    else
      xdg-open "$1" & disown
    fi
  fi
}


licensify() {
  curl -s -S https://www.gnu.org/licenses/gpl-3.0.txt > COPYING
}

if [ $isMSYS == 'true' ]; then
  wts() {
    $VISUAL $LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json
  }
fi


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
  if [ -f /etc/bash-completion.d/git-completion.bash ]; then
    . /etc/bash-completion.d/git-completion.bash
  fi
fi


# ----------------------------------------------------------------------
#                                  title string
# ----------------------------------------------------------------------

case "$TERM" in
    xterm*|st*|tmux*)
        PROMPT_COMMAND='printf "\033]0;%s@%s\007" "${USER}" "${HOSTNAME%%.*}"'
        ;;
esac


# ----------------------------------------------------------------------
#                                   ROS STUFF
# ----------------------------------------------------------------------

ros_setup_script="/opt/ros/noetic/setup.bash"
gazebo_model_path="~/.gazebo/models/:~/projects/gazebo_models/"

if [ -f "$ros_setup_script" ] ; then
  source "$ros_setup_script"
fi

export GAZEBO_MODEL_PATH=${GAZEBO_MODEL_PATH}:$gazebo_model_path

s() {
  f_setup="devel/setup.bash"
  curdir=`pwd`
  while [ ! -f "$f_setup" ] ; do
    cd ..
  done
  if [ -f "$f_setup" ] ; then
    source "$f_setup"
  else
    echo "$f_setup not found"
  fi
  cd "$curdir"
}

#  -- RUST STUFF -------------------------------------------------------------

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

#  -- riscv stuff ------------------------------------------------------------

if [ -d "$HOME/.opt/riscv" ]; then
  export RISCV=$HOME/.opt/riscv
  export RV=riscv64-unknown-elf
  if [ -d "$RISCV/bin" ]; then
    export PATH="$PATH:$RISCV/bin"
  fi
fi

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

PS1='\[$green\]\u@\h \[$red\]\A \[$yellow\]\w\[$reset\]\n\s-\v\$ '
if [[ "$isMSYS" == 'true' ]]; then
  PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "`cygpath -w "$PWD"`"'
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
