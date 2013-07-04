# setup python virtualenv using virtualenvwrapper.sh
export WORKON_HOME=$HOME/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
_to_source=/usr/bin/virtualenvwrapper.sh
[ -s "$_to_source" ] && source "$_to_source"

