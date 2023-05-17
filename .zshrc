# Enable Powerlevel10k theme instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Colourful terminal:
export TERM=xterm-256color
# Force UTF-8
export LC_CTYPE=en_US.UTF-8
# Set vim as default:
export VISUAL=vim
export EDITOR="$VISUAL"

# Add local custom scripts to PATH:
export PATH="$HOME/.dotfiles/scripts:$PATH"

# Install Ruby Gems to ~/gems:
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# Add Go to PATH:
export GOPATH=$HOME/go
if [[ "$(uname -s)" == *[Dd]arwin* ]] 2>/dev/null; then # Darwin (MacOS) - with brew
  export GOROOT="$(brew --prefix golang)/libexec"
else # Linux
  export GOROOT=/usr/local/go
fi
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

# zsh options:
# Perform cd <command> if command is a directory name and not an actual command
setopt AUTO_CD
# Print an error if a pattern has no matches
setopt NOMATCH
# Report background jobs status immediately
setopt NOTIFY
# Save commands to history list incrementally (and not when shell exists)
setopt INC_APPEND_HISTORY
# Share command history list between shells
setopt SHARE_HISTORY
# Remove duplicates first from internal history list
setopt HIST_EXPIRE_DUPS_FIRST
# Don't save duplicated commands to the history list
setopt HIST_IGNORE_DUPS
# Remove older duplicates from the history list
setopt HIST_IGNORE_ALL_DUPS
# Ignore duplicates when searching in the history list
setopt HIST_FIND_NO_DUPS
# Don't write duplicates when saving history list
setopt HIST_SAVE_NO_DUPS
# Trim extra blanks from commands in the history list
setopt HIST_REDUCE_BLANKS
# When selecting a line from history, load it to the buffer completely before execution
setopt HIST_VERIFY
# Allow comments even in interactive shells
setopt INTERACTIVE_COMMENTS
# Assign multiple parameters, i.e, in "echo foo=~/bar:~/rod", replace both occurrences of ~
setopt MAGIC_EQUAL_SUBST

HISTFILE="$HOME/.zsh_history"   # History file location
HIST_STAMPS=mm/dd/yyyy    # History list time stamp format
HISTSIZE=5000   # Unsure no duplicates are saved - see HIST_EXPIRE_DUPS_FIRST
SAVEHIST=5000   # Maximum history list size

# oh-my-zsh options:
DISABLE_UPDATE_PROMPT=true    # Update oh-my-zsh automatically

# Theme:
POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel10k/powerlevel10k"

# oh-my-zsh Plugins:
plugins=(
  zsh-syntax-highlighting
  command-not-found
  history-substring-search
  alias-finder
  brew
  git
  git-extras
  fd
  ripgrep
  fzf
  thefuck
  sdk
  mvn
  gradle
  nmap
  sublime
  python
  pip
  virtualenv
  golang
  docker
  docker-compose
  kubectl
)

# oh-my-zsh plugin configuration must be set before sourcing oh-my-zsh-sh

# Load oh-my-zsh before custom aliases
source $ZSH/oh-my-zsh.sh

# Aliases:
if [[ "$(uname -s)" == *[Dd]arwin* ]] 2>/dev/null; then # Darwin (MacOS)
  alias ll='gls -lAh --group-directories-first --color=auto'
  alias p='ps -ax'
else # Linux
  alias ll='ls -lAh --group-directories-first'
  alias p='ps -auxf'
  alias bat='batcat'
  alias fd='fdfind'
  alias diff='diff --color=auto'
  alias c='xclip -sel primary -f | xclip -sel clipboard' # usage: echo "COPY_THIS" | c
  alias v='xclip -o -sel clipboard'
  alias shutdown='sudo shutdown -h now'
fi
alias cls='clear'
alias python='python3'
alias pip='pip3'
alias l='ls -AlCh'
alias lo='ls -lAtrh'
alias tree='tree -aC -I .git --dirsfirst'
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias rg='rg --smart-case'
alias t='tail -f'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias dud='du -d 1 -h'
alias help='man'
alias findd='find . -type d -name'
alias findf='find . -type f -name'
alias h='history'
alias hgrep='fc -El 0 | grep'
alias gdo='git diff @{upstream}'
# Delete local branches that are no longer on remote and were merged to current branch
alias gbdu="git fetch -p ; git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d 2>/dev/null"
# Delete local branches that are no longer on remote even if not merged to current branch
alias gbdu!="git fetch -p ; git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -D 2>/dev/null"

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts \
'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Open browser on urls
if [[ -n "$BROWSER" ]]; then
  _browser_fts=(htm html de org net com at cx nl se dk)
  for ft in $_browser_fts; do alias -s $ft=$BROWSER; done
fi

# Load Powerlevel10k theme. Edit ~/.p10k.zsh to customize.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Attach to tmux if zsh was not started from tmux itself nor from JetBrains tools
# Attaching will work because tmux server is started on boot by the 'tmux-continuum' tmux plugin
if [[ "$TMUX" = "" && "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ]]; then
  tmux -u attach;
fi

# Source NVM
export NVM_DIR="$HOME/.nvm"
# These are the Node versions installed by nvm. Add the latest one to the PATH by default.
node_versions=("$NVM_DIR"/versions/node/*)
if [ ${#node_versions[@]} -ne 0 ]; then
    PATH="$PATH:${node_versions[-1]}/bin"
fi
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    # Shim out `nvm` with a function that loads the real `nvm` on first use.
    # Since we already updated our PATH earlier, we don't need to actually load nvm
    # to get "node" and related binaries to work.
    nvm() {
        source "$NVM_DIR/nvm.sh"
        nvm "$@"
    }
fi
if [[ -s "$NVM_DIR/bash_completion" ]]; then
    source "$NVM_DIR/bash_completion"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh" || true
