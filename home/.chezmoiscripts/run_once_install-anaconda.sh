#!/bin/sh

# -- DESCRIPTION --------------------------------------------------------------

# -*-mode:sh-*- vim:ft=sh

# ~/.local/share/chezmoi/home/.chezmoiscripts/run_once_install-anaconda.sh
# =============================================================================
# Automatically install anaconda and kattis conda environment.
# 

set -e # -e: exit on error

RED='\033[1;31m' # bold red
GREEN='\033[32;1m' # bold green
YELLOW='\033[033;1m' # bold yellow
BOLD='\033[1m' # bold
NC='\033[0m' # no Color


if command -v conda >/dev/null 2>&1; then
  echo "${GREEN}✅ Anaconda already installed, skipping.${NC}"
  else
    echo "\n${BOLD}Please go to https://bit.ly/condainstall and install the latest conda/anaconda version\n"
    read -r -p "Have you successfully installed anaconda? Type 'yes' to continue with the installation."$'\n' REPLY
    echo "${NC}"
  if [[ "$REPLY" =~ ^([yY][eE][sS]|[yY])$ ]] 1>/dev/null; then
    echo "${GREEN}✅ Anaconda successfully installed${NC}"
  else
    echo "${RED}❌ Anaconda is needed to continue the dotfile installation process! Please retry the installation.${NC}"
    exit 0
  fi
fi

if command -v conda >/dev/null 2>&1; then # making sure that conda is installed
  echo "${BOLD}"
  read -r -p "Do you want to create a kattis specific conda environment? Type 'yes' to continue."$'\n' REPLY
  if [[ "$REPLY" =~ ^([yY][eE][sS]|[yY])$ ]] 1>/dev/null; then
    echo 
    echo "🛠 Creating kattis conda environment...${NC}"
    conda create -n pykat
    conda activate pykat
    conda config --env --set subdir osx-64
    conda install python=3.7.10
    pip install -r requirements_kat.txt
    conda activate base
    echo "${GREEN}✅ Successfully created kattis conda environment (pykat) with Python 3.7.10!${NC}"
  else
    echo
    echo "${YELLOW}⏩ kattis conda environment will not be created, skipping.${NC}"
    exit 0
    fi
  fi
fi
