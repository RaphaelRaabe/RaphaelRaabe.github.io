#!/usr/bin/env bash

SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source "$SCRIPTPATH/00_checkDir.sh"

changeDirToDesired $dir_paintings

for f in *.jpg; do
  nf="${f%-*}";
  [ "$f" != "$nf" ] && mv "$f" "$nf" && mv "$nf" "$nf.jpg";
done

for f in *.jpg; do
  suffix=$(identify -format '%wx%h' "$f")
  mv "$f" "${f%.*}-$suffix.jpg"
done
