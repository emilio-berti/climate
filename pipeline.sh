#!/bin/bash

for arg in "$@"
do
  case "$arg" in
    --clean=)
      clean=yes
      shift
      ;;
    *)
      break
      ;;
    esac
done

echo " ========= Download and process climate from CHELSA V2 ========= "
echo " - Clean run "

if [[ $clean == yes ]] || [[ ! -e "logs/.present-downloaded" ]]
then
  echo " - Download present climate "
  download=$(sbatch --parsable slurm/download-present.sh)
else
  echo " - Present already downloaded"
  download=alreadydone
fi

