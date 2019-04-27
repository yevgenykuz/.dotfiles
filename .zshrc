# Path to your oh-my-zsh installation.
export ZSH="/home/yevgeny/.oh-my-zsh"

# Colourful terminal:
export TERM=xterm-256color

# Set vim as default:
export VISUAL=vim
export EDITOR="$VISUAL"

# Add local custom scripts to PATH:
export PATH=$PATH:~/custom_system_scripts

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# Theme:
POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel9k/powerlevel9k"

# Powerlevel9k theme configuration:
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(ssh root_indicator context dir_writable dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs background_jobs status time)

POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_ETC_ICON=''
POWERLEVEL9K_HIDE_BRANCH_ICON=true
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''

POWERLEVEL9K_SSH_BACKGROUND="none"
POWERLEVEL9K_SSH_FOREGROUND="green"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="none"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="red"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="none"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="yellow"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="none"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="none"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
POWERLEVEL9K_DIR_ETC_BACKGROUND="none"
POWERLEVEL9K_DIR_ETC_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_BACKGROUND="none"
POWERLEVEL9K_DIR_HOME_FOREGROUND="blue"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="none"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue"
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="none"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="green"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="none"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="none"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="red"
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='none'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='green'
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="none"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_TIME_BACKGROUND="none"
POWERLEVEL9K_TIME_FOREGROUND="white"

# Plugins:
plugins=(
  git
  command-not-found
  common-aliases
)

source $ZSH/oh-my-zsh.sh

# Aliases:
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias shutdown='sudo shutdown -h now'
alias python='python3'
alias tree='tree --charset=ASCII'

# thefuck:
eval $(thefuck --alias)
eval $(thefuck --alias FUCK)
