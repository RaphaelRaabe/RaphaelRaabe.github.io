#!/usr/bin/env bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPTPATH/00_checkDir.sh"

changeDirToDesired $dir_paintings

echo -e "Thumbnail width?\n-----------------------"
read w
echo "-----------------------"

while [[ -n ${w//[0-9]/} ]]; do
  echo "Only numbers allowed!"
  read  "Thumbnail width? " w
  while [[ $w -lt 50 || $w -gt 500 ]]; do
    echo "Only 50 to 500px allowed!"
    read  "Thumbnail width? " w
  done
done

for f in *.jpg; do
  nf="thumb.${f%-*}.jpg"
# nf="thumb.$f"
  convert -thumbnail "$w" "$f" "$nf"
done

t="../thumb"
[ -d "$t" ] && rm -rf "$t"
mkdir "$t"
mv thumb*.jpg "$t"
