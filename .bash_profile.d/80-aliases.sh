alias pst='ps -FeH | less'
[ -n "$(type -fP docker)" ] && {
  # create alias to print docker stats on running container names
  alias topd >/dev/null 2>&1 || {
    alias topd="docker stats \$(docker ps --format '{{.Names}}')"
  }
}
