#!/bin/bash

set -e

cd ~
git clone https://github.com/weilonge/configurations.git 
git clone https://github.com/weilonge/dotvim.git ~/.vim

ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/configurations/tmux.conf ~/.tmux.conf

if [[ $platform == 'Linux' ]]; then
    sudo apt-get install vim tmux xclip bmon
elif [[ $platform == 'Darwin' ]]; then
    brew install reattach-to-user-namespace bmon tmux vim git fpp youtube-dl
fi

git config --global core.editor vim
git config --global core.excludesfile ~/configurations/git/gitignore_global

TOOLS_DIR=~/Projects/tools
mkdir -p ${TOOLS_DIR}

# powerline-shell
git clone https://github.com/milkbikis/powerline-shell ${TOOLS_DIR}
# Copy config.py.dist to config.py and edit it to configure the segments you
# want. Then run
cd ${TOOLS_DIR}/powerline-shell
./install.py
ln -s ${TOOLS_DIR}/powerline-shell/powerline-shell.py ~/bin/powerline-shell.py

# powerline-fonts
git clone https://github.com/powerline/fonts.git ${TOOLS_DIR}/powerline-fonts
cd ${TOOLS_DIR}/powerline-fonts
./install.sh

# Install NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

#Run PlugInstall in vim 

