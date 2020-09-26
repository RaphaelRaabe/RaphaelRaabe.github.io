dir_data="_data"
dir_repo="RaphaelRaabe.github.io"
dir_cur="$PWD"

[ "$dir_cur" == *"$dir_repo"* ] && echo "Go to '$dir_repo' repository dir!" && exit

while [[ "${PWD##*/}" != "$dir_repo" ]]; do
  cd ..
done

[ "${PWD##*/}" == "$dir_repo" ] && cd $dir_data

echo "name,orig,thumb" > paintings.csv

for f in ../img/paintings/*; do
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
  echo "$name,$orig,$thumb" >> paintings.csv
done