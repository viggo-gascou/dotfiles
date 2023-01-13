#!/bin/sh

# -- DESCRIPTION --------------------------------------------------------------

# -*-mode:sh-*- vim:ft=sh

# ~/.local/share/chezmoi/remote_install.sh
# =============================================================================
# Remotely install dotfiles from single shell command
#
# Reference https://bit.ly/narze_install

set -e # -e: exit on error

RED='\033[1;31m' # bold red
GREEN='\033[32;1m' # bold green
BOLD='\033[1m' # bold
NC='\033[0m' # no Color


if [ "${xcode-select -p 1>/dev/null;echo $?}" = 2 ]; then # only install Xcode Command Line Tools if not installed. Thanks @jnovack: https://bit.ly/xcode-check
  echo "${BOLD}🔨 Installing Xcode Command Line Tools...${NC}"
  xcode-select --install
else
  echo "${GREEN}✅ Xcode Command Line Tools already installed, skipping.${NC}"
fi

if command -v brew >/dev/null 2>&1; then # only install Homebrew if not installed
  echo "${GREEN}✅ Homebrew already installed, skipping.${NC}"
  
  if command -v chezmoi >/dev/null 2>&1; then # only install chezmoi if not installed
    echo "${GREEN}✅ Chezmoi already installed, skipping.${NC}"
  else
    echo "${BOLD}🏠 Installing chezmoi via homebrew...${NC}"
    brew install chezmoi
    fi
else
  echo "${BOLD}🍺 Installing Homebrew...${NC}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "${BOLD}🏠 Installing chezmoi via homebrew...${NC}"
  brew install chezmoi
fi

echo "${BOLD}🛠 Setting up dotfiles using chezmoi...${NC}"
# exec: replace current process with chezmoi init
exec chezmoi init --apply viggo-gascou

