#!/usr/bin/env bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPTPATH/00_checkDir.sh"

changeDirToDesired $dir_data

echo "name,orig,thumb" > $fil_csv

for f in ../img/paintings/*.jpg; do
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    raw=$(readlink -f "$f")
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    raw=$(greadlink -f "$f")
  else
    echo "Unknown OS..." && exit
  fi
  
  filename="${raw##*/}"

  name="${filename%.*}"
  orig="${raw#*"$dir_repo"}"
  thumb="/img/thumb/thumb.${name%-*}.jpg"
  # thumb="/img/thumb/thumb.$name.jpg"
  echo "$name,$orig,$thumb" >> $fil_csv
done