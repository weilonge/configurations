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
    python-pip \
    curl \
    silversearcher-ag \
    httpie \
    icdiff \
    tig \
    bmon \
    git \
    vim \
    tmux
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='Darwin'
  brew install \
    ffmpeg \
    imagemagick \
    fpp \
    reattach-to-user-namespace \
    terminal-notifier \
    wget \
    youtube-dl \
    the_silver_searcher \
    httpie \
    icdiff \
    tig \
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

# Install dasht
# https://github.com/sunaku/dasht
if [[ "$unamestr" == 'Darwin' ]]; then
  echo "Skip dasht installation."
  # Use
  # git clone git@github.com:sunaku/dasht.git ${TOOLS_DIR}/dasht
  # to install dasht (deprecate: brew install dasht)
  # dasht-docsets-install "^C$"
  # dasht-docsets-install "^C\+\+$"
  # dasht-docsets-install "^Javascript$"
  # dasht-docsets-install "^CSS$"
  # dasht-docsets-install "^HTML$"
  # dasht-docsets-install "^Bash$"
  # dasht-docsets-install "^React$"
  # dasht-docsets-install "^Vim$"
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

# powerline-shell
if [ ! -x "`which powerline-shell`" ]; then
  pip install powerline-shell
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

# npm install -g ydict.js
# npm install -g cambridge-dictionary
# npm install -g tzloc
# npm install -g http-server

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
source ~/configurations/bash_source_me
test -f ~/.bashrc && source ~/.bashrc
' >> ~/.bash_profile
  else
    echo "~/.bash_profile checked."
  fi
fi

