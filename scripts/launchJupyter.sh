# This source is for putting pipenv on $PATH

hash pipenv &>/dev/null || source ~/.bash_profile

for i in "$@" ; do echo "$i" ; done

full_path_to_file="$1"
file_name="$(basename "$full_path_to_file")"
path_to_folder="$(dirname "$full_path_to_file")"

log_file="~/testing/Zout.txt"

#echo "1 $full_path_to_file" >> $log_file
#echo "2 $file_name" >> $log_file
#echo "3 $path_to_folder" >> $log_file
#echo $(type pipenv) >> $log_file"

cd "$path_to_folder"

#if [[ $path_to_folder ~= .*\.ipnb ]]; then
#  #statements
#fi

if [[ $2 =~ "Folder" ]]; then
  file_name=""
fi

if pipenv --venv ; then
  #echo "Yey there is a pipenv" >> "$log_file"
  pipenv run jupyter-notebook "$file_name"
else
  #echo "No pipenv found" >> "$log_file"
  jupyter-notebook "$file_name"
fi
