#!/usr/bin/env bash

# dpkg -s $1 &> /dev/null
# 
# if [ $? -eq 0 ]; then
#     echo "Package  is installed!"
# else
#     echo "Package  is NOT installed!"
# fi

echo "Run 'sudo apt-get install imagemagick' before executing this script!"

dir_repo="RaphaelRaabe.github.io"
dir_data="_data"
dir_paintings="img/paintings/"
dir_cur="$PWD"
fil_csv="paintings.csv"

[[ "$dir_cur" != *"$dir_repo"* ]] && echo "Go to '$dir_repo' repository dir!" && exit

while [[ "${PWD##*/}" != "$dir_repo" ]]; do
  cd ..
done

changeDirToDesired(){
  [ "${PWD##*/}" == "$dir_repo" ] && cd $1
}