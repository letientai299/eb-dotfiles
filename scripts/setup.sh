#!/usr/bin/env bash
# This scripts setting up the env.
# This scripts assume that the location of

# check for readlink/realpath presence
# https://github.com/deadc0de6/dotdrop/issues/6
rl="readlink -f"

if ! ${rl} "${0}" >/dev/null 2>&1; then
  rl="realpath"

  if ! hash ${rl}; then
    echo "\"${rl}\" not found !" && exit 1
  fi
fi

export SCRIPT_DIR=$(dirname "$(${rl} "$0")")

# Source the common.sh script
# shellcheck source=./common.sh
. "$SCRIPT_DIR/common.sh"

echo_info "Install needed softwares"
sudo yum install -y git zsh util-linux-user

echo_info "Install zgen, which is used to manage zsh plugins"
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

echo_info "change ec2-user shell to zsh"
sudo chsh -s $(which zsh) ec2-user

echo_info "Create sym link for zshrc"
ln -fs $SCRIPT_DIR/../src/zsh/zshrc ~/.zshrc

echo_info "Create empty file for z plugins"
touch ~/.z

echo_info "Create symlink for vim"
ln -fs $SCRIPT_DIR/../src/vim ~/.vim

echo_info "Install vim plugins"
vim -c "PlugUpgrade" -c "qa!"
vim -c "PlugUpdate" -c "qa!"

echo_info "Done. You might want to log out and login again to reload the config"

cd "$SCRIPT_DIR" || exit 1