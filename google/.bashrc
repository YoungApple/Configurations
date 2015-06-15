# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # WARNING: enabling this can cause multi-second delays due to NFS latency
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -alFh'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

export P4CONFIG=.p4config
export P4DIFF="/home/build/google3/devtools/scripts/p4diff -w"
export P4MERGE=/home/build/eng/perforce/mergep4.tcl
export EDITOR='gvim -f'
export PATH=$PATH:/google/data/ro/projects/goops

# Cert for LOAS certs
CERTS=$(prodcertstatus 2>&1)
NO_LOAS='No valid LOAS certs'
if [[ $CERTS == $NO_LOAS ]]
then
  prodaccess -g
else
  echo $CERTS
fi

source /home/build/nonconf/google3/java/com/google/ads/publisher/scripts/xfp/bashrc.sh

alias mem-cleanup='sync; echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias xfp-alias='cd /home/build/nonconf/google3/java/com/google/ads/publisher/scripts/xfp'

alias workl='cd /usr/local/google/yangshuguo/git-clients'

alias p0_db='/google/data/ro/projects/production/mysql/python/sql.par mystubby:/bns/ic/borg/ic/bns/ads-database-dedicated/adsdb-b-21622909.mysql.shard-#.mysql/0:$USER:pfile=${HOME}/.dbpw-readonly-${USER}:ads#'
alias db_start='/usr/local/google/mysql_data/startup.sh'
alias db_connect='/usr/local/google/mysql_mpm/bin/mysql -uroot -padsgoogle -S /usr/local/google/mysql_data/mysql.sock -A'

# gwtsales develop aliases.
alias blaze-test-sales='blaze test javatests/com/google/ads/gfp/efe/plugins/gwtsales:all'
alias blaze-build-sales='blaze build --embed_changelist=none java/com/google/ads/servers/gfp/GfpSalesFrontEnd_unfiltered'
alias start_local_indexer='chmod +x java/com/google/ads/servers/gfp/search/run-search-indexer && java/com/google/ads/servers/gfp/search/run-search-indexer --database=local --xsm_search'
alias bt-scan-devel='bt scan /bigtable/srv-ie/gfp-fe-sales-search-qa.v7.475.metadata > temp.log'

alias pa='prodaccess --china_corp_proxy=http://chinaproxy.corp.google.com:3128'
alias f1-sql='/google/data/ro/projects/storage/f1/tools/f1-sql'
alias pa_devel='prodaccess --use_dev_instance'

# git commits aliases. All start with 'g'
alias ga='git commit -a -d \"local commit\"'
alias gc='git checkout'
alias gb='git branch'
alias gs='git status'
alias gd='git diff'
alias gdf='git diff --name-only'

# git5 commands aliases. All start with 'g5'
alias g5lint='g5df | xargs git5 lint'
alias g5lint_fix='/google/src/head/depot/google3/tools/java/remove_unused_imports.py -g --fix && /google/src/head/depot/google3/tools/java/sort_java_imports.py -g && buildifier -a -v'
alias g5sort='g5df | xargs sort_java_import'
alias g5e_all="git5 export --sq --tap-options=email,detach --tap-project=xfp_frontend,xfp_frontend.xsm"
alias g5e_rerun="git5 export --sq --tap-options=email,detach --tap-options=rerun=last --tap-project=xfp_frontend,xfp_frontend.xsm"

alias g5sync="git5 sync --tap-project=xfp-frontend --sync-at=green"
alias g5d='git5 diff'
alias g5df="git5 diff --name-only"
alias g5de='git5 diff --exported'
alias g5s_all='git5 submit --submit-queue --tap-project=xfp_frontend,xfp_frontend.xsm'
alias g5s_rerun='git5 submit --submit-queue --tap-options=rerun=last --tap-project=xfp_frontend,xfp_frontend.xsm'
alias g5p='git5 pending'

alias gce='git commit -a --amend -C HEAD && git5 export'
alias grscr='git co zero-base && git5 sync && git co - && git rb -i zero-base'

alias idea13='/usr/local/google/yangshuguo/softwares/idea-ultimate/bin/idea.sh &'
alias rm_orig='find -name "*.orig" | xargs rm'
alias google_guest='echo pUp3EkaP'

export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

