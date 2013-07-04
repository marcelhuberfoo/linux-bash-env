_HISTFILELOCATION_=~/.bash_history.d
_HISTREDUCEINTERPRETER_=python2
_HISTREDUCELOCATION_=~/bin/reduceHist.py
_HISTFILEDEFAULT_=~/.bash_history
HISTTIMEFORMAT='%Y%m%d%H%M%S: '
HISTSIZE=50000
HISTCONTROL=ignoredups:erasedups # colon-separated list [ignorespace:ignoredups:erasedups]
TTY_NAME=`tty|sed -e 's|/dev/||' -e 's|/||'`

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

export HISTTIMEFORMAT HISTSIZE HISTCONTROL
createHistory
# append this sessions history to the HISTFILE
shopt -s histappend
fooSetupTraps

