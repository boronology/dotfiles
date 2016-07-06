# Created by newuser for 5.2

alias ls='ls --color=auto'
alias ipython='ipython --pylab'
alias history="history -E 1"

# ---------- ZSH SETTINGS ----------
# basic settings
autoload -U compinit promptinit
compinit
promptinit

# This will set the default prompt to the walters theme
prompt walters

# zstyle ':completion:*' menu select
# setopt completealiases

# ignore case in completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# keybind
# array: key
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
# key[PageUp]=${terminfo[kpp]}
# key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
# [[ -n "${key[PageUp]}"  ]]  && bindkey  "${key[PageUp]}"    beginning-of-history
# [[ -n "${key[PageDown]}" ]] && bindkey  "${key[PageDown]}"  end-of-history

bindkey "^R" history-incremental-search-backward
