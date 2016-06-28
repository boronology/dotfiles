# Created by newuser for 5.2

# ---------- FROM BASH.RC ----------
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
export PATH=$PATH:/home/boronji/.gem/ruby/2.3.0/bin
alias ipython='ipython --pylab'
export GOPATH=/home/boronji/.gopath/bin

# Added by Canopy installer on 2015-12-07
# VIRTUAL_ENV_DISABLE_PROMPT can be set to '' to make bashprompt show that Canopy is active, otherwise 1
VIRTUAL_ENV_DISABLE_PROMPT=1 source '/home/boronji/Enthought/Canopy_64bit/User/bin/activate'

# ---------- ZSH SETTINGS ----------
# basic settings
autoload -U compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
prompt walters

# zstyle ':completion:*' menu select
# setopt completealiases

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=1000000
alias history="history -E 1"

