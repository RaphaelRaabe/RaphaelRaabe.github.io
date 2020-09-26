echo "Run 'sudo apt-get install imagemagick' before executing this script!"

dir_paintings="img/paintings/"
dir_repo="RaphaelRaabe.github.io"
dir_cur="$PWD"

[ "$dir_cur" == *"$dir_repo"* ] && echo "Go to '$dir_repo' repository dir!" && exit

while [[ "${PWD##*/}" != "$dir_repo" ]]; do
  cd ..
done

[ "${PWD##*/}" == "$dir_repo" ] && cd $dir_paintings

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
  convert -thumbnail "$w" "$f" "$nf"
done

t="../thumb"
[ -d "$t" ] && rm -rf "$t"
mkdir "$t"
mv thumb*.jpg "$t"
