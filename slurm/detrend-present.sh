#!/bin/bash

#SBATCH -J PrBioDetr
#SBATCH --output=/work/%u/climate/present-detrend.out
#SBATCH --mem-per-cpu=50G
#SBATCH --time=0-06:00:00

module load GCC/12.2.0 OpenMPI/4.1.4 R/4.2.2 GDAL/3.6.2

outdir="/data/idiv_brose/emilio/climate/present/bioclim/projected"

Rscript --vanilla \
  /home/berti/climate/scripts/detrend-bioclim.R \
  "$outdir" &&
  touch "/home/berti/climate/logs/.present-detrended"

