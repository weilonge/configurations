#!/bin/bash

pp(){
  echo $1
  git checkout $1 && \
  git pull upstream $1 && \
  git push origin $1
}

#pp master
#pp v2.0m
#pp v2.1

while [[ $# > 0 ]]
do
key="$1"
echo '========== '$key' ============'
pp $key
shift
done
