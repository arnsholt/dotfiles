# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

. ~/.bash_completion
if [ -d ~/.bash_completion.d ]; then
    for f in ~/.bash_completion.d/*; do
        . $f
    done
fi

LOGONROOT=~/logon
if [ -f ${LOGONROOT}/dot.bashrc ]; then
    . ${LOGONROOT}/dot.bashrc
fi

eval `dircolors ~/.dircolors`

source ~/perl5/perlbrew/etc/bashrc

stty stop undef

export MANPATH=/usr/share/man:~/sw/share/man
export PKG_CONFIG_PATH=~/sw/lib/pkgconfig

# User specific aliases and functions
#export PATH=$HOME/sw/bin:~/sw/share/bin/x86_64-linux:~/logon/franz/linux.x86.64:$PATH
export PATH=$HOME/sw/bin:/ltg/tex/texlive/latest/bin/x86_64-linux:~/logon/franz/linux.x86.64:$PATH
export PERL5LIB=~/sw/lib/perl5/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/sw/lib

# XLE stuff:
export XLEPATH=~/sw/app/xle
export PATH=${XLEPATH}/bin:$PATH
export LD_LIBRARY_PATH=${XLEPATH}/lib:$LD_LIBRARY_PATH

alias alisp="rlwrap alisp"
alias vi=vim

export SQLHOST=mysql.ifi SQLUSER=arnskj SQLDB=arnskj
export PS1="[\u@\h \w]\$ "
export EDITOR=vim
export BROWSER=opera
