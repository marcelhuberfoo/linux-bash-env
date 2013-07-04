GIT_PS1_SHOWCOLORHINTS=         # not needed, managed below
GIT_PS1_SHOWDIRTYSTATE=1        # unstaged *, staged +
GIT_PS1_SHOWSTASHSTATE=1        # $
GIT_PS1_SHOWUNTRACKEDFILES=     # %
GIT_PS1_SHOWUPSTREAM=auto       # identical =, behind <, ahead >, diverged <>
GIT_PS1_DESCRIBE_STYLE=branch

NORMALCOLOR="${LIGHTGRAY}"
BLANK="\$(test -n \"\${__git__ps__info[dirty]}\${__git__ps__info[index]}\${__git__ps__info[stashed]}\${__git__ps__info[untracked]}\" && echo \" \")"
DOTS="\$(test -n \"\${__git__ps__info[branchstring]}\" && echo \"...\")"
LBRACKET="\$(test -n \"\${__git__ps__info[branchstring]}\" && echo \"${NORMALCOLOR}(\")"
RBRACKET="\$(test -n \"\${__git__ps__info[branchstring]}\" && echo \"${NORMALCOLOR})\")"
BRANCHCOLOR="\$(test \"\${__git__ps__info[detached]}\" = \"no\" && echo \"${NORMALCOLOR}\" || echo \"${BOLDRED}\")"
DIRTYCOLOR="\$(test -n \"\${__git__ps__info[dirty]}\" && echo \"${BOLDRED}\")"
INDEXCOLOR="\$(test \"\${__git__ps__info[index]}\" = \"+\" && echo \"${BOLDGREEN}\" || echo \"${NORMALCOLOR}\")"
STASHEDCOLOR="\$(test -n \"\${__git__ps__info[stashed]}\" && echo \"${BOLDGREEN}\")"
UNTRACKEDCOLOR="\$(test -n \"\${__git__ps__info[untracked]}\" && echo \"${LIGHTRED}\")"
REBASECOLOR="\$(test -n \"\${__git__ps__info[rebase]}\" && echo \"${BOLDRED}\")"
UPSTREAMCOLOR="\$(test \"\${__git__ps__info[upstream]}\" = \"=\" && echo \"${NORMALCOLOR}\" || echo \"${BOLDRED}\")"

__git__prompt__line="\$(echo \"${NORMALCOLOR}\")\$(__git_ps1 >/dev/null && echo \"${LBRACKET}${BRANCHCOLOR}\${__git__ps__info[branchstring]}${BLANK}${DIRTYCOLOR}\${__git__ps__info[dirty]}${INDEXCOLOR}\${__git__ps__info[index]}${STASHEDCOLOR}\${__git__ps__info[stashed]}${UNTRACKEDCOLOR}\${__git__ps__info[untracked]}${UPSTREAMCOLOR}\${__git__ps__info[upstream]}${RBRACKET}${NORMALCOLOR}\")"

unset NORMALCOLOR BLANK DOTS LBRACKET RBRACKET BRANCHCOLOR DIRTYCOLOR INDEXCOLOR STASHEDCOLOR UNTRACKEDCOLOR REBASECOLOR UPSTREAMCOLOR

set_prompt_line_at 75 "$__git__prompt__line"
