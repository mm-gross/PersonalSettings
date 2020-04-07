
function color() {
    declare -A colors
    colors["black"]=0
    colors["white"]=15
    colors["gray"]=8
    colors["lightgray"]=7

    colors["red"]=9
    colors["green"]=10
    colors["yellow"]=11
    colors["blue"]=12
    colors["magenta"]=13
    colors["cyan"]=14

    colors["darkred"]=88
    colors["darkgreen"]=28
    colors["darkyellow"]=100
    colors["darkblue"]=18
    colors["darkmagenta"]=90
    colors["darkcyan"]=30

    colors["lightred"]=210
    colors["lightgreen"]=120
    colors["lightyellow"]=228
    colors["lightblue"]=105
    colors["lightmagenta"]=213
    colors["lightcyan"]=123

    colors["orangeu"]=208

    for k in "${!colors[@]}"
    do
        echo -e "\\033[01;38;5;${colors[$k]}m$k\\033[0m"
    done

    local fg=$(echo $1 | cut -f1 -d\ )
    if [ "$(echo $1 | cut -f2 -d\ )" == "on" ]; then
        local bg=$(echo $1 | cut -f3 -d\ )
    fi
}

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

