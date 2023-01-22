#!/bin/zsh                                                                

#kill the iCloud Drive upload process to make it unstuck

RED='\033[1;31m' # bold red
GREEN='\033[32;1m' # bold green
BOLD='\033[1m' # bold
LINK='\033[34;4m' # blue underlined
ITALIC='\033[3m' # italic
NC='\033[0m' # No Color


# http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#index-read
if read -q "choice?Press Y/y to continue with killing the iCloud Drive process:"$'\n' 
    then
	echo
        sleep 1
        echo -e "${BOLD}Killing iCloud Drive process ...${NC}"
        sleep 1
        killall bird
        echo "${GREEN}Successfully killed the iCloud Drive processes!${NC}"
else
    echo
    echo -e "${BOLD}'$choice' not 'Y' or 'y'. Exiting...${NC}"
fi
