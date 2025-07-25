# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\
\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
      PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" \
"$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# Curl cht.sh for a quick terminal based cheat-sheet
cht() {
    curl -s "cht.sh/$*" | bat
}
# Clear AWS env vars when running AWS SSO commands
aws() {
  if [[ "$1 $2" == "sso login" ]]; then
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    unset AWS_REGION
  fi
  command aws "$@"
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Set theme for batcat
export BAT_THEME="gruvbox-dark"

# Terminal colors:
export TERM=xterm-256color
export PS1="\[\e[00;32m\]\u\[\e[0m\]\[\e[00;37m\]@\h:\
\[\e[0m\]\[\e[00;36m\][\w]\[\e[0m\]\[\e[00;37m\]\\$\[\e[0m\]"

# Add local custom scripts to PATH:
export PATH="$HOME/.dotfiles/scripts:$PATH"

# Install Ruby Gems to ~/gems
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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Loads nvm bash_completion
