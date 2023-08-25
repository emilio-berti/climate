#!/bin/bash

#SBATCH -J PresentDownload
#SBATCH --output=/work/%u/climate/present-download.out
#SBATCH --mem-per-cpu=2G
#SBATCH --time=3-00:00:00
#SBATCH --partition=transfer

#urls="/home/eberti_sta/climate/data/urls-present.txt"
#outdir="/home/eberti_sta/scratch/climate/present/raw"
#bash \
#  /home/eberti_sta/climate/scripts/download-present.sh \
#  "$urls" "$outdir" &&
#  touch "/home/eberti_sta/climate/logs/.present-downloaded"

urls="/home/berti/climate/data/urls-present.txt"
outdir="/data/idiv_brose/emilio/climate/present/raw"
bash \
  /home/berti/climate/scripts/download-present.sh \
  "$urls" "$outdir" &&
  touch "/home/berti/climate/logs/.present-downloaded"

