# prepend path with own binaries and scripts
for d in "${HOME}/bin" "${HOME}/scripts"; do
  if [ -d "${d}" ] ; then
    PATH="${d}:${PATH}"
  fi
done
