dir_data="_data"
dir_repo="RaphaelRaabe.github.io"
dir_cur="$PWD"

[ "$dir_cur" == *"$dir_repo"* ] && echo "Go to '$dir_repo' repository dir!" && exit

while [[ "${PWD##*/}" != "$dir_repo" ]]; do
  cd ..
done

[ "${PWD##*/}" == "$dir_repo" ] && cd $dir_data