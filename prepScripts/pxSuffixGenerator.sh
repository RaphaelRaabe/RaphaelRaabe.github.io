echo "Run 'sudo apt-get install imagemagick' before executing this script!"

dir_paintings="img/paintings/"
dir_repo="RaphaelRaabe.github.io"
dir_cur="$PWD"

[ "$dir_cur" == *"$dir_repo"* ] && echo "Go to '$dir_repo' repository dir!" && exit

while [[ "${PWD##*/}" != "$dir_repo" ]]; do
  cd ..
done

[ "${PWD##*/}" == "$dir_repo" ] && cd $dir_paintings

for f in *.jpg; do
  suffix=$(identify -format '%wx%h' "$f")
  mv "$f" "${f%.*}-$suffix.jpg"
done
