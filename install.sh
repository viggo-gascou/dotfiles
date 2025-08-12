#!/bin/bash

set -e

info () {
  printf "\r  [\033[1;34mINFO\033[0m] $1\n"
}

user () {
  printf "\r  [ \033[1;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[1;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[1;31mFAIL\033[0m] 💥 $1\n"
  echo ''
  exit ${2:-1} # Exit with the provided status code, default to 1
}

wait_for_user () {
  # https://github.com/Homebrew/install/blame/main/install.sh#L333
  local c
  IFS='' read -r -n 1 -d '' -s c
  # we test for \r and \n because some stuff does \r instead
  if ! [[ "${c}" == $'\r' || "${c}" == $'\n' ]]
  then
    fail "User aborted installation"
  fi
}

if [ "$(uname)" != "Darwin" ]; then
  fail "This install script is only intended for macOS"
else
  success "🍎 Operating system is macOS"
fi

if ! xcode-select -p >/dev/null 2>&1; then
  info "📦 Installing xcode command line tools, this may take a while..."
  /usr/bin/xcode-select --install
  # wait for user input since xcode-select opens a GUI
  user "Press ENTER to continue or any other key to abort:"
  wait_for_user
  success "🔨 Installed xcode command line tools"
else
  success "🔨 Xcode command line tools are already installed"
fi

if [ ! "$(command -v brew)" ]; then
  info "📦 Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # Add Homebrew to PATH for current session
  eval "$(/opt/homebrew/bin/brew shellenv)" 2>/dev/null || eval "$(/usr/local/bin/brew shellenv)" 2>/dev/null
  success "🍻 Installed homebrew"
else
  success "🍻 Homebrew is already installed"
fi

if [ ! "$(command -v chezmoi)" ]; then
  info "📦 Installing chezmoi..."
  brew install chezmoi
  success "🏠 Installed chezmoi"
else
  success "🏠 Chezmoi is already installed"
fi

info "🚀 Setting up dotfiles using chezmoi..."
chezmoi init --apply viggo-gascou
if [ $? -eq 0 ]; then
  success "🎉 Dotfiles setup complete! Welcome to your new home!"
fi
