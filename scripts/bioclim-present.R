library(tidyverse)
library(terra)
library(squirrygis)
terraOptions(memmax = 20, todisk = TRUE, tempdir = "/work/berti")
args <- commandArgs(trailingOnly = TRUE)

download_dir <- args[1]
out_dir <- args[2]

ff <- list.files(args[1])
ff <- ff[!grepl("2019|1979", ff)] #missing some months

vars <- c("tas", "tasmin", "tasmax", "pr")
years <- seq(1980, 2018, by = 1)

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

message (" === START ===")

bioclim <- function(y) {
  message( " - Year: ", y)
  # tas 
  f <- ff[grepl("_tas_", ff) & grepl(y, ff)]
  mn <- as.numeric(str_split(f, "_", simplify = TRUE)[, 3])
  tas <-  rast(file.path(download_dir, f[order(mn)]))
  names(tas) <- as.character(1:12)
  tas <- tas / 100

  # tmin
  f <- ff[grepl("_tasmin_", ff) & grepl(y, ff)]
  mn <- as.numeric(str_split(f, "_", simplify = TRUE)[, 3])
  tmin <-  rast(file.path(download_dir, f[order(mn)]))
  names(tmin) <- as.character(1:12)
  tmin <- tmin / 100

  # tmax
  f <- ff[grepl("_tasmax_", ff) & grepl(y, ff)]
  mn <- as.numeric(str_split(f, "_", simplify = TRUE)[, 3])
  tmax <-  rast(file.path(download_dir, f[order(mn)]))
  names(tmax) <- as.character(1:12)
  tmax <- tmax / 100

  # pr
  f <- ff[grepl("pr_", ff) & grepl(y, ff)]
  mn <- as.numeric(str_split(f, "_", simplify = TRUE)[, 3])
  pr <-  rast(file.path(download_dir, f[order(mn)]))
  names(pr) <- as.character(1:12)

  #BIO01(tas, out_dir)
  #BIO02(tmax, tmin, out_dir)
  #BIO03(tmax, tmin, out_dir)
  #BIO04(tas, out_dir)
  #BIO05(tmax, out_dir)
  #BIO06(tmin, out_dir)
  #BIO07(tmax, tmin, out_dir)
  #BIO08(tas, pr, out_dir)
  #BIO09(tas, pr, out_dir)
  #BIO10(tas, out_dir)
  BIO11(tas, out_dir)
  #BIO12(pr, out_dir)
  #BIO13(pr, out_dir)
  #BIO14(pr, out_dir)
  #BIO15(pr, out_dir)
  #BIO16(pr, out_dir)
  #BIO17(pr, out_dir)
  #BIO18(tas, pr, out_dir)
  #BIO19(tas, pr, out_dir)

  rm(tas, tmin, tmax, pr)
  gc(full = TRUE)
}

for (y in years) bioclim(y)

message (" === END ===")

