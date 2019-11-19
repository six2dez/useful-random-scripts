#! /usr/bin/env bash

# This script iterate over every subfolder where is executed and put the lastest master version.

for dir in ./*/
do
  cd ${dir}
  git status >/dev/null 2>&1
  # check if exit status of above was 0, indicating we're in a git repo
  [ $(echo $?) -eq 0 ] && echo "Updating ${dir%*/}..." && git fetch --all && git reset --hard origin/master

  cd ..
done
