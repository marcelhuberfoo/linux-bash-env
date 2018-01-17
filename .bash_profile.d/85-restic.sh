_restic_vars=~/.restic-vars
_restic_exe=$(type -fP restic)
[ -n "$_restic_exe" -a -r $_restic_vars ] && {
  # create alias to print docker stats on running container names
  restic(){
    . $_restic_vars
    $_restic_exe -o b2.connections=$(nproc --ignore=2) "$@";
  }
}
