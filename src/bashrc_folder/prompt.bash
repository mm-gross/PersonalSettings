#-------------------------------------------------------------
# Shell Prompt - for many examples, see:
#       http://www.debian-administration.org/articles/205
#       http://www.askapache.com/linux/bash-power-prompt.html
#       http://tldp.org/HOWTO/Bash-Prompt-HOWTO
#       https://github.com/nojhan/liquidprompt
#-------------------------------------------------------------

# Test user type:
if [[ ${USER} == "root" ]]; then
    SU=${Red}           # User is root.
elif [[ ${USER} != $(logname) ]]; then
    SU=${BRed}          # User is not login user.
else
    SU=${NC}         # User is normal (well ... most of us are).
fi

# Returns a color according to running/suspended jobs.
function job_color()
{
    if [ $(jobs -s | wc -l) -gt "0" ]; then
        echo -en ${BRed}
    elif [ $(jobs -r | wc -l) -gt "0" ] ; then
        echo -en ${BCyan}
    else
        echo -en ${Green}
    fi
}

# Adds some text in the terminal frame (if applicable).


if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"


#__git_branch=$(__git_ps1)
#__git_branch_color=${Green}

__git_prompt() {
    __git_branch=$(__git_ps1)
}
#    __git_branch_color=${Green}
__git_branch_color() {
    __git_branch=$(__git_ps1)
    if [[ "${__git_branch}" =~ "*" ]]; then     # if repository is dirty
          echo -en ${Red}
    else
        echo -en ${Green}
    fi
    #export ${__git_branch_color}
}
#}

# Now we construct the prompt.
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }history -a;__git_prompt"
case ${TERM} in
  *term* | rxvt | linux)
        # User@Host (with connection type info):
        PS1="\u\[${NC}\] "
        # PWD (with 'disk space' info):
        PS1=${PS1}"\[${Cyan}\][\W]\[${NC}\] "
        # git prompt
        PS1=${PS1}"\[\$(__git_branch_color)\]\${__git_branch} "
        # Prompt (with 'job' info):
        PS1=${PS1}"\[\$(job_color)\]\$\[${NC}\] "
        # Set title of current xterm:
#        PS1=${PS1}"\[\e]0;[\u@\h] \w\a\]"
        ;;
    *)
        PS1="(\A \u@\h \W) > " # --> PS1="(\A \u@\h \w) > "
                               # --> Shows full pathname of current dir.
        ;;
esac
