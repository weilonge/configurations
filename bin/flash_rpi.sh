#!/bin/bash

set -e

IMAGE_PATH=$1

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  platform='Linux'
  echo "[ERROR] It does not support Linux yet."
  exit 1
elif [[ "$unamestr" == 'Darwin' ]]; then
  platform='Darwin'
else
  echo "[ERROR] Unknown platform."
  exit 1
fi

if [ ! -f "${IMAGE_PATH}" ]; then
  echo "[ERROR] Exit for no image available."
  exit 1
fi

diskutil list

printf "Please enter the device node you want to flash (e.g. disk2): "
read disk_node

if [ ${disk_node} == "disk0" ] || [ ${disk_node} == "disk1" ]; then
  echo "[ERROR] Exit for flashing the system disk."
  exit 1
else
  if [ ! -b "/dev/${disk_node}" ]; then
    echo "[ERROR] Uknown disk node."
    exit 1
  fi
fi

printf "Which kind of method to write? (e.g. direct, 7z) "
read write_method

echo "Start to write ${IMAGE_PATH} to ${disk_node}..."

diskutil unmountDisk /dev/${disk_node}


echo "Note: Use 'sudo pkill -INFO -x dd' to check progress"

if [ ${write_method} == "direct" ]; then
  sudo dd bs=4m if=${IMAGE_PATH} of=/dev/r${disk_node}
elif [ ${write_method} == "7z" ];then
  7z x -so ${IMAGE_PATH} | sudo dd bs=4m of=/dev/r${disk_node}
else
  echo "Invalid writing method given."
fi

