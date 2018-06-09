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

## oh-my-zsh config

# general
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

# key bindings
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search

## personal customization

# add ~/Executables/bin to path
executables="~/Executables/bin"
[ -d "$executables" ] && [[ ":$PATH:" != *$executables* ]] && \
export PATH=$executables:${PATH}

# FZF settings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 100% '

# don't show colors in tab-completion
zstyle ':completion:*' list-colors

# aliases
alias ls='ls -CF --color=none'
alias ll='ls -AlF'
alias la='ls -AF'
alias tree='tree -F'
alias refresh='source ~/.zshrc'
alias screenfetch='screenfetch -t'
alias i3lock='sh ~/projects/dotFiles/lock.sh'
alias emacs='emacs -nw'
alias vi='nvim'
alias py2=python2
alias py3=python3
alias t='sh ~/projects/dotFiles/tmux.sh'
alias now="echo -n 'date: '; echo $(date "+%A, %B %d");\
  echo -n 'time: '; echo $(date "+%H:%M")"

# zsh prompt with git info
git_branch() {
  git branch --no-color 2>/dev/null | \
  sed -e '/^[^*]/d' -e 's/* \(\|(HEAD detached \)\([^)]*\)\(\|)\)/\2/'
}
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

# zsh prompt
setopt PROMPT_SUBST
PROMPT='%{%F{red}%}[%n%{%f%}@%{%F{red}%}%m]%{%F{blue}%}%c%{%f%}%% '
RPS1='$(git_prompt)'
