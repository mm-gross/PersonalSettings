# ======================================================================== #
#
# Author: Marc Groß
# E-Mail: marc@marc-gross.de
#
#  Attributions:
#  This is based on a bashrc written by Emmanuel Rouart. I took Emmanuels
#  file and modified it to my needs. You can find the original at
#  https://tldp.org/LDP/abs/html/sample-bashrc.html
#
#  This is a peronalized $HOME/.bashrc FILE for bash-4.0 (or later) on 
#  Mac OS. On Mac OS, usually bash 3.2 is installed, I recommend installing
#  the newest version manually or from homebrew or macports.
#
#
#  This file is normally read by interactive shells only. Here is the place
#  to define your aliases, functions and other interactive features like 
#  your prompt.
#
#  The choice of colors was done for a shell with a dark background 
#  (white on black), and this is usually also suited for pure text-mode 
#  consoles (no X server available). If you use a white background, you'll 
#  have to do some other choices for readability.
#
# ======================================================================== #


#---------------------------------------------------------------------------
# If not running interactively, don't do anything
#---------------------------------------------------------------------------

[ -z "$PS1" ] && return
set +a


#---------------------------------------------------------------------------
# Source global definitions (if any)
#---------------------------------------------------------------------------

if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi


#---------------------------------------------------------------------------
# Some settings
#
# These option can be defined:
#
# chatty - Enables some informational output on startup
# noclobber - Prevent output redirection from overwriting existing files.
# notify - Report the status of terminated background jobs immediately
# easylogout - Enable logout with eof (Crtl+D)
#---------------------------------------------------------------------------

declare -A _BASHRC_OPTION


_BASHRC_OPTION["chatty"]=true
_BASHRC_OPTION["noclobber"]=true
_BASHRC_OPTION["notify"]=true
_BASHRC_OPTION["easylogout"]=true



#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.


if [ -f ~/.bashrc_folder/colors.bash ]; then
    . ~/.bashrc_folder/colors.bash
fi

if [ -f ~/.bashrc_folder/greeting.bash ]; then
    . ~/.bashrc_folder/greeting.bash
fi

if [ -f ~/.bashrc_folder/options.bash ]; then
    . ~/.bashrc_folder/options.bash
fi

if [ -f ~/.bashrc_folder/prompt.bash ]; then
    . ~/.bashrc_folder/prompt.bash
fi

function _exit()              # Function to run upon exit of shell.
{
    echo -e "${BRed}Hasta la vista, baby${NC}"
}
trap _exit EXIT


export TIMEFORMAT=$'\nreal %3R\tuser %3U\tsys %3S\tpcpu %P\n'
export HISTIGNORE="&:bg:fg:ll:h"
export HISTTIMEFORMAT="$(echo -e ${BCyan})[%d/%m %H:%M:%S]$(echo -e ${NC}) "
export HISTCONTROL=ignoredups
export HOSTFILE=$HOME/.hosts    # Put a list of remote hosts in ~/.hosts
export PATH="/opt/homebrew/bin:/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.1.0/bin:$PATH"

#============================================================
#
#  ALIASES AND FUNCTIONS
#
#  Arguably, some functions defined here are quite big.
#  If you want to make this file smaller, these functions can
#  be converted into scripts and removed from here.
#
#============================================================

#-------------------
# Personal Aliases
#-------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'


alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------

# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h -G'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -a'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...


#-------------------------------------------------------------
# Tailoring 'less'
#-------------------------------------------------------------

alias more='less'
export PAGER=less
export LESSCHARSET='latin1'
export LESSOPEN='|/usr/bin/lesspipe.sh %s 2>&-'
                # Use this if lesspipe.sh exists.
export LESS='-i -N -w  -z-4 -g -e -M -X -F -r -P%t?f%f \
:stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

# LESS man page colors (makes Man pages more readable).
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


#-------------------------------------------------------------
# Spelling typos - highly personnal and keyboard-dependent :-)
#-------------------------------------------------------------

alias xs='cd'
alias vf='cd'
alias kk='ll'


#-------------------------------------------------------------
# A few fun ones
#-------------------------------------------------------------

# Adds some text in the terminal frame (if applicable).

function xtitle()
{
    case "$TERM" in
    *term* | rxvt)
        echo -en  "\e]0;$*\a" ;;
    *)  ;;
    esac
}

# Aliases that use xtitle
alias top='xtitle Processes on $HOST && top ; xtitle'
alias make='xtitle Making $(basename $PWD) ; make ; xtitle'

# .. and functions
function man()
{
    local width
    width=$((COLUMNS-8))
    echo $width
    for i ; do
        xtitle The $(basename $1|tr -d .[:digit:]) manual
        MANWIDTH=$width /usr/bin/man "$i"
        #command man -a "$i"
        xtitle
    done
}


#-------------------------------------------------------------
# Starting SSH-Agent and adding keys on opening bash
#-------------------------------------------------------------

SSH_ENV="$HOME/.ssh/env"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' >| "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
         start_agent;
     }
else
     start_agent;
fi
/usr/bin/ssh-add --apple-use-keychain $HOME/.ssh/id_github; # Up to Big Sur
#/usr/bin/ssh-add --apple-use-keychain  $HOME/.ssh/id_github; # From Monterey onwards
     
# I see room for improvements, i.e. detecting the correct syntax automatically, 
# adding all id's automatically or letting the user configure here,
# which identities to add and of course checking if an id is already
# present before adding it again


#-------------------------------------------------------------
# File & strings related functions:
#-------------------------------------------------------------


# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' \
-exec ${2:-file} {} \;  ; }

# Swap 2 filenames around, if they exist (from Uzi's bashrc).
function swap()
{ 
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}


#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------


function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }


#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------

function repeat()       # Repeat n times command.
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}


function ask()          # See 'killps' for example of use.
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}



#=========================================================================
#
#  PROGRAMMABLE COMPLETION SECTION
#  Most are taken from the bash 2.05 documentation and from Ian McDonald's
# 'Bash completion' package (http://www.caliban.org/bash/#completion)
#  You will in fact need bash more recent then 3.0 for some features.
#
#  Note that most linux distributions now provide many completions
# 'out of the box' - however, you might need to make your own one day,
#  so I kept those here as examples.
#=========================================================================

if [ "${BASH_VERSION%.*}" \< "3.0" ]; then
    echo "You will need to upgrade to version 3.0 for full \
          programmable completion features"
    return
fi


if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
      . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash   # --> Read /etc/bashrc, if present.
fi

shopt -s extglob        # Necessary.

complete -A hostname   rsh rcp telnet rlogin ftp ping disk
complete -A export     printenv
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger

complete -A helptopic  help     # Currently same as builtins.
complete -A shopt      shopt
complete -A stopped -P '%' bg
complete -A job -P '%'     fg jobs disown

complete -A directory  mkdir rmdir
complete -A directory   -o default cd

# Compression
complete -f -o default -X '*.+(zip|ZIP)'  zip
complete -f -o default -X '!*.+(zip|ZIP)' unzip
complete -f -o default -X '*.+(z|Z)'      compress
complete -f -o default -X '!*.+(z|Z)'     uncompress
complete -f -o default -X '*.+(gz|GZ)'    gzip
complete -f -o default -X '!*.+(gz|GZ)'   gunzip
complete -f -o default -X '*.+(bz2|BZ2)'  bzip2
complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2
complete -f -o default -X '!*.+(zip|ZIP|z|Z|gz|GZ|bz2|BZ2)' extract


# Documents - Postscript,pdf,dvi.....
complete -f -o default -X '!*.+(ps|PS)'  gs ghostview ps2pdf ps2ascii
complete -f -o default -X \
'!*.+(dvi|DVI)' dvips dvipdf xdvi dviselect dvitype
complete -f -o default -X '!*.+(pdf|PDF)' acroread pdf2ps
complete -f -o default -X '!*.tex' tex latex slitex

complete -f -o default -X '!*.pl'  perl perl5


#  This is a 'universal' completion function - it works when commands have
#+ a so-called 'long options' mode , ie: 'ls --all' instead of 'ls -a'
#  Needs the '-o' option of grep
#+ (try the commented-out version if not available).

#  First, remove '=' from completion word separators
#+ (this will allow completions like 'ls --color=auto' to work correctly).

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}


_get_longopts()
{
  #$1 --help | sed  -e '/--/!d' -e 's/.*--\([^[:space:].,]*\).*/--\1/'| \
  #grep ^"$2" |sort -u ;
    $1 --help | grep -o -e "--[^[:space:].,]*" | grep -e "$2" |sort -u
}

_longopts()
{
    local cur
    cur=${COMP_WORDS[COMP_CWORD]}

    case "${cur:-*}" in
       -*)      ;;
        *)      return ;;
    esac

    case "$1" in
       \~*)     eval cmd="$1" ;;
         *)     cmd="$1" ;;
    esac
    COMPREPLY=( $(_get_longopts ${1} ${cur} ) )
}
complete  -o default -F _longopts configure bash
complete  -o default -F _longopts wget id info a2ps ls recode

_tar()
{
    local cur ext regex tar untar

    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    # If we want an option, return the possible long options.
    case "$cur" in
        -*)     COMPREPLY=( $(_get_longopts $1 $cur ) ); return 0;;
    esac

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $( compgen -W 'c t x u r d A' -- $cur ) )
        return 0
    fi

    case "${COMP_WORDS[1]}" in
        ?(-)c*f)
            COMPREPLY=( $( compgen -f $cur ) )
            return 0
            ;;
        +([^Izjy])f)
            ext='tar'
            regex=$ext
            ;;
        *z*f)
            ext='tar.gz'
            regex='t\(ar\.\)\(gz\|Z\)'
            ;;
        *[Ijy]*f)
            ext='t?(ar.)bz?(2)'
            regex='t\(ar\.\)bz2\?'
            ;;
        *)
            COMPREPLY=( $( compgen -f $cur ) )
            return 0
            ;;

    esac

    if [[ "$COMP_LINE" == tar*.$ext' '* ]]; then
        # Complete on files in tar file.
        #
        # Get name of tar file from command line.
        tar=$( echo "$COMP_LINE" | \
                        sed -e 's|^.* \([^ ]*'$regex'\) .*$|\1|' )
        # Devise how to untar and list it.
        untar=t${COMP_WORDS[1]//[^Izjyf]/}

        COMPREPLY=( $( compgen -W "$( echo $( tar $untar $tar \
                                2>/dev/null ) )" -- "$cur" ) )
        return 0

    else
        # File completion on relevant files.
        COMPREPLY=( $( compgen -G $cur\*.$ext ) )

    fi

    return 0

}

complete -F _tar -o default tar

_make()
{
    local mdef makef makef_dir="." makef_inc gcmd cur prev i;
    COMPREPLY=();
    cur=${COMP_WORDS[COMP_CWORD]};
    prev=${COMP_WORDS[COMP_CWORD-1]};
    case "$prev" in
        -*f)
            COMPREPLY=($(compgen -f $cur ));
            return 0
            ;;
    esac;
    case "$cur" in
        -*)
            COMPREPLY=($(_get_longopts $1 $cur ));
            return 0
            ;;
    esac;

    # ... make reads
    #          GNUmakefile,
    #     then makefile
    #     then Makefile ...
    if [ -f ${makef_dir}/GNUmakefile ]; then
        makef=${makef_dir}/GNUmakefile
    elif [ -f ${makef_dir}/makefile ]; then
        makef=${makef_dir}/makefile
    elif [ -f ${makef_dir}/Makefile ]; then
        makef=${makef_dir}/Makefile
    else
       makef=${makef_dir}/*.mk         # Local convention.
    fi


    #  Before we scan for targets, see if a Makefile name was
    #+ specified with -f.
    for (( i=0; i < ${#COMP_WORDS[@]}; i++ )); do
        if [[ ${COMP_WORDS[i]} == -f ]]; then
            # eval for tilde expansion
            eval makef=${COMP_WORDS[i+1]}
            break
        fi
    done
    [ ! -f $makef ] && return 0

    # Deal with included Makefiles.
    makef_inc=$( grep -E '^-?include' $makef |
                 sed -e "s,^.* ,"$makef_dir"/," )
    for file in $makef_inc; do
        [ -f $file ] && makef="$makef $file"
    done


    #  If we have a partial word to complete, restrict completions
    #+ to matches of that word.
    if [ -n "$cur" ]; then gcmd='grep "^$cur"' ; else gcmd=cat ; fi

    COMPREPLY=( $( awk -F':' '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ \
                               {split($1,A,/ /);for(i in A)print A[i]}' \
                                $makef 2>/dev/null | eval $gcmd  ))

}

complete -F _make -X '+($*|*.[cho])' make gmake pmake




_killall()
{
    local cur prev
    COMPREPLY=()
    cur=${COMP_WORDS[COMP_CWORD]}

    #  Get a list of processes
    #+ (the first sed evaluation
    #+ takes care of swapped out processes, the second
    #+ takes care of getting the basename of the process).
    COMPREPLY=( $( ps -u $USER -o comm  | \
        sed -e '1,1d' -e 's#[]\[]##g' -e 's#^.*/##'| \
        awk '{if ($0 ~ /^'$cur'/) print $0}' ))

    return 0
}

complete -F _killall killall killps

