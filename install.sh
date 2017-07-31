#!/bin/bash

set -e

cd $HOME

mkdir -p ./bin

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='Linux'
  sudo apt-get install git vim tmux xclip bmon bc
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='Darwin'
  brew install reattach-to-user-namespace bmon tmux vim git fpp youtube-dl
else
  echo "[ERROR] Unknown platform."
  exit 1
fi

CONFIG_DIR="$HOME/configurations"
if [ ! -d "$CONFIG_DIR" ]; then
  git clone https://github.com/weilonge/configurations.git $HOME/configurations
  ln -s $HOME/configurations/tmux.conf $HOME/.tmux.conf
  git config --global core.excludesfile $HOME/configurations/git/gitignore_global
  # TODO Add source ~/configurations/bash_source_me
  # TODO source ~/.bashrc if needed
else
  echo "configurations checked."
fi

if [ ! -d "$HOME/.vim" ]; then
  git clone https://github.com/weilonge/dotvim.git $HOME/.vim
  ln -s $HOME/.vim/vimrc $HOME/.vimrc
  git config --global core.editor vim
  # TODO Run PlugInstall in vim
else
  echo ".vim checked."
fi

TOOLS_DIR=$HOME/Projects/tools
mkdir -p ${TOOLS_DIR}

# powerline-shell
if [ ! -d "${TOOLS_DIR}/powerline-shell" ]; then
  git clone https://github.com/milkbikis/powerline-shell ${TOOLS_DIR}/powerline-shell
  cd ${TOOLS_DIR}/powerline-shell
  # Copy config.py.dist to config.py and edit it to configure the segments
  # you want. Then run
  ./install.py
  ln -s ${TOOLS_DIR}/powerline-shell/powerline-shell.py $HOME/bin/powerline-shell.py
else
  echo "powerline-shell checked."
fi


# powerline-fonts
if [ ! -d "${TOOLS_DIR}/powerline-fonts" ]; then
  git clone https://github.com/powerline/fonts.git ${TOOLS_DIR}/powerline-fonts
  cd ${TOOLS_DIR}/powerline-fonts
  ./install.sh
else
  echo "powerline-fonts checked."
fi

# Install NVM
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
else
  echo ".nvm checked."
fi

