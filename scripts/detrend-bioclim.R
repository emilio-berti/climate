library(tidyverse)
library(terra)
library(squirrygis)
terraOptions(memmax = 100, todisk = TRUE, tempdir = "/data/idiv_brose/emilio/tmp", progress = 0)
args <- commandArgs(trailingOnly = TRUE)

out_dir <- args[1]

# detrend function ----------
detrend <- function(r) {
  years <- gsub("[A-Za-z]", "", names(r))
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
  ff <- list.files(file.path(outdir, "climate"), pattern = bio)
  years <- gsub(paste0(bio, "-|[.]tif"), "", ff)
  r <- stack(file.path(outdir, "climate", ff[order(as.numeric(years))]))
  names(r) <- sort(as.numeric(years))
  r <- detrend(r)
  writeRaster(r, file.path(outdir, paste0(bio, "-detrended.tif")), overwrite = TRUE)
  gc(full = TRUE)
}
message(" === END PROCEDURE ===")

