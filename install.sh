#!/bin/bash

set -e

cd $HOME

mkdir -p ./bin

TOOLS_DIR=$HOME/Projects/tools
mkdir -p ${TOOLS_DIR}

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  if grep -q Microsoft /proc/version; then
    subPlatform='WSL'
  fi
  platform='Linux'
  sudo apt-get install \
    xsel \
    bc \
    curl \
    fd-find \
    silversearcher-ag \
    tig \
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
    the_silver_searcher \
    tig \
    bmon \
    git \
    vim \
    tmux

  sh <(curl -L https://nixos.org/nix/install)
  nix-env --install fd
else
  echo "[ERROR] Unknown platform."
  exit 1
fi

curl \
  -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
  -o ${HOME}/bin/yt-dlp && chmod a+rx ${HOME}/bin/yt-dlp

CONFIG_DIR="$HOME/configurations"
if [ ! -d "$CONFIG_DIR" ]; then
  git clone https://github.com/weilonge/configurations.git $CONFIG_DIR
  git config --global core.excludesfile $CONFIG_DIR/git/gitignore_global
else
  echo "configurations checked."
fi

touch ./.lowprofile

if [ ! -f ~/.tmux.conf ]; then
  ln -s $CONFIG_DIR/tmux.conf $HOME/.tmux.conf
else
  echo ".tmux.conf checked."
fi

if [[ $subPlatform == 'WSL' ]]; then
  sudo ln -s $CONFIG_DIR/wsl/wsl.conf /etc/wsl.conf
fi

if [ ! -d "$HOME/.vim" ]; then
  git clone https://github.com/weilonge/dotvim.git $HOME/.vim
  touch $HOME/.vim/.disable_coc
  git config --global core.editor vim
  vim +PlugUpgrade +PlugInstall +qa
else
  echo ".vim checked."
fi

if [ ! -f ~/.tigrc ]; then
  ln -s $CONFIG_DIR/tig/main.tigrc ~/.tigrc
else
  echo ".tigrc checked."
fi

if [ ! -e ~/.w3m ]; then
  ln -s $CONFIG_DIR/w3m $HOME/.w3m
else
  echo ".w3m checked."
fi

# powerline-shell
if [ ! -x "`which powerline-shell`" ]; then
  pip3 install powerline-shell
  ln -s $CONFIG_DIR/powerline-shell.json $HOME/.powerline-shell.json
else
  echo "powerline-shell checked."
fi

# powerline-fonts
if [ ! -d "${TOOLS_DIR}/powerline-fonts" ]; then
  git clone https://github.com/powerline/fonts.git ${TOOLS_DIR}/powerline-fonts --depth=1
  cd ${TOOLS_DIR}/powerline-fonts
  ./install.sh
  cd -
else
  echo "powerline-fonts checked."
fi

# Install NVM
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
else
  echo ".nvm checked."
fi

if [[ $platform == 'Linux' ]]; then
  if [ ! -x "`grep bash_source_me ~/.bashrc`" ]; then
    echo '
source ~/configurations/bash_source_me
' >> ~/.bashrc
  else
    echo "~/.bashrc checked."
  fi
elif [[ $platform == 'Darwin' ]]; then
  if [ ! -x "`grep bash_source_me ~/.bash_profile`" ]; then
    echo '
test -f ~/.bashrc && source ~/.bashrc
source ~/configurations/bash_source_me
' >> ~/.bash_profile
  else
    echo "~/.bash_profile checked."
  fi
fi

