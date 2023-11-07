library(tidyverse)
library(terra)

terraOptions(
  memmax = 100,
  tempdir = "/work/berti/climate"
)

args <- commandArgs(trailingOnly = TRUE)
outdir <- args[1]

# detrend function ----------
detrend <- function(r) {
  years <- gsub("[A-Za-z]", "", names(r))
  years <- gsub("-", "", years)
  d <- r %>% 
    values() %>% 
    as_tibble() %>% 
    rownames_to_column(var = "cell") %>%
    drop_na() %>% 
    pivot_longer(cols = !contains("cell"), names_to = "year") %>% 
    mutate(year = as.numeric(gsub("[A-Za-z]", "", year))) %>% 
    nest(.by = cell)
  detr <- d %>% 
    mutate(
      trend = lapply(data, function(data) lm(value ~ year, data = data)),
      resid = lapply(trend, function(model) tibble(year = years, resid = resid(model))),
      avg = sapply(data, function(data) mean(data[["value"]]))
    ) %>% 
    select(cell, resid, avg) %>% 
    unnest(cols = resid) %>% 
    mutate(detrended = resid + avg) %>% 
    transmute(
      cell = as.numeric(cell),
      year, 
      detrended
    ) %>% 
    pivot_wider(names_from = year, values_from = detrended)
  values(r)[ detr[["cell"]], ] <- detr %>% select(-cell) %>% as.matrix()
  return (r)
}

# climate -------------
message(" === START PROCEDURE === ")
bios <- c("BIO01", "BIO10", "BIO11", "BIO12", "BIO16", "BIO17")
for (bio in bios) {
  message("     - ", bio)
  ff <- list.files(outdir, pattern = bio)
  years <- gsub(paste0("-", bio, "[.]tif"), "", ff)
  message("       - load files")
  r <- rast(file.path(outdir, ff[order(as.numeric(years))]))
  names(r) <- sort(as.numeric(years))
  message("       - detrend")
  r <- detrend(r)
  message("       - write to file")
  writeRaster(r, file.path(outdir, paste0(bio, "-detrended.tif")), overwrite = TRUE)
}
message(" === END PROCEDURE ===")

