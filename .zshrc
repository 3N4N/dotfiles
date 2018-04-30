#           _
#   _______| |__
#  |_  / __|  _ \
#   / /\__ \ | | |
#  /___|___/_| |_|
#

# install oh-my-zsh
[ ! -d ~/.oh-my-zsh ] && git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
# install zsh-autosuggestion
autosuggestions="/home/enan/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ ! -f "$autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions
[ -f "$autosuggestions" ] && source "/home/enan/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# oh-my-zsh config
export ZSH=/home/enan/.oh-my-zsh
ZSH_THEME=""
DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
export UPDATE_ZSH_DAYS=13
source $ZSH/oh-my-zsh.sh
plugins=( git )

bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

# Personal customization
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

executables="/home/enan/Executables/bin"
[ -d "$executables" ] && [[ ":$PATH:" != *$executables* ]] && export PATH=$executables:${PATH}

# FZF settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 100% '

alias ls='ls -CF --color=none'
alias ll='ls -AlF'
alias la='ls -AF'
alias refresh='source ~/.zshrc'
alias screenfetch='screenfetch -t'
alias i3lock='sh ~/Git-repos/dotFiles/lock.sh'
alias emacs='emacs -nw'
alias v='nvim'
alias py2=python2
alias py3=python3
alias t='sh ~/Git-repos/dotFiles/tmux.sh'

# zsh prompt with git info
git_branch() {
  git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

git_status() {
  # + changes are staged and ready to commit
  # ! unstaged changes are present
  # ? untracked files are present
  # $ changes have been stashed
  # ^ local commits need to be pushed to the remote
  local state="$(git status --porcelain 2>/dev/null)"
  local output=''
  [[ -n $(egrep '^[MADRC]' <<<"$state") ]] && output="$output+"
  [[ -n $(egrep '^.[MD]' <<<"$state") ]] && output="$output!"
  [[ -n $(egrep '^\?\?' <<<"$state") ]] && output="$output?"
  [[ -n $(git stash list) ]] && output="$output$"
  [[ -n $(git log --branches --not --remotes) ]] && output="$output^"
  [[ -n $output ]] && output="$output"
  echo $output
}

git_prompt() {
  # First, get the branch name...
  local branch=$(git_branch)
  # Empty output? Then we're not in a Git repository, so bypass the rest
  # of the function, producing no output
  if [[ -n $branch ]]; then
    local state=$(git_status)
    # Now output the actual code to insert the branch and status
    echo -e " $branch$state"
  fi
}

PROMPT='%F{blue}[%n@%m] %F{magenta}%c%F{yellow}$(git_prompt) %F{blue}» %{$reset_color%}'
