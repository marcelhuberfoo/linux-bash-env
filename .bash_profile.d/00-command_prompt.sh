unset __bash__prompt__line__
declare -a __bash__prompt__line__
__bash__prompt__line__=(
[10]="${BOLDYELLOW}# "
[20]="${LIGHTYELLOW}(\!/\#) "
[30]="${BOLDMAGENTA}\d \t "
[40]="${USERCOLOR}\u${LIGHTGRAY}@${LIGHTGRAY}\h "
[50]="\$([ -n \"\$rvm_path\" ] && echo \"${BOLDBLUE}rb:${LIGHTGREEN}\$(\$rvm_path/bin/rvm-prompt) \")"
[60]="\$([ -n \"\$VIRTUAL_ENV\" ] && echo \"${BOLDBLUE}py:${BOLDMAGENTA}\$(basename \"\${VIRTUAL_ENV}\")${LIGHTMAGENTA}(\$(python -V 2>&1 >/dev/null | cut -d' ' -f2)) \")"
[70]="\$([ \$rc -eq 0 ] && echo \"${SMILEY} \" || echo \"${FROWNY} ${LIGHTRED}(\$rc) \")"
[80]="\\n${BOLDYELLOW}\w "
[90]="${USERCOLOR}\\\$"
[1000]="${NORMALCOLOR} "
)

# $1: number
# $2: command
set_prompt_line_at() {
  declare -i index=$1
  __bash__prompt__line__[$index]="$2"
}

exec_prompt_command() {
  newps1=""
  for i in "${!__bash__prompt__line__[@]}"
  do
    newps1="$newps1${__bash__prompt__line__[$i]}"
  done
  echo "$newps1"
}

PROMPT_COMMAND='rc=$?; PS1=$(exec_prompt_command)'

