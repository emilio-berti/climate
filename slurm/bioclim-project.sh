#!/bin/bash

#SBATCH -J ProjBio
#SBATCH --output=/work/%u/climate/project-%a.out
#SBATCH --mem-per-cpu=7G
#SBATCH --time=0-01:00:00

biofiles="/home/berti/climate/biofiles.csv"

module load GCC/12.2.0 OpenMPI/4.1.4 R/4.2.2 GDAL/3.6.2

Rscript --vanilla \
  /home/berti/climate/scripts/project-bioclim.R \
  "$biofiles" &&
  touch "/home/berti/climate/logs/.projected"

# sbatch -a 1-$(xsv count $pars) slurm/bioclim-project.sh $pars
