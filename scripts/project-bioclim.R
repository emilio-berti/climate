library(terra)
terraOptions(
  memmax = 6,
  tempdir = "/work/berti/climate"
)

task <- as.integer(Sys.getenv("SLURM_ARRAY_TASK_ID"))
args <- commandArgs(trailingOnly = TRUE)
biofiles <- args[1]
file <- read.csv(biofiles)
file <- file[["file"]][task]
message(" - ", file)

# target raster ----------
am <- vect("/home/berti/climate/templates/america.shp")
templ <- rast(
  res = 5e3, 
  crs = crs(am, proj = TRUE),
  ext = ext(am)
)
templ <- rasterize(am, templ)

# source raster -------------
outfile <- gsub("bioclim", "bioclim/projected", file)
message(" - ", outfile)

message(" === START === ")
r <- rast(file)
r <- crop(r, project(am, r))
r <- project(r, templ)
r <- mask(r, templ)
writeRaster(r, outfile, overwrite = TRUE)
message(" === END === ")

