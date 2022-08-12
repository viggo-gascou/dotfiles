#!/bin/zsh                                                                

#kill the iCloud Drive upload process to make it unstuck


# http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html#index-read
if read -q "choice?Press Y/y to continue with killing the iCloud Drive process:"$'\n' 
    then
	echo
        sleep 1
        echo "Killing iCloud Drive process ..."
        sleep 1
        killall bird
        echo "Successfully killed the iCloud Drive processes!"
else
    echo
    echo "'$choice' not 'Y' or 'y'. Exiting..."
fi
