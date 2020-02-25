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
sudo yum install -y git zsh util-linux-user libevent-devel ncurses-devel gcc make pkg-config

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

echo_info "Install ranger"
git clone https://github.com/ranger/ranger ~/.ranger
cd ~/.ranger && git checkout v1.9.3 && sudo make install

echo_info "Install tmux"
mkdir ~/.tmux-source &&
  cd ~/.tmux-source &&
  wget https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a.tar.gz &&
  tar -zxf tmux-*.tar.gz &&
  cd tmux-*/ &&
  ./configure &&
  make &&
  sudo make install &&
  cd ~ && rm -rf ~/.tmux-source

echo_info "Create symlinks tmux"
ln -fs $SCRIPT_DIR/../src/tmux/tmux.conf ~/.tmux.conf

echo_info "Install tmux plugins"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins

echo_info "Install direnv"
sudo yum install https://kojipkgs.fedoraproject.org//vol/fedora_koji_archive02/packages/direnv/2.12.2/1.fc28/x86_64/direnv-2.12.2-1.fc28.x86_64.rpm

echo_info "Done. You might want to log out and login again to reload the config"

cd "$SCRIPT_DIR" || exit 1
