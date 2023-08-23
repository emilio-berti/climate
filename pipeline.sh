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

if [[ $clear == yes ]] || [[ ! -e "logs/.present-bioclimed" ]]
then
  echo " - Bioclim present climate "
  if [[ $download == alreadydone ]]
  then
    dep_bioclim=""
  else
    dep_bioclim="--dependency=afterok:$download"
  fi
  download_dir=/home/eberti_sta/scratch/climate/present/raw
  bioclim=$(sbatch --parsable $dep_bioclim slurm/bioclim-present.sh "$download_dir")
else
  echo " - Present already bioclimed"
  bioclim=alreadydone
fi

