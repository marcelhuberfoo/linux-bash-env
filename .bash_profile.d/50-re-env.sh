# Copyright (c) 2012 Dusty Phillips <dusty@linux.ca

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# put this in your bashrc

function v {
  # activate a virtualenv
  # usage: v
  #   activate the virtualenv named venv
  # usage: v venvname
  #   activate the virtualenv named venvname
  name="${1:-.venv}"
  # usually I do not want the script go further up than my home dir
  stopdir="$(readlink -f ${HOME:-/})"
  activateloc="$name/bin/activate"
  olddir="$(pwd)"
  deactivate &>/dev/null
  cwd="$(pwd)"
  while true
  do
    cd "$cwd"
    if [ -r "$activateloc" ]  ; then
      echo "activating \"${cwd}/${name}\""
      source "$activateloc"
      break
    fi
    if [ "$cwd" == "$stopdir" ] ; then
      echo "no virtual env ${name} found up to $stopdir"
      break
    fi
    cwd="$(readlink -f $(dirname "${cwd}"))"
  done
  cd "$olddir"
}
