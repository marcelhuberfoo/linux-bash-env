# linux-bash-env

Generic bash initialization files with lossless history management

## basic setup

To not lose any of your shell history entries, some adjustments to your bash environment are needed. These settings are provided by a this repository given that you execute the following steps:

1.  Change back to your home directory and clone the repository

    ~~~{.bash}
cd
git clone --no-checkout https://github.com/marcelhuberfoo/linux-bash-env.git
git --git-dir=linux-bash-env/.git reset --hard
    ~~~

2.  Save the current history in a format readable by this extension

    ~~~{.bash}
HISTTIMEFORMAT='%Y%m%d%H%M%S: '
HISTCONTROL=ignorespace:ignoredups:erasedups
history -w
    ~~~

3.  Relogin
