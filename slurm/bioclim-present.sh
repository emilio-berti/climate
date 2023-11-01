#!/bin/bash

#SBATCH -J PresentBioclim
#SBATCH --output=/work/%u/climate/present-bioclim-%a.out
#SBATCH --mem-per-cpu=10G
#SBATCH --time=0-02:00:00

downloaddir="$1"
pars="$2"
outdir="/data/idiv_brose/emilio/climate/present/bioclim"

module load GCC/12.2.0 OpenMPI/4.1.4 R/4.2.2 GDAL/3.6.2

Rscript --vanilla \
  /home/berti/climate/scripts/bioclim-present.R \
  "$downloaddir" "$outdir" "$pars" &&
  touch "/home/berti/climate/logs/.present-bioclimed"

# sbatch -a 1-$(xsv count $pars) bioclim-present.sh $pars