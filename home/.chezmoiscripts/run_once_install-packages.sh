#!/bin/sh

# -- DESCRIPTION --------------------------------------------------------------

# -*-mode:sh-*- vim:ft=sh

# ~/.local/share/chezmoi/home/.chezmoiscripts/run_once_install-packages.sh
# =============================================================================
# Automatically install Homebrew packages.
#

set -e # -e: exit on error

RED='\033[1;31m' # bold red
GREEN='\033[32;1m' # bold green
YELLOW='\033[033;1m' # bold yellow
BOLD='\033[1m' # bold
NC='\033[0m' # no Color

if ! command -v brew >/dev/null 2>&1; then
    echo "${BOLD}⏳ Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

read -r -p "Do you want to install all packages from the Brewfile? Type 'yes' to continue."$'\n' REPLY
if [[ "$REPLY" =~ ^([yY][eE][sS]|[yY])$ ]] 1>/dev/null; then
  brew bundle --file=~/.config/brew/Brewfile
else
  echo
  echo "${YELLOW}⏩ Not installing packages using brew, skipping.${NC}"
  exit 0
fi