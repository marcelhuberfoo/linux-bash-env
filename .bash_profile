#
# ~/.bash_profile
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

EDITOR=vim
export EDITOR
alias ls='ls --color=auto'
export FORCE_GPG_AGENT=y

[ -r "${HOME}/.bash_profile.`hostname`" ] && . ${HOME}/.bash_profile.`hostname`

for f in ${HOME}/.bash_profile.d/*.sh; do
  [ -r "$f" ] && . "$f"
done
unset f

