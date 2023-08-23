#!/bin/bash

#SBATCH -J PresentBioclim
#SBATCH --output=/home/%u/work/climate/present-bioclim.out
#SBATCH --mem-per-cpu=100G
#SBATCH --time=3-00:00:00
#SBATCH --partition=kbs

downloaddir="$1"
outdir="/home/eberti_sta/scratch/climate/present/bioclim"

module load compiler/gcc/11.1 compiler/gcc/6.5 compiler/gcc/8.3 compiler/intel/19 gdal/3.4.2 hdf5/1.10.5 R/4.0

Rscript --vanilla \
  /home/eberti_sta/climate/scripts/bioclim-present.R \
  "$downloaddir" "$outdir" &&
  touch "/home/eberti_sta/climate/logs/.present-bioclimed"
