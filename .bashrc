#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -laF'
alias config='/usr/bin/git --git-dir=$HOME/.files/ --work-tree=$HOME'
PS1='[\u@\h \W]\$ '

eval $(opam env)
