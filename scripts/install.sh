#!/usr/bin/env bash

echo_info() {
  color=$(tput setaf 2)
  reset=$(tput sgr0)
  echo "${color}[INFO] $*${reset}"
}

echo_warn() {
  color=$(tput setaf 3)
  reset=$(tput sgr0)
  echo "${color}[WARN] $*${reset}"
}

echo_error() {
  # Visit this page for tput look up color code
  # https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
  color=$(tput setaf 208)
  reset=$(tput sgr0)
  echo "${color}[ERROR] $*${reset}"
}

if ! command -v curl >/dev/null 2>&1; then
  echo_error "curl not found, please install it first"
  exit 1
fi

if [ -d "~/.eb-dotfiles" ]; then
  echo_error "Directory ~/.eb-dotfiles exists. Stop!"
  exit 1
fi

echo Done
