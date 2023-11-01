#!/bin/bash

#SBATCH -J PrBioStats
#SBATCH --output=/work/%u/climate/present-bioclim-stats.out
#SBATCH --mem-per-cpu=100G
#SBATCH --time=3-00:00:00

datadir="/data/idiv_brose/emilio/climate/present/bioclim"
module load GCC/12.2.0 OpenMPI/4.1.4 R/4.2.2 GDAL/3.6.2
Rscript --vanilla \
  /home/berti/climate/scripts/bioclim-stats.R \
  "$datadir" &&
  touch "/home/berti/climate/logs/.present-stats.log"

