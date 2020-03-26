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


# oh-my-zsh Plugins:
plugins=(
  git
  command-not-found
)

# Load oh-my-zsh before custom aliases
source $ZSH/oh-my-zsh.sh

# Aliases:
alias l='ls -AlCh'
alias ll='ls -lAh --group-directories-first'
alias lo='ls -lAtrh'
alias shutdown='sudo shutdown -h now'
alias python='python3'
alias tree='tree --charset=ASCII'
alias c='xclip'
alias v='xclip -o'
alias vimt='vim -p'
alias vimo='vim -o'
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias t='tail -f'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias p='ps -auxf'
alias dud='du -d 1 -h'
alias help='man'
alias fd='find . -type d -name'
alias ff='find . -type f -name'
alias h='history'
alias hgrep='fc -El 0 | grep'
alias gst='git status'
alias gss='git status -s'
alias ga='git add'
alias gaa='git add --all'
alias gcmsg='git commit -m'
alias gcsm='git commit -s -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gb='git branch'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gfa='git fetch --all --prune'
alias gl='git pull'
alias ggum='git pull --rebase origin master'
alias gm='git merge'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'
alias gma='git merge --abort'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias gsta='git stash push'
alias gstall='git stash --all'
alias gstaa='git stash apply'
alias gstp='git stash pop'
alias gstl='git stash list'
alias gsts='git stash show --text'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gts='git tag -s'
alias gtv='git tag \| sort -V'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v \| grep "^[[:lower:]]"'
alias gd='git diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'
alias gfg='git ls-files \| grep'
alias glog='git log --oneline --decorate --graph'
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"
alias gbl='git blame -b -w'
alias grhh='git reset --hard'
alias gpristine='git reset --hard && git clean -dfx'
alias gcl='git clone --recurse-submodules'
alias gcf='git config --list'
alias workrdp='xfreerdp /multimon /d:DM /u:YevgenyK /v:192.168.14.66 /sec:tls /bpp:32 /audio-mode:1 +fonts -themes -wallpaper'
alias workrdpsm='xfreerdp /f /d:DM /u:YevgenyK /v:192.168.14.66 /sec:tls /bpp:32 /audio-mode:1 +fonts -themes -wallpaper'

# Make zsh know about hosts already accessed by SSH
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Open browser on urls
if [[ -n "$BROWSER" ]]; then
  _browser_fts=(htm html de org net com at cx nl se dk)
  for ft in $_browser_fts; do alias -s $ft=$BROWSER; done
fi

# Load Powerlevel10k theme. Edit ~/.p10k.zsh to customize.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
