#set -o nounset     # These  two options are useful for debugging.
#set -o xtrace
alias debug="set -o nounset; set -o xtrace"

ulimit -S -c 0      # Don't want coredumps.

if [ ${_BASHRC_OPTION["notify"]} = true ]; then
    set -o notify
else
    set +o noclobber
fi

if [ ${_BASHRC_OPTION["noclobber"]} = true ]; then
    set -o noclobber
else
    set +o noclobber
fi

if [ ${_BASHRC_OPTION["easylogout"]} = true ]; then
    set +o ignoreeof
else
    set -o ignoreeof
fi


# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.

# Disable options:
shopt -u mailwarn
unset MAILCHECK        # Don't want my shell to warn me of incoming mail.