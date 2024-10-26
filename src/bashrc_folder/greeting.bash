function greeting_info() {
    if [ ${_BASHRC_OPTION["chatty"]} = true ]; then
        echo -ne "$1"
    fi
}

# List enabled options
function list_options() {
    local notFirst=false
    greeting_info "Enabled options:\n"

    for k in "${!_BASHRC_OPTION[@]}"
    do
        if [ ${_BASHRC_OPTION[$k]} = true ]; then
            if [ $notFirst = true ]; then
                greeting_info ", $k"
            else
                greeting_info "$k"
            fi
            notFirst=true
        fi
    done
    greeting_info "\n\n"
}

# Print Bash-Version
_HOST=$(hostname | cut -f1 -d.)
greeting_info "${BWhite}This is BASH ${BRed}${BASH_VERSION%.*}${BWhite} on ${BCyan}${_HOST}${NC}\n\n"

#list_options
list_options

date

if [ -x /usr/games/fortune ]; then
    /usr/games/fortune -s     # Makes our day a bit more fun.... :-)
fi