library(tidyverse)
library(terra)
library(squirrygis)
terraOptions(memmax = 100, todisk = TRUE, tempdir = "/work/berti", progress = 0)
args <- commandArgs(trailingOnly = TRUE)

datadir <- args[1]
ff <- list.files(args[1])
ff <- ff[!grepl("2019|1979", ff)] #missing some months

bios <- c(
  paste0("BIO0", 1:9),
  paste0("BIO", 10:19
)
years <- seq(1980, 2018, by = 1)

message (" === START ===")

biostats <- function(bio) {
  message( " - ", bio)
  f <- ff[grepl("bio", ff)
  r <- rast(file.path(datadir, f))
  mu <- mean(r)
  va <- app(r, var)
  writeRaster(
	mu, 
	file.path(datadir, paste0(bio, "-mean.tif")), 
	overwrite = TRUE
  )
  writeRaster(
	va,
	file.path(datadir, paste0(bio, "-variance.tif")), 
	overwrite = TRUE
  )
}

for (bio in bios) biostats(bio)

message (" === END ===")

