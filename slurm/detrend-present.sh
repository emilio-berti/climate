#!/bin/bash

#SBATCH -J PresentBioclim
#SBATCH --output=/work/%u/climate/present-bioclim.out
#SBATCH --mem-per-cpu=250G
#SBATCH --time=3-00:00:00

#downloaddir="$1"
#outdir="/home/eberti_sta/scratch/climate/present/bioclim"
#module load compiler/gcc/11.1 compiler/gcc/6.5 compiler/gcc/8.3 compiler/intel/19 gdal/3.4.2 hdf5/1.10.5 R/4.0
#Rscript --vanilla \
#  /home/eberti_sta/climate/scripts/bioclim-present.R \
#  "$downloaddir" "$outdir" &&
#  touch "/home/eberti_sta/climate/logs/.present-bioclimed"

outdir="/data/idiv_brose/emilio/climate/present/bioclim"
module load GCC/12.2.0 OpenMPI/4.1.4 R/4.2.2 GDAL/3.6.2
Rscript --vanilla \
  /home/berti/climate/scripts/bioclim-present.R \
  "$outdir" &&
  touch "/home/berti/climate/logs/.present-detrended"

