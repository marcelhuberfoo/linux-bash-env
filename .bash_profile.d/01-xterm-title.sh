terminal_title="\[\033]0;\u@\h \w\007\]"
[ -z "${TERM##xterm*}" ] && set_prompt_line_at 0 "$terminal_title"
