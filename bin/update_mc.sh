#!/bin/bash

git remote -v | grep -q "git@github.com:fx-dev-playground/gecko.git"

if [ "$?" != "0" ];then
  echo "Please check there is a remote for fx-dev-playground/gecko.git"
  exit 1
fi

BRANCH_LIST="fx-team \
inbound \
central \
"

for i in $BRANCH_LIST;do
  echo "==== Let's rebase ${i} ===="
  # git checkout ${i}_default && \
  # git status && \
  git remote update ${i} && \
  git rebase ${i}/default ${i}_default && \
  git push fx-dev-playground HEAD
done

