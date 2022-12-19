
renv::init()
renv::install("BiocManager@1.30.16")
chooseBioCmirror()
options(repos = BiocManager::repositories())
renv::snapshot(type = "simple")

pkgs_needed <- c(
  "rlang",
  "dplyr",
  "readr",
  "tidyr",
  "stringr",
  "purrr",
  "tibble",
  "ggplot2",
  "lubridate",
  "fs",

  "optparse",
  "openxlsx",
  "glue",
  "future",
  "furrr",

  "rmarkdown",
  "devtools",
  "usethis",
  "testthat"
)

renv::install(packages = pkgs_needed)
