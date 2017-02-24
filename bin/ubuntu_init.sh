#!/bin/sh

sudo apt-get install git vim bmon ssh xclip tmux 

sudo apt-get install \
git-core gnupg flex bison gperf build-essential \
zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
libgl1-mesa-dev libxml2-utils xsltproc unzip openjdk-7-jdk

sudo apt-get install --no-install-recommends \
autoconf2.13 bison bzip2 ccache curl flex gawk gcc g++ g++-multilib \
gcc-4.7 g++-4.7 g++-4.7-multilib git ia32-libs lib32ncurses5-dev lib32z1-dev \
libgconf2-dev zlib1g:amd64 zlib1g-dev:amd64 zlib1g:i386 zlib1g-dev:i386 \
libgl1-mesa-dev libx11-dev make zip lzop libxml2-utils openjdk-7-jdk

sudo apt-get install libfuse-dev

sudo apt-get install clang

sudo apt-get install python-pip

# sudo apt-get install \
# mercurial dos2unix openvpn pcmanx-gtk2 curl filezilla \
# gcc-arm-linux-gnueabi u-boot-tools ncurses-base ncurses-devel \
# libncurses5-dev debootstrap bison flex gettext g++ texinfo \
# synaptic lxde \
# -y

sudo apt-get remove \
onboard gnome-orca rhythmbox transmission-gtk \
gwibber transmission-common gwibber-service \
mahjongg gnome-sudoku gnome-games-data simple-scan shotwell aisleriot \
brasero brasero-cdrkit brasero-common \
-y
