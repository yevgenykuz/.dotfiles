# Enable Powerlevel10k theme instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to  oh-my-zsh installation.
export ZSH="/home/yevgeny/.oh-my-zsh"

# Colourful terminal:
export TERM=xterm-256color

# Set vim as default:
export VISUAL=vim
export EDITOR="$VISUAL"

# Add local custom scripts to PATH:
export PATH=$PATH:~/custom_system_scripts

# Install Ruby Gems to ~/gems:
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# zsh options:
setopt AUTO_CD  # Perform cd <command> if command is a directory name and not an actual command
setopt NOMATCH  # Print an error if a pattern has no matches
setopt NOTIFY   # Report background jobs status immediately
setopt INC_APPEND_HISTORY   # Save commands to history list incrementally (and not when shell exists)
setopt SHARE_HISTORY  # Share command history list between shells
setopt HIST_EXPIRE_DUPS_FIRST   # Remove duplicates first from internal history list
setopt HIST_IGNORE_DUPS   # Don't save duplicated commands to the history list
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicates from the history list
setopt HIST_FIND_NO_DUPS    # Ignore duplicates when searching in the history list
setopt HIST_SAVE_NO_DUPS    # Don't write duplicates when saving history list
setopt HIST_REDUCE_BLANKS   # Trim extra blanks from commands in the history list
setopt HIST_VERIFY    # When selecting a line from history, load it to the buffer completely before execution
setopt INTERACTIVE_COMMENTS   # Allow comments even in interactive shells
setopt MAGIC_EQUAL_SUBST    # Assign multiple parameters, i.e, in "echo foo=~/bar:~/rod", replace both occurrences of ~

HISTFILE="$HOME/.zsh_history"   # History file location
HIST_STAMPS=mm/dd/yyyy    # History list time stamp format
HISTSIZE=5000   # Unsure no duplicates are saved - see HIST_EXPIRE_DUPS_FIRST
SAVEHIST=5000   # Maximum history list size

# oh-my-zsh options:
DISABLE_UPDATE_PROMPT=true    # Update oh-my-zsh automatically

# Theme:
POWERLEVEL9K_MODE='nerdfont-complete'
ZSH_THEME="powerlevel10k/powerlevel10k"

# Aliases:
alias l='ls -alCF'
alias ll='ls -alF --group-directories-first'
alias lo='ls -latr'
alias shutdown='sudo shutdown -h now'
alias python='python3'
alias tree='tree --charset=ASCII'
alias c='xclip'
alias v='xclip -o'
alias vimt='vim -p'
alias vimo='vim -o'

# oh-my-zsh Plugins:
plugins=(
  git
  command-not-found
  common-aliases
)

source $ZSH/oh-my-zsh.sh
# Load Powerlevel10k theme. Edit ~/.p10k.zsh to customize.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
