#!/bin/zsh                                                                
# checks to see if there is an update to kitty and update if there is. 

RED='\033[1;31m' # bold red
GREEN='\033[32;1m' # bold green
YELLOW='\033[33;1m' # bold yellow
BOLD='\033[1m' # bold'
NC='\033[0m' # No Color

# testing if there is a connection to the internet by checking if user can ping the Google DNS server (8.8.8.8)
if ! ping -q -t 1 -c 1 8.8.8.8 &> /dev/null
then
    echo "Trying to ping the Google DNS server ..."
    echo
    ping -q -t 1 -c 1 8.8.8.8 
    echo
    echo "${RED}NETWORK ERROR!${NC}"
    echo "Please make sure that you are connected to the internet!"
    exit 101
fi

# getting the latest version number from brew cask
latest=$(curl --silent --fail-with-body https://raw.githubusercontent.com/Homebrew/homebrew-cask/master/Casks/kitty.rb | \
       grep 'version \".*\"' | \
       sed 's/[^0-9.]//g')
   
# getting the current version number
current=$(kitty --version | sed 's/[^0-9.]//g')

if ! hash kitty &> /dev/null
then
    echo
    echo "${RED}UH OH!${NC}"
    echo "It appears that kitty is not installed!"
    echo
    if read -q "choice?Do you want to install it? Press Y/y to continue"$'\n'
    then
        echo
        echo "Installing kitty using the command 'brew install --cask kitty' ..."
        echo
        sleep 1
        brew install --cask kitty
        echo
    else
        echo 
        echo "'$choice' not 'Y' or 'y'. Exiting..."
        exit 0
    fi
    if read -q "choice?Do you want to change the icon of kitty as well? Press Y/y to continue"$'\n'
    then
        echo
        sleep 1
        ~/bin_scripts/change_icon.sh -n kitty
    else
        echo 
        echo "'$choice' not 'Y' or 'y'. Exiting..."
        exit 0
    fi
fi


echo

if [[ ${current} == ${latest} ]]
then
    echo -e "Well done! You are already using version ${GREEN}$current${NC} which the latest version of kitty! 😻"
    if read -q "choice?  Do you want to reinstall to try and fix any bugs? Press Y/y to continue"$'\n'
    then
        echo
        echo "Reinstalling kitty using the command 'brew reinstall --cask kitty' ..."
        echo
        sleep 1
        brew reinstall --cask kitty
        echo
    else
        echo 
        echo "'$choice' not 'Y' or 'y'. Exiting..."
        exit 0
    fi
    if read -q "choice?Do you want to change the icon of kitty as well? Press Y/y to continue"$'\n'
    then
        echo
        sleep 1
        ~/bin_scripts/change_icon.sh -n kitty
    else
        echo 
        echo "'$choice' not 'Y' or 'y'. Exiting..."
        exit 0
    fi
else
    echo -e "Oh no! You are using version ${RED}$current${NC}! Whereas the latest version of kitty is version ${GREEN}$latest${NC}! 😿"
    if read -q "choice? Do you want to update to the latest version? Press Y/y to continue"$'\n'
    then
        echo
        echo "Updating kitty using the command 'brew upgrade kitty' ..."
        echo
        sleep 1
        brew upgrade kitty
        echo
    else
        echo 
        echo "'$choice' not 'Y' or 'y'. Exiting..."
        exit 0
    fi
    if read -q "choice?Do you want to change the icon of kitty as well? Press Y/y to continue"$'\n'
    then
        echo
        sleep 1
        ~/bin_scripts/change_icon.sh -n kitty
    else
        echo 
        echo "'$choice' not 'Y' or 'y'. Exiting..."
        exit 0
    fi
fi

