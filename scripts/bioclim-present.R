library(tidyverse)
library(raster)
library(squirrygis)
rasterOptions(
  maxmemory = 200e9,
  tmpdir = "/work/berti/climate",
  progress = ""
)
args <- commandArgs(trailingOnly = TRUE)
"%out%" <- Negate("%in%")
download_dir <- args[1]
out_dir <- args[2]
pars <- args[3]

pars <- read.csv(pars)
task <- as.integer(Sys.getenv("SLURM_ARRAY_TASK_ID"))
year <- pars[task, "year"]
bio <- pars[task, "bio"]

ff <- list.files(download_dir)
ff <- ff[grepl(year, ff)] #missing some months

BIO01 <- function(tas, out_dir) {
  message("   - bio01")
  b1 <- bio01(tas)
  writeRaster(b1, file.path(out_dir, paste0(y, "-BIO01.tif")), overwrite = TRUE)
}

BIO02 <- function(tmax, tmin, out_dir) {
  message("   - bio02") 
  b2 <- bio02(tmax, tmin)
  writeRaster(b2, file.path(out_dir, paste0(y, "-BIO02.tif")), overwrite = TRUE)
}

BIO03 <- function(tmax, tmin, out_dir) {
  message("   - bio03") 
  b3 <- bio03(tmax, tmin)
  writeRaster(b3, file.path(out_dir, paste0(y, "-BIO03.tif")), overwrite = TRUE)
}

BIO04 <- function(tas, out_dir) {
  message("   - bio04")
  b4 <- bio04(tas)
  writeRaster(b4, file.path(out_dir, paste0(y, "-BIO04.tif")), overwrite = TRUE)
}

BIO05 <- function(tmax, out_dir) {
  message("   - bio05")
  b5 <- bio05(tmax)
  writeRaster(b5, file.path(out_dir, paste0(y, "-BIO05.tif")), overwrite = TRUE)
}

BIO06 <- function(tmin, out_dir) {
  message("   - bio06")
  b6 <- bio06(tmin)
  writeRaster(b6, file.path(out_dir, paste0(y, "-BIO06.tif")), overwrite = TRUE)
}

BIO07 <- function(tmax, tmin, out_dir) {
  message("   - bio07")
  b7 <- bio07(tmax, tmin)
  writeRaster(b7, file.path(out_dir, paste0(y, "-BIO07.tif")), overwrite = TRUE)
}

BIO08 <- function(tas, pr, out_dir) {
  message("   - bio08")
  b8 <- bio08(tas, pr)
  writeRaster(b8, file.path(out_dir, paste0(y, "-BIO08.tif")), overwrite = TRUE)
}

BIO09 <- function(tas, pr, out_dir) {  
  message("   - bio09")
  b9 <- bio09(tas, pr)
  writeRaster(b9, file.path(out_dir, paste0(y, "-BIO09.tif")), overwrite = TRUE)
}

BIO10 <- function(tas, out_dir) {
  message("   - bio10")
  b10 <- bio10(tas)
  writeRaster(b10, file.path(out_dir, paste0(y, "-BIO10.tif")), overwrite = TRUE)
}

BIO11 <- function(tas, out_dir) {
  message("   - bio11")
  b11 <- bio11(tas)
  writeRaster(b11, file.path(out_dir, paste0(y, "-BIO11.tif")), overwrite = TRUE)
}

BIO12 <- function(pr, out_dir) {
  message("   - bio12")
  b12 <- bio12(pr)
  writeRaster(b12, file.path(out_dir, paste0(y, "-BIO12.tif")), overwrite = TRUE)
}

BIO13 <- function(pr, out_dir){
  message("   - bio13")
  b13 <- bio13(pr)
  writeRaster(b13, file.path(out_dir, paste0(y, "-BIO13.tif")), overwrite = TRUE)
}

BIO14 <- function(pr, out_dir){
  message("   - bio14")
  b14 <- bio14(pr)
  writeRaster(b14, file.path(out_dir, paste0(y, "-BIO14.tif")), overwrite = TRUE)
}
 
BIO15 <- function(pr, out_dir) {
  message("   - bio15")
  b15 <- bio15(pr)
  writeRaster(b15, file.path(out_dir, paste0(y, "-BIO15.tif")), overwrite = TRUE)
}

BIO16 <- function(pr, out_dir) {
  message("   - bio16")
  b16 <- bio16(pr)
  writeRaster(b16, file.path(out_dir, paste0(y, "-BIO16.tif")), overwrite = TRUE)
}

BIO17 <- function(pr, out_dir) {
  message("   - bio17")
  b17 <- bio17(pr)
  writeRaster(b17, file.path(out_dir, paste0(y, "-BIO17.tif")), overwrite = TRUE)
}

BIO18 <- function(tas, pr, out_dir) {
  message("   - bio18")
  b18 <- bio18(tas, pr)
  writeRaster(b18, file.path(out_dir, paste0(y, "-BIO18.tif")), overwrite = TRUE)
}

BIO19 <- function(tas, pr, out_dir) {
  message("   - bio19")
  b19 <- bio19(tas, pr)
  writeRaster(b19, file.path(out_dir, paste0(y, "-BIO19.tif")), overwrite = TRUE)
}

# tas --------------
load_tas <- function(ff, year) {
  message("    - Load tas")
  f <- ff[grepl("_tas_", ff) & grepl(year, ff)]
  mn <- as.numeric(str_split(f, "_", simplify = TRUE)[, 3])
  tas <-  stack(file.path(download_dir, f[order(mn)]))
  tas <- stack(tas / 100)
  names(tas) <- as.character(1:12)
  return (tas)
}

# tmin ---------------
load_tmin <- function(ff, year) {
  message("    - Load tmin")
  f <- ff[grepl("_tasmin_", ff) & grepl(year, ff)]
  mn <- as.numeric(str_split(f, "_", simplify = TRUE)[, 3])
  tmin <-  stack(file.path(download_dir, f[order(mn)]))
  tmin <- stack(tmin / 100)
  names(tmin) <- as.character(1:12)
  return (tmin)
}

# tmax ---------------
load_tmax <- function(ff, year) {
  message("    - Load tmax")
  f <- ff[grepl("_tasmax_", ff) & grepl(year, ff)]
  mn <- as.numeric(str_split(f, "_", simplify = TRUE)[, 3])
  tmax <-  stack(file.path(download_dir, f[order(mn)]))
  tmax <- stack(tmax / 100)
  names(tmax) <- as.character(1:12)
  return (tmax)
}

# pr ---------------
load_pr <- function(ff, year) {
  message("    - Load pr")
  f <- ff[grepl("pr_", ff) & grepl(year, ff)]
  mn <- as.numeric(str_split(f, "_", simplify = TRUE)[, 3])
  pr <-  stack(file.path(download_dir, f[order(mn)]))
  names(pr) <- as.character(1:12)
  return (pr)
}

message (" === START ===")

bioclim <- function(y, b) {
  message( " - Year: ", y)
  message( " - BIO: ", b)

  if (b == "BIO01") {
    tas <- load_tas(ff, y)
    BIO01(tas, out_dir)
  }

  if (b == "BIO02") {
    tmin <- load_tmin(ff, y)
    tmax <- load_tmax(ff, y)
    BIO02(tmax, tmin, out_dir)
  }

  if (b == "BIO03") {
    tmin <- load_tmin(ff, y)
    tmax <- load_tmax(ff, y)
    BIO03(tmax, tmin, out_dir)
  }

  if (b == "BIO04") {
    tas <- load_tas(ff, y)
    BIO04(tas, out_dir)
  }

  if (b == "BIO05") {
    tmax <- load_tmax(ff, y)
    BIO05(tmax, out_dir)
  }

  if (b == "BIO06") {
    tmin <- load_tmin(ff, y)
    BIO06(tmin, out_dir)
  }

  if (b == "BIO07") {
    tmin <- load_tmin(ff, y)
    tmax <- load_tmax(ff, y)
    BIO07(tmax, tmin, out_dir)
  }  

  if (b == "BIO08") {
    tas <- load_tas(ff, y)
    pr <- load_pr(ff, y)
    BIO08(tas, pr, out_dir)
  }

  if (b == "BIO09") {
    tas <- load_tas(ff, y)
    pr <- load_pr(ff, y)
    BIO09(tas, pr, out_dir)
  }

  if (b == "BIO10") {
    tas <- load_tas(ff, y)
    BIO10(tas, out_dir)
  }

  if (b == "BIO11") {
    tas <- load_tas(ff, y)
    BIO11(tas, out_dir)
  }

  if (b == "BIO12") {
    pr <- load_pr(ff, y)
    BIO12(pr, out_dir)
  }

  if (b == "BIO13") {
    pr <- load_pr(ff, y)
    BIO13(pr, out_dir)
  }

  if (b == "BIO14") {
    pr <- load_pr(ff, y)
    BIO14(pr, out_dir)
  }

  if (b == "BIO15") {
    pr <- load_pr(ff, y)
    BIO15(pr, out_dir)
  }

  if (b == "BIO16") {
    pr <- load_pr(ff, y)
    BIO16(pr, out_dir)
  }

  if (b == "BIO17") {
    pr <- load_pr(ff, y)
    BIO17(pr, out_dir)
  }

  if (b == "BIO18") {
    tas <- load_tas(ff, y)
    pr <- load_pr(ff, y)
    BIO18(tas, pr, out_dir)
  }

  if (b == "BIO19") {
    tas <- load_tas(ff, y)
    pr <- load_pr(ff, y)
    BIO19(tas, pr, out_dir)
  }

}

bioclim(year, bio)

message (" === END ===")
