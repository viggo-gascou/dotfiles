#!/usr/bin/env bash

print_help() {
='\033[1m' #
   ='\033[3m' #
    UNDERLINE='\033[4m' #
    
    LINK='\033[34;4m' # blue
    NC='\033[0m' # No Color
    echo
    echo -e "\t\t\t\t ${BOLD} Sample colors ${NC}"
    printf '%.0s–' {1..88}; echo
    echo
    echo "Prints some sample colors with different ASCII escape codes"
    echo
    echo -e "${BOLD}Usage:${NC}"
    echo
    echo -e "    print_colors -h                       Display this help message"
    echo
    echo -e "    print_colors --help                   Display this help message"
    echo 
    echo -e "    print_colors -b                       Display the colors with ${BOLD}bold${NC} text" 
    echo
    echo -e "    print_colors --bold                   Display the colors with ${BOLD}bold${NC} text" 
    echo
    echo -e "    print_colors -u                       Display the colors with ${UNDERLINE}underlined${NC} text"
    echo
    echo -e "    print_colors --underline              Display the colors with ${UNDERLINE}underlined${NC} text"
    echo
    echo -e "    print_colors -i                       Display the colors with ${ITALIC}italic${NC} text"
    echo
    echo -e "    print_colors --italic                 Display the colors with ${ITALIC}italic${NC} text"
    echo
    echo -e "Created by ${LINK}https://github.com/viggo-gascou${NC}"
}


if [ -n "$1" ]
then
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]
    then
        print_help
        exit 0

    elif [ "$1" = "-b" ] || [ "$1" = "--bold" ]
    then
        echo
        echo -e "|039;1| \033[39;1mDefault\033[m  |049;1| \033[49;1mDefault\033[m  |037;1| \033[37;1mLight gray\033[m     |047;1| \033[47;1mLight gray\033[m"
        echo -e "|030;1| \033[30;1mBlack\033[m    |040;1| \033[40;1mBlack\033[m    |090;1| \033[90;1mDark gray\033[m      |100;1| \033[100;1mDark gray\033[m"
        echo -e "|031;1| \033[31;1mRed\033[m      |041;1| \033[41;1mRed\033[m      |091;1| \033[91;1mLight red\033[m      |101;1| \033[101;1mLight red\033[m"
        echo -e "|032;1| \033[32;1mGreen\033[m    |042;1| \033[42;1mGreen\033[m    |092;1| \033[92;1mLight green\033[m    |102;1| \033[102;1mLight green\033[m"
        echo -e "|033;1| \033[33;1mYellow\033[m   |043;1| \033[43;1mYellow\033[m   |093;1| \033[93;1mLight yellow\033[m   |103;1| \033[103;1mLight yellow\033[m"
        echo -e "|034;1| \033[34;1mBlue\033[m     |044;1| \033[44;1mBlue\033[m     |094;1| \033[94;1mLight blue\033[m     |104;1| \033[104;1mLight blue\033[m"
        echo -e "|035;1| \033[35;1mMagenta\033[m  |045;1| \033[45;1mMagenta\033[m  |095;1| \033[95;1mLight magenta\033[m  |105;1| \033[105;1mLight magenta\033[m"
        echo -e "|036;1| \033[36;1mCyan\033[m     |046;1| \033[46;1mCyan\033[m     |096;1| \033[96;1mLight cyan\033[m     |106;1| \033[106;1mLight cyan\033[m"
    
    elif [ "$1" = "-u" ] || [ "$1" = "--underlined" ]
    then
        echo
        echo -e "|039;4| \033[39;4mDefault\033[m  |049;4| \033[49;4mDefault\033[m  |037;4| \033[37;4mLight gray\033[m     |047;4| \033[47;4mLight gray\033[m"
        echo -e "|030;4| \033[30;4mBlack\033[m    |040;4| \033[40;4mBlack\033[m    |090;4| \033[90;4mDark gray\033[m      |100;4| \033[100;4mDark gray\033[m"
        echo -e "|031;4| \033[31;4mRed\033[m      |041;4| \033[41;4mRed\033[m      |091;4| \033[91;4mLight red\033[m      |101;4| \033[101;4mLight red\033[m"
        echo -e "|032;4| \033[32;4mGreen\033[m    |042;4| \033[42;4mGreen\033[m    |092;4| \033[92;4mLight green\033[m    |102;4| \033[102;4mLight green\033[m"
        echo -e "|033;4| \033[33;4mYellow\033[m   |043;4| \033[43;4mYellow\033[m   |093;4| \033[93;4mLight yellow\033[m   |103;4| \033[103;4mLight yellow\033[m"
        echo -e "|034;4| \033[34;4mBlue\033[m     |044;4| \033[44;4mBlue\033[m     |094;4| \033[94;4mLight blue\033[m     |104;4| \033[104;4mLight blue\033[m"
        echo -e "|035;4| \033[35;4mMagenta\033[m  |045;4| \033[45;4mMagenta\033[m  |095;4| \033[95;4mLight magenta\033[m  |105;4| \033[105;4mLight magenta\033[m"
        echo -e "|036;4| \033[36;4mCyan\033[m     |046;4| \033[46;4mCyan\033[m     |096;4| \033[96;4mLight cyan\033[m     |106;4| \033[106;4mLight cyan\033[m"
    
    elif [ "$1" = "-i" ] || [ "$1" = "--italic" ]
    then
        echo
        echo -e "|039;3| \033[39;3mDefault\033[m  |049;3| \033[49;3mDefault\033[m  |037;3| \033[37;3mLight gray\033[m     |047;3| \033[47;3mLight gray\033[m"
        echo -e "|030;3| \033[30;3mBlack\033[m    |040;3| \033[40;3mBlack\033[m    |090;3| \033[90;3mDark gray\033[m      |100;3| \033[100;3mDark gray\033[m"
        echo -e "|031;3| \033[31;3mRed\033[m      |041;3| \033[41;3mRed\033[m      |091;3| \033[91;3mLight red\033[m      |101;3| \033[101;3mLight red\033[m"
        echo -e "|032;3| \033[32;3mGreen\033[m    |042;3| \033[42;3mGreen\033[m    |092;3| \033[92;3mLight green\033[m    |102;3| \033[102;3mLight green\033[m"
        echo -e "|033;3| \033[33;3mYellow\033[m   |043;3| \033[43;3mYellow\033[m   |093;3| \033[93;3mLight yellow\033[m   |103;3| \033[103;3mLight yellow\033[m"
        echo -e "|034;3| \033[34;3mBlue\033[m     |044;3| \033[44;3mBlue\033[m     |094;3| \033[94;3mLight blue\033[m     |104;3| \033[104;3mLight blue\033[m"
        echo -e "|035;3| \033[35;3mMagenta\033[m  |045;3| \033[45;3mMagenta\033[m  |095;3| \033[95;3mLight magenta\033[m  |105;3| \033[105;3mLight magenta\033[m"
        echo -e "|036;3| \033[36;3mCyan\033[m     |046;3| \033[46;3mCyan\033[m     |096;3| \033[96;3mLight cyan\033[m     |106;3| \033[106;3mLight cyan\033[m"
    fi

elif [ ! -n "$1" ]
then
    echo
    echo -e "|039| \033[39mDefault\033[m  |049| \033[49mDefault\033[m  |037| \033[37mLight gray\033[m     |047| \033[47mLight gray\033[m"
    echo -e "|030| \033[30mBlack\033[m    |040| \033[40mBlack\033[m    |090| \033[90mDark gray\033[m      |100| \033[100mDark gray\033[m"
    echo -e "|031| \033[31mRed\033[m      |041| \033[41mRed\033[m      |091| \033[91mLight red\033[m      |101| \033[101mLight red\033[m"
    echo -e "|032| \033[32mGreen\033[m    |042| \033[42mGreen\033[m    |092| \033[92mLight green\033[m    |102| \033[102mLight green\033[m"
    echo -e "|033| \033[33mYellow\033[m   |043| \033[43mYellow\033[m   |093| \033[93mLight yellow\033[m   |103| \033[103mLight yellow\033[m"
    echo -e "|034| \033[34mBlue\033[m     |044| \033[44mBlue\033[m     |094| \033[94mLight blue\033[m     |104| \033[104mLight blue\033[m"
    echo -e "|035| \033[35mMagenta\033[m  |045| \033[45mMagenta\033[m  |095| \033[95mLight magenta\033[m  |105| \033[105mLight magenta\033[m"
    echo -e "|036| \033[36mCyan\033[m     |046| \033[46mCyan\033[m     |096| \033[96mLight cyan\033[m     |106| \033[106mLight cyan\033[m"
    echo
    echo "Use 'print_colors -h' to see more options"
fi

