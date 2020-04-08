
function color() (
    function colorCode() {
        declare -i code=16
        declare -i internalCode=$1
        let "code += internalCode / 100 * 36"
        let "internalCode %= 100"
        let "code += internalCode / 10 * 6"
        let "code += internalCode % 10"
        echo -ne $code
    }

    function dark() {
        declare -i original=$1
        declare -i modified=0
        let "modified += original / 200 * 100"
        let "original %= 100"
        let "modified += original / 20 * 10"
        let "original %= 10"
        let "modified += original / 2"
        echo -ne $modified
    }

    function light() {
        declare -i original=$1
        declare -i modified=0
        let "modified += ( 5 - ( 5 - original / 100 ) / 2 ) * 100"
        let "original %= 100"
        let "modified += ( 5 - ( 5 - original / 10 ) / 2 ) * 10"
        let "original %= 10"
        let "modified += ( 5 - ( 5 - original ) / 2 )"
        echo -ne $modified
    }

    declare -A colors
    colors=(
        ["black"]=0
        ["white"]=555
        ["gray"]=333

        ["red"]=500
        ["green"]=050
        ["yellow"]=550
        ["blue"]=005
        ["magenta"]=505
        ["cyan"]=055
        ["orange"]=530
    )

    declare -A modifiers 
    modifiers=(
        ["light"]=1 
        ["dark"]=2
    )

    declare -A fontopts
    fontopts=(
        ["bold"]=1 
        ["ulined"]=2
        ["blinking"]=3
    )

    IFS=' ' read -ra _commands <<< "$1"
    
    local parseMode=0
    local cOpts=0

    for i in "${_commands[@]}"; do
        if [[ -n "${fontopts[$i]}" && $parseMode -lt 1 ]]; then
            case ${fontopts[$i]} in
                1) echo -ne $(tput bold);;
                2) echo -ne $(tput smul);;
                3) echo -ne $(tput blink);;
            esac
            parseMode=1
        elif [[ -n "${modifiers[$i]}" && $parseMode -lt 2 ]]; then
            cOpts+=${modifiers[$i]}
            parseMode=2
        elif [[ -n "${colors[$i]}" && $parseMode -lt 3 ]]; then
            declare -i tcc=${colors[$i]}
            if [[ "cOpts % 10" -eq 1 ]]; then
                tcc=$(light $tcc)
            elif [[ "cOpts % 10" -eq 2 ]]; then
                tcc=$(dark $tcc)
            fi
            if [[ cOpts -lt 10 ]]; then
                echo -ne $(tput setaf "$(colorCode $tcc)")
                parseMode=3
            else
                echo -ne $(tput setab "$(colorCode $tcc)")
                parseMode=5
            fi
        elif [[ "$i" == "on" && $parseMode -eq 3 ]]; then
            cOpts=10
            parseMode=1
        fi
    done

)

echo $(color "bold light blue on dark orange");

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset


ALERT=${BWhite}${On_Red} # Bold White on red background

