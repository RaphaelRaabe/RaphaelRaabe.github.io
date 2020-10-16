#!/usr/bin/env bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPTPATH/00_checkDir.sh"

changeDirToDesired $dir_paintings
dir_thumb="../thumb"
[ ! -d "$dir_thumb" ] && mkdir "$dir_thumb" && echo "thumb directory created"

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

b_generate_all_thumbs=true
while true; do
  read -p "Generate thumbnail for ALL paintings? " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    b_generate_all_thumbs=true; break;
  elif [[ $REPLY =~ ^[Nn]$ ]]; then
    b_generate_all_thumbs=false; break;
  else
    echo "Please answer [Y]es or [N]o!";
  fi
done

if [ "$b_generate_all_thumbs" = true ]; then
  for f in *.jpg; do
    nf="thumb.${f%-*}.jpg"
  # nf="thumb.$f"
    convert -thumbnail "$w" "$f" "$nf" && mv $nf "$dir_thumb/"
  done
elif [ "$b_generate_all_thumbs" = false ]; then
  for f in *.jpg; do
    nf="thumb.${f%-*}.jpg"
  # nf="thumb.$f"
    [ ! -f "$dir_thumb/$nf" ] && convert -thumbnail "$w" "$f" "$nf" && mv $nf "$dir_thumb/"
  done
else
 echo "something went wrong in thumbnailGenerator!" && exit
fi