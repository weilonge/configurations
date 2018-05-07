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

MASTER=develop
TARGET_REMOTE=origin
UPSTREAM=upstream
WORKING_LIST_FILE=.gitworking
CL_GREEN=`tput setaf 2`
CL_RED=`tput setaf 1`
CL_BLUE=`tput setaf 6`
CL_END=`tput op`

# echo "Let's fetch all changes..."
# git remote update

# grep "^@" $WORKING_LIST_FILE | while read -r line; do
#   CCC=`echo $line | sed 's/^@//'`
#   echo "[Config] $CCC"
#   eval $CCC
# done

# echo $MASTER
# echo $TARGET_REMOTE

# exit

echo "====> Synchronizing ${UPSTREAM} to ${TARGET_REMOTE} <===="
git rebase ${UPSTREAM}/${MASTER} ${MASTER}
# git push $TARGET_REMOTE HEAD
echo ""

while IFS= read -r line; do
  set +e
  COMMENT=`echo $line | grep "^#"`
  if [ -n "${COMMENT}" ]; then
    echo "$line"
    continue
  fi
  CONFIG=`echo $line | grep "^@"`
  if [ -n "${CONFIG}" ]; then
    echo "[Config] "`echo $line | sed 's/^@//'`
    continue
  fi
  set -e
  branchName=`echo $line | awk '{print $1}'`
  _currentParent=`echo $line | awk '{print $2}'`
  if [ -z "${_currentParent}" ]; then
    _currentParent=$MASTER
  fi
  echo "====> Working on branch: ["${CL_GREEN}${branchName}${CL_END}"] <===="
  echo "                Rebasing ["${branchName}"]"
  echo "                based on ["${CL_BLUE}${_currentParent}${CL_END}"] ..."
  echo "Commit List:"
  for echoCommitHash in `git log ${_currentParent}..${branchName} --pretty=format:"%H" --no-patch --reverse`; do
    echo "HASH: "$echoCommitHash
  done
  echo "============"
  git rebase $_currentParent $branchName
  # git push $TARGET_REMOTE HEAD -f
done <"$WORKING_LIST_FILE"

