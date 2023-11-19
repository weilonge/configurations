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
    httpie \
    icdiff
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='Darwin'
  brew install \
    ffmpeg \
    imagemagick \
    httpie \
    icdiff
else
  echo "[ERROR] Unknown platform."
  exit 1
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

npm install -g ydict.js
npm install -g camdict
ln -s $CONFIG_DIR/bin/yd $HOME/bin/ydict.js
npm install -g cambridge-dictionary
npm install -g tzloc
npm install -g http-server

