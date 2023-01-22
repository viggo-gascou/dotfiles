#!/bin/zsh 

# Disables dark mode for a given app

# Exit immediately on each error and unset variable;
# see: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Ee
 
RED='\033[1;31m' # bold red
GREEN='\033[32;1m' # bold green
BOLD='\033[1m' # bold
LINK='\033[34;4m' # blue underlined
ITALIC='\033[3m' # italic
NC='\033[0m' # No Color

print_help() {
    echo
    echo -e "\t\t\t ${BOLD} Disable dark mode ${NC}"
    printf '%.0s\u2500' {1..88}; echo
    echo
    echo "Disables dark mode of the specified application"
    echo 
    echo "${RED}Remember to double quote the application name if it contains spaces${NC}"
    echo
    echo -e "${BOLD}Usage:${NC}"
    echo
    echo "    disable_dark -h                       Display this help message"
    echo
    echo "    disable_dark --help                   Display this help message"
    echo 
    echo "    disable_dark -r                       Revert dark mode settings to default (system default)" 
    echo
    echo "    disable_dark --revert                 Revert dark mode settings to default (system default)" 
    echo
    echo "    disable_dark -d                       Disables dark mode of the specified application"
    echo
    echo "    disable_dark --disable                Disables dark mode of the specified application"
    echo
    echo -e "Created by ${LINK}https://github.com/viggo-gascou${NC}"
}

APP_NAME="-"
revert=false

function change_settings() {
    APP_BUNDLE=$(osascript -e 'id of app "'"${APP_NAME//\"/}"'"')
    if $revert
    then
        if read -q "choice?Press Y/y to revert dark mode settings in "${APP_NAME}" "$'\n' ; then
                echo
                sleep 1
                echo -e "${BOLD}Reverting dark mode settings in "${APP_NAME}" ...${NC}"
                defaults delete "${APP_BUNDLE}" NSRequiresAquaSystemAppearance
                sleep 1
                if pgrep -fx "${APP_NAME}"; then
                killall "${APP_NAME}"
                fi
                echo - "${GREEN}Successfully reverted the dark mode settings in "${APP_NAME}"!${NC}"
            else
                echo
                echo -e "${BOLD}'$choice' not 'Y' or 'y'. Exiting...${NC}"
            fi
    else
        if read -q "choice?Press Y/y to disable dark mode in "${APP_NAME}" "$'\n' ; then
            echo
            sleep 1
            echo -e "${BOLD}Disabling dark mode in "${APP_NAME}" ...${NC}"
            defaults write "${APP_BUNDLE}" NSRequiresAquaSystemAppearance -bool Yes
            sleep 1
            if pgrep -fx "${APP_NAME}"; then
            killall "${APP_NAME}"
            fi
            echo - "${GREEN}Successfully disabled dark mode in "${APP_NAME}"!${NC}"
	    else
            echo
            echo -e "${BOLD}'$choice' not 'Y' or 'y'. Exiting...${NC}"
        fi

    fi

}


# checking if an argument has been provided
if [ -n "$1" ]
then

    # prints the help menu
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
    then
        print_help
        exit 0
      
    # revert the application's dark mode settings back to follwow system defaults
    elif [ "$1" = "-r" ] || [ "$1" = "--revert" ]
    then
        revert=true
        APP_NAME="$2"
        if [ -n "$APP_NAME" ]
        then
            change_settings "$APP_NAME"
        else
        echo -e "${RED}ERROR${NC}"
        echo "No Application name given see disable_dark -h for the correct arguments!"
        exit 22;fi

    # change the application's dark mode settings to light mode
    elif [ "$1" = "-d" ] || [ "$1" = "--disable" ]
    then
        APP_NAME="$2"
        if [ -n "$APP_NAME" ]
        then
            change_settings "$APP_NAME"
        else
        echo -e "${RED}ERROR${NC}"
        echo "No Application name given see disable_dark -h for the correct arguments!"
        exit 22;fi


    # if any other argument not listed in the help menu is given exit and give error message
    else
        echo
        echo -e "${RED}ERROR${NC}"
        echo "Invalid argument given see disable_dark -h for the correct arguments!"
        exit 22;fi


# if no arguments are given print the help menu
elif [ ! -n "$1" ]
then
    print_help
    exit 0
fi
