#
# ~/.bash_profile
#
echo ".bash_profile"

tryMountEcryptfs() {
  if [ -r "${HOME}/.ecryptfs/auto-mount" ]; then
    # check if ${HOME} is already mounted 
    grep -qs "${HOME} ecryptfs" /proc/mounts 2>/dev/null
    if [ $? -ne 0 ]; then
      # now lets see if we really need to mount everything or just parts
      cat ${HOME}/.ecryptfs/Private.mnt 2>/dev/null | egrep "^${HOME}\$"
      [ $? -eq 0 ] && mount -i "${HOME}" ; cd "${HOME}"
    fi
  fi
  return 0
}

tryMountEcryptfs

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

_HISTFILELOCATION_=~/.bash_history.d
_HISTREDUCEINTERPRETER_=python2
_HISTREDUCELOCATION_=~/bin/reduceHist.py
_HISTFILEDEFAULT_=~/.bash_history
HISTTIMEFORMAT='%Y%m%d%H%M%S: '
HISTSIZE=50000
HISTCONTROL=ignoredups:erasedups # colon-separated list [ignorespace:ignoredups:erasedups]
TTY_NAME=`tty|sed -e 's|/dev/||' -e 's|/||'`

EDITOR=vim
export EDITOR

createHistory() {
  if [ -n "${_HISTFILELOCATION_}" -a ! -d "${_HISTFILELOCATION_}" ]; then
    mkdir -p "${_HISTFILELOCATION_}";
    [ -r "${_HISTFILEDEFAULT_}" ] && cp -p "${_HISTFILEDEFAULT_}" "${_HISTFILELOCATION_}"
  fi
  # save current history file, just in case...
  [ -r "${_HISTFILEDEFAULT_}" -a ! -h "${_HISTFILEDEFAULT_}" ] && mv -f "${_HISTFILEDEFAULT_}" "${_HISTFILEDEFAULT_}.bk"
  [ -h "${_HISTFILEDEFAULT_}" ] && rm "${_HISTFILEDEFAULT_}"
  # create a consolidated history file at default location
  eval ${_HISTREDUCEINTERPRETER_} ${_HISTREDUCELOCATION_} -o ${_HISTFILEDEFAULT_} `ls -rt ${_HISTFILELOCATION_}/.bash_history*` </dev/null
}

saveHistory() {
  HISTFILE=${_HISTFILELOCATION_}/.bash_history.`hostname`.${USER}.${TTY_NAME}.`date '+%Y%m%d%H%M%S'`
  history -a
}

fooSetupTraps() {
  trap saveHistory EXIT TERM INT
}

[ -r "${HOME}/.bash_profile.`hostname`" ] && . ${HOME}/.bash_profile.`hostname` || true

alias ls='ls --color=auto'

export HISTTIMEFORMAT HISTSIZE HISTCONTROL
createHistory
# append this sessions history to the HISTFILE
shopt -s histappend
fooSetupTraps

BOLD="1"
LIGHT="0"
BOLDRED="\[\e[${BOLD};31m\]"
BOLDGREEN="\[\e[${BOLD};32m\]"
BOLDYELLOW="\[\e[${BOLD};33m\]"
BOLDMAGENTA="\[\e[${BOLD};35m\]"
LIGHTRED="\[\e[${LIGHT};31m\]"
LIGHTYELLOW="\[\e[${LIGHT};33m\]"
LIGHTGRAY="\[\e[${LIGHT};37m\]"
LIGHTGREEN="\[\e[${LIGHT};32m\]"
COMMENTCOLOR="${BOLDYELLOW}"
DATECOLOR="${BOLDMAGENTA}"
USERCOLOR="\$(test `id -u` -eq 0 && echo \"${BOLDRED}\" || echo \"${BOLDGREEN}\")"
ATCOLOR="${LIGHTGRAY}"
HOSTCOLOR="${LIGHTGRAY}"
DIRCOLOR="${BOLDYELLOW}"
HISTORYCOLOR="${LIGHTYELLOW}"
PROMPTCOLOR="${USERCOLOR}"
NORMALCOLOR="\[\e[m\]"
SMILEY="${BOLDGREEN}:)"
FROWNY="${BOLDRED}:("
RVMCOLOR="${LIGHTGREEN}"

PS1FIRSTLINE="${COMMENTCOLOR}# ${HISTORYCOLOR}(\!/\#) ${DATECOLOR}\d \t ${USERCOLOR}\u${ATCOLOR}@${HOSTCOLOR}\h\$([ -n \"$rvm_path\" ] && echo \" ${RVMCOLOR}\$($rvm_path/bin/rvm-prompt) \"||true)\$(rc=\$?; [ \$rc -eq 0 ] && echo \"${SMILEY}\" || echo \"${FROWNY} ${LIGHTRED}(\$rc)\")${NORMALCOLOR}"
PS1SECONDLINE="${DIRCOLOR}\w ${PROMPTCOLOR}\\\$${NORMALCOLOR} "

if [ -n "${GITPS1STUFF}" ];then
  [ -n "${PROMPT_COMMAND}" ] && _PC_="\[\033]0;\u@\h \w\007\]"
  PROMPT_COMMAND='__git_ps1 "$_PC_${PS1FIRSTLINE}" "\\n${PS1SECONDLINE}";fooSetupTraps'
else
  PS1="${PS1FIRSTLINE}\\n${PS1SECONDLINE}"
fi

# prepend path with own binaries and scripts
for d in "${HOME}/bin" "${HOME}/scripts"; do
  if [ -d "${d}" ] ; then
    PATH="${d}:${PATH}"
  fi
done

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

