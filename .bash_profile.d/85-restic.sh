_restic_vars=/keybase/private/marcelhuberfoo/backblaze_b2_id_key_restic.vars
_restic_exe=$(type -fP restic)
[ -n "$_restic_exe" -a -r $_restic_vars ] && {
  # create alias to print docker stats on running container names
  restic(){
    . $_restic_vars
    $_restic_exe -o b2.connections=10 "$@";
  }
}
