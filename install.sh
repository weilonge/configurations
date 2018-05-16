#!/bin/bash

set -e

cd $HOME

mkdir -p ./bin

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='Linux'
  sudo apt-get install \
    xsel \
    bc \
    bmon \
    git \
    vim \
    tmux
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='Darwin'
  brew install \
    fpp \
    reattach-to-user-namespace \
    terminal-notifier \
    wget \
    youtube-dl \
    bmon \
    git \
    vim \
    tmux
else
  echo "[ERROR] Unknown platform."
  exit 1
fi

CONFIG_DIR="$HOME/configurations"
if [ ! -d "$CONFIG_DIR" ]; then
  git clone https://github.com/weilonge/configurations.git $CONFIG_DIR
  ln -s $CONFIG_DIR/tmux.conf $HOME/.tmux.conf
  git config --global core.excludesfile $CONFIG_DIR/git/gitignore_global
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
if [ ! -x "`which powerline-shell`" ]; then
  pip install powerline-shell
  cp $CONFIG_DIR/powerline-shell.json $HOME/.powerline-shell.json
else
  echo "powerline-shell checked."
fi


# powerline-fonts
if [ ! -d "${TOOLS_DIR}/powerline-fonts" ]; then
  git clone https://github.com/powerline/fonts.git ${TOOLS_DIR}/powerline-fonts
  cd ${TOOLS_DIR}/powerline-fonts
  ./install.sh
  cd -
else
  echo "powerline-fonts checked."
fi

# Install NVM
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
else
  echo ".nvm checked."
fi

