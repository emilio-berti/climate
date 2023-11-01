years <- seq(1980, 2018)
bios <- paste0("BIO", c(paste0("0", seq_len(9)), seq(10, 19)))

d <- expand.grid(years, bios)
names(d) <- c("year", "bio")
d[["task"]] <- seq_len(nrow(d))
d <- d[, c("task", "year", "bio")]

write.csv(d, "biopars.csv", row.names = FALSE)
