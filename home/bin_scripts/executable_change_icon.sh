#!/bin/zsh                                                                
# changes the icon of a given application from the folder '~/custom-icons'
# Inspired by: https://bit.ly/3tkglE3

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
    echo -e "\t\t\t ${BOLD} Automatic icon replacement ${NC}"
    printf '%.0s\u2500' {1..88}; echo
    echo
    echo "Changes the icon of the specified application with icon from the folder '~/custom-icons'"
    echo
    echo "The name of new icon has to be the same as the application which icon should be changed"
    echo "A backup of the original icon wil be created and placed in '~/custom-icons/backup'"
    echo
    echo -e "${BOLD}Usage:${NC}"
    echo
    echo "    replace_icon -h                       Display this help message"
    echo
    echo "    replace_icon --help                   Display this help message"
    echo 
    echo "    replace_icon -r                       Display the requirements to use this script" 
    echo
    echo "    replace_icon --requirements           Display the requirements to use this script" 
    echo
    echo "    replace_icon -d                       <name-of-application-that-needs-default-icon>"
    echo
    echo "    replace_icon --default-icon           <name-of-application-that-needs-default-icon>"
    echo
    echo "    replace_icon -n                       <name-of-application-that-needs-new-icon>"
    echo
    echo "    replace_icon --new-icon               <name-of-application-that-needs-new-icon>"
    echo
    echo -e "Created by ${LINK}https://github.com/viggo-gascou${NC}"
}

print_requirements() {
    echo
    echo -e "\t\t\t\t ${BOLD} Requirements ${NC}"
    printf '%.0s\u2500' {1..87}; echo
    echo
    echo "These following are required to get the best experience using this program:"
    echo
    echo "- The ${ITALIC}kitty${NC} terminal which can be found at: ${LINK}https://sw.kovidgoyal.net/kitty/binary/${NC}"
    echo
    echo "- ${ITALIC}Imagemagick${NC} which which can be found at: ${LINK}https://imagemagick.org/script/download.php${NC}"
    echo
    echo -e "${BOLD}Note:${NC} 
    Although the program will work without the above applications installed I strongly
    recommend that you install them to get the best experience possible!"
}
in_file="-"
revert=false

function change_icon() {
    # getting the correct file name for the icon file from the applications 'Info.plist' file
    icn_name=$(grep -A1 "CFBundleIconFile" /Applications/"$in_file".app/Contents/Info.plist | grep -v "CFBundleIconFile")
    icn_name=$(sed -e "s/.*<string>\(.*\)<\/string>*/\1/" <<< $icn_name)

    # variable for original icon file path
    icn_path=/Applications/"$in_file".app/Contents/Resources/"$icn_name"

    # creating temporary folder for the temporary files
    TEMP_DIR=$(mktemp -dt "$(basename "$0")")

    # making sure that the temporary directory gets deleted before the program exits even if there is a non-zero exit code
    trap 'rm -rf "$TEMP_DIR"' 0 2 3 15 EXIT 

    # making sure that the temporary directory can be created if not exit
    if [[ ! "$TEMP_DIR" || ! -d "$TEMP_DIR" ]]
    then
        echo "Could not create temp dir"
        exit 1; fi

    # create the temporary files and also exit if it could not be created
    new_png_path="$(mktemp $TEMP_DIR/$(basename "$0").XXXXXXXXXXXXX)" || exit 1
    echo "program output" >> $new_png_path
    old_png_path="$(mktemp $TEMP_DIR/$(basename "$0").XXXXXXXXXXXXX)" || exit 1
    echo "program output" >> $old_png_path


    # if the user is reverting the icon back to the default icon we change the paths
    if $revert
    then
        new_icn_pth=~/custom-icons/backup/"$in_file"-bak.icns
    else
        new_icn_pth=~/custom-icons/"$in_file".icns; fi

    # creating backup dir if not already present
    mkdir -p -v ~/custom-icons/backup/ 

    # creating backup of default app icon if not already created
    if ! test -f ~/custom-icons/backup/"$in_file"-bak.icns; then 
        echo
        echo "Creating a backup of the default app icon ..."    
        cp -v "$icn_path" ~/custom-icons/backup/"$in_file"-bak.icns; fi


    if [[ "$icn_name" == *.icns ]]; then
        # creating a temp png to display old icon
        sips -Z 250 -s format png "$icn_path" --out "$old_png_path" > /dev/null 2>&1
        # creating a temp png to display new icon
        sips -Z 250 -s format png "$new_icn_pth" --out "$new_png_path" > /dev/null 2>&1

    else
        # creating a temp png to display old icon
        sips -Z 250 -s format png "$icn_path".icns --out "$old_png_path" > /dev/null 2>&1
        # creating a temp png to display new icon
        sips -Z 250 -s format png "$new_icn_pth" --out "$new_png_path" > /dev/null 2>&1
        fi
        
        # checking if the user is using the 'kitty' terminal
    if [ "$TERM" = 'xterm-kitty' ]; then
        echo
        # displaying it in the terminal using 'icat'
        echo -e "${RED}OLD ICON${NC}"
        kitty +kitten icat --align left "$old_png_path"
        echo -e "${GREEN}NEW ICON${NC}"
        kitty +kitten icat --align left "$new_png_path"

        # else display with preview/qlmanage which is native to macOS
    else
        echo
        echo -e "${BOLD} PRESS CMD+ENTER"
        echo " TO VIEW BOTH ICONS" 
        echo " SIDE BY SIDE ${NC}"
        qlmanage -p "$old_png_path" "$new_png_path" > /dev/null 2>&1
        echo; fi

    # making sure the user actually wants to change the icon of the specified application
    if read -q "choice?Are you sure you want to change the icon of $in_file.app? Press Y/y to continue"$'\n' 
        then
            echo
            echo "Changing icon of $in_file.app ..."
            echo
            sleep 1
            # checking if the icn_name ends with .icns and overwrites the old icon 
            if [[ "${icn_name:0-5}" == '.icns' ]]; then
                cp "$new_icn_pth" "${icn_path}"
            else
                cp "$new_icn_pth" "${icn_path}".icns
                fi

            echo "Restarting necessary apps and services to display the new icon ..."
            echo
            touch /Applications/"$in_file".app
            killall Finder && killall Dock
            sleep 1
            echo "Successfully changed the icon of $in_file.app! Enjoy! 🎉"
    else
        echo 
        echo "'$choice' not 'Y' or 'y'. Exiting..."
        exit 0
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
      
    # prints the requirements for the program
    elif [ "$1" = "-r" ] || [ "$1" = "--requirements" ]
    then
        print_requirements
        exit 0

    # revert the application's icon back to its default icon
    elif [ "$1" = "-d" ] || [ "$1" = "--default-icon" ]
    then
        revert=true
        in_file="$2"
        in_path=~/custom-icons/backup/"$in_file"-bak.icns

        # testing if the icon file exists if not exit with error 1
        if test -f "$in_path"
        then
            change_icon "$in_file"
        else
            echo 
            echo -e "${RED}ERROR${NC}"
            echo "$in_file-bak.icns was not found please make sure it is in '~/custom-icons/backup/$in_file-bak.icns'!"
            echo "This is most likely because you have not replaced the default icon of the app $in_file.app."
            exit 2; fi

    # change the application's icon to a new custom icon
    elif [ "$1" = "-n" ] || [ "$1" = "--new-icon" ]
    then
        in_file="$2"
        in_path=~/custom-icons/$in_file.icns
        
        # testing if the icon file exists if not exit with error 1
        if test -f "$in_path"
        then
            change_icon "$in_file"
        else
            echo 
            echo -e "${RED}ERROR${NC}"
            echo "$in_file.icns was not found please make sure it is named $in_file.icns and can be found as '~/custom-icons/$in_file.icns'!"
            exit 2; fi
    # if any other argument no listed in the help menu is given exit and give error message
    else
        echo
        echo -e "${RED}ERROR${NC}"
        echo "Invalid argument given see replace_icon -h for the correct arguments!"
        exit 22;fi

# if no arguments are given print the help menu
elif [ ! -n "$1" ]
then
    print_help
    exit 0
fi
