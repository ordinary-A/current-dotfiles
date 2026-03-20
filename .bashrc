#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
source <(kitty + complete setup bash)
PS1='\[\e[38;2;23;147;209m\]'$'\uf303'' \[\e[0;37m\]\w \[\e[0;32m\]> \[\e[0m\]'
