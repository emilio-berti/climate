#!/bin/bash

#SBATCH -J PresentDownload
#SBATCH --output=/home/%u/work/climate/present.out
#SBATCH --mem-per-cpu=2G
#SBATCH --time=3-00:00:00
#SBATCH --partition=kbs

urls="/home/eberti_sta/climate/data/urls-present.txt"
outdir="/home/eberti_sta/scratch/climate/present/raw"

bash \
  /home/eberti_sta/climate/scripts/download-present.sh \
  "$urls" "$outdir" &&
  touch "/home/eberti_sta/climate/logs/.present-downloaded"
