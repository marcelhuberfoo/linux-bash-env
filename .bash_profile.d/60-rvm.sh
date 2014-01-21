# Load RVM into a shell session *as a function*
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
for _to_source in "$HOME/.rvm/scripts/rvm" "$HOME/.rvm/scripts/completion"; do
  [ -s "$_to_source" ] && source "$_to_source"
done
