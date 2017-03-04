#!/bin/bash

# Example of WORKING_LIST_FILE:
#
# seanlee/ContextualFeedback/Bug1317284
# seanlee/DownloadsPanel/Bug812894
# -seanlee/DownloadsPanel/Bug1282662
# seanlee/Password/Bug451955
# -seanlee/Password/Bug1257078
#

# "-" prefix is for rebasing this branch based on the previous line.

set -e

MASTER=central_default
TARGET_REMOTE=fx-dev-playground
WORKING_LIST_FILE=.gitworking
CL_GREEN=`tput setaf 2`
CL_RED=`tput setaf 1`
CL_BLUE=`tput setaf 6`
CL_END=`tput op`

# echo "Let's fetch all changes..."
# git remote update

echo "====> Synchronizing m-c from central to ${TARGET_REMOTE} <===="
git rebase central/default $MASTER
git push $TARGET_REMOTE HEAD
echo ""

for i in `cat ${WORKING_LIST_FILE}`;do
  branchName=`echo $i | sed "s/^[-]*//"`
  echo "====> Working on branch: ["${CL_GREEN}${branchName}${CL_END}"] <===="
  if [[ $i == -* ]]; then
    _currentParent=$parent
  else
    _currentParent=$MASTER
    parent=$branchName
  fi
  echo "                Rebasing ["${branchName}"]"
  echo "                based on ["${CL_BLUE}${_currentParent}${CL_END}"] ..."
  git rebase $_currentParent $branchName
  git push $TARGET_REMOTE HEAD -f
  echo ""
done
