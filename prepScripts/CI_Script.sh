#!/usr/bin/env bash

echo "Run 'sudo apt-get install imagemagick' before executing this script!"
# montage -geometry +0+0 -mode Concatenate -tile x6 thumb.00-*.jpg result.jpg

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

############################################
changeDirToDesired $dir_paintings
echo "1. Reducing image sizes to 1920px"
for f in *.{jpg,jpeg}; do
    width=$(identify -format '%w' "$f")
    height=$(identify -format '%h' "$f")
    if [ $width -gt 1920 ] && [ $height -gt 1920 ]; then
      [ $width -ge $height ] && convert -thumbnail "1920" "$f" "$f" || convert -thumbnail "x1920" "$f" "$f"
    fi
done

############################################
echo "2. Generating suffixes for image files"
for f in *.{jpg,jpeg}; do
  nf="${f%-*}";
  [ "$f" != "$nf" ] && mv "$f" "$nf" && mv "$nf" "$nf.jpg";
done
for f in *.{jpg,jpeg}; do
  suffix=$(identify -format '%wx%h' "$f")
  mv "$f" "${f%.*}-$suffix.jpg"
done

############################################
echo "3. Generating thumbnails"
dir_thumb="../thumb"
[ -d "$dir_thumb" ] && rm -rf "$dir_thumb"
mkdir "$dir_thumb"
w=200
for f in *.{jpg,jpeg}; do
  nf="thumb.${f%-*}.jpg"
  convert -thumbnail "$w" "$f" "$nf" && mv $nf "$dir_thumb/"
done

############################################
changeDirToDesired "../../$dir_data"
echo "4. Writing paintigs.csv-file"
echo "name,orig,thumb" > $fil_csv
for f in ./*.{jpg,jpeg}; do
  # raw=$(readlink -f "$f") ##### <- LINUX
  raw=$(greadlink -f "$f") ##### <- MAC
  filename="${raw##*/}"
  name="${filename%.*}"
  orig="${raw#*"$dir_repo"}"
  thumb="/img/thumb/thumb.${name%-*}.jpg"
  # thumb="/img/thumb/thumb.$name.jpg"
  echo "$name,$orig,$thumb" >> $fil_csv
done
