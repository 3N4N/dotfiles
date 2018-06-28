#           _
#   _______| |__
#  |_  / __|  _ \
#   / /\__ \ | | |
#  /___|___/_| |_|
#

# install oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && \
  git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# install zsh-autosuggestion
[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ] && \
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
  ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# oh-my-zsh config
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=13
DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(
  zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# FZF settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 100% '

# don't show colors in tab-completion
zstyle ':completion:*' list-colors


## aliases

# useful ls aliases
alias ls="ls -hF1 --group-directories-first"
alias la="ls -A"
alias lh="la -d .[^.]*"
alias ld="la -d --indicator-style=none */ .[^.]*/"
alias lsl="ls -l"
alias lal="la -l"
alias lhl="lh -l"
alias ldl="ld -l"

# show colors in grep and ag
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
alias ag="ag --color-match \"31;40\""

# shorthand for python executables
alias py2="python2"
alias py3="python3"

# miscellaneous
alias tree="tree -F"                          # append indicators after filename
alias reload="source ~/.zshrc"                # reload.zshrc
alias screenfetch="screenfetch -t"            # wrap output of screenfetch
alias i3lock="sh ~/projects/dotFiles/lock.sh" # use custom script to lock screen
alias emacs="emacs -nw"                       # use terminal emacs in terminal
alias vi="nvim"                               # old habits die hard
alias t="sh ~/projects/dotFiles/tmux.sh"      # run tmux start script
alias ip="curl icanhazip.com"                 # get public ip address
alias weather="curl wttr.in/dhaka"            # get weather report

# elaborate digital clock
alias now="echo -n 'date: '; echo $(date "+%A, %B %d");\
  echo -n 'time: '; echo $(date "+%H:%M")"



## zsh prompt with git info

# get git branch name
git_branch() {
  git branch --no-color 2>/dev/null | \
  sed -e '/^[^*]/d' -e 's/* \(\|(HEAD detached \)\([^)]*\)\(\|)\)/\2/'
}

# get git status
git_status() {
  # + changes are staged and ready to commit
  # ! unstaged changes are present
  # ? untracked files are present
  # $ changes have been stashed
  # ↑ local commits need to be pushed to the remote
  local state="$(git status --porcelain 2>/dev/null)"
  local output=''
  [[ -n $(egrep '^[MADRC]' <<<"$state") ]] && output="$output+"
  [[ -n $(egrep '^.[MD]' <<<"$state") ]] && output="$output!"
  [[ -n $(egrep '^\?\?' <<<"$state") ]] && output="$output?"
  [[ -n $(git stash list) ]] && output="$output$"
  [[ -n $(git log --branches --not --remotes) ]] && output="$output↑"
  echo $output
}

# get git prompt
git_prompt() {
  local branch=$(git_branch)
  if [[ -n $branch ]]; then
    local state=$(git_status)
    if [[ -n $state ]]; then
      echo -e "%{%F{yellow}%} $branch %{%F{red}%}[$state]"
    else
      echo -e "%{%F{yellow}%} $branch"
    fi
  fi
}

# prompt
PROMPT='%{%F{blue}%}${PWD/#$HOME/~} $(git_prompt)
%{%f%}%% '
