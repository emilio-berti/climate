#!/bin/bash

for arg in "$@"
do
  case "$arg" in
    --clean)
      clean=yes
      shift
      ;;
    *)
      break
      ;;
    esac
done

echo " ========= Download and process climate from CHELSA V2 ========= "
if [[ $clean == yes ]]
then
  echo " - Clean run "
fi

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
  #download_dir=/home/eberti_sta/scratch/climate/present/raw
  download_dir=/data/idiv_brose/emilio/climate/present/raw
  biopars=/home/berti/climate/biopars.csv
  bioclim=$(sbatch --parsable $dep_bioclim -a 1-$(xsv count $biopars) slurm/bioclim-present.sh "$download_dir" "$biopars")
else
  echo " - Present already bioclimed"
  bioclim=alreadydone
fi

if [[ $clear == yes ]] || [[ ! -e "logs/.present-detrended.log" ]]
then
  echo " - Detrend present bioclim "
  if [[ $bioclim == alreadydone ]]
  then 
    detr_stats=""
  else
    detr_stats="--dependency=afterok:$bioclim"
  fi
  detr=$(sbatch --parsable $detr_stats slurm/detrend-present.sh)
else 
  echo " - Present already detrended"
  detr=alreadydone
fi

if [[ $clear == yes ]] || [[ ! -e "logs/.present-stats.log" ]]
then
  echo " - Bioclim present statistics "
  if [[ $bioclim == alreadydone ]]
  then 
    dep_stats=""
  else
    dep_stats="--dependency=afterok:$bioclim"
  fi
  data_dir=/data/idiv_brose/emilio/climate/present/bioclim
  stats=$(sbatch --parsable $dep_stats slurm/bioclim-present-stats.sh)
else 
  echo " - Present statistics already calcualted"
  stats=alreadydone
fi

  


