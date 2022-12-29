#!/usr/bin/env Rscript

# init ----

suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(openxlsx))
suppressPackageStartupMessages(library(tibble))
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(vroom))
suppressPackageStartupMessages(library(dplyr))

# args ----

arg_from_cmd <-
  list(
    make_option(
      c("--xlsx"),
      help =
        "
        Input XLSX file path.
        Input file should be a .xlsx workbook with the first worksheet
        containing following columns:
        - 'RUN': run id,
        - '样本编号': sample id,
        - 'Barcode 2 ID': barcode id for this sample
        "
    ),
    make_option(
      c("--csv"),
      default = "sample_info.csv"
    )
  ) %>%
  OptionParser(
    usage = "Usage: %prog [options]",
    description =
      "Read XLSX file containing raw data info from MGI seq platform",
    option_list = .
  ) %>%
  parse_args()

# main ----

tb_final <-
  arg_from_cmd$xlsx %>%
  openxlsx::read.xlsx(sheet = 1) %>%
  tibble::as_tibble() %>%
  tidyr::fill(RUN, .direction = "down") %>%
  rename(
    run = 1,
    sample_id = 2,
    barcode = 3
  ) %>%
  mutate(
    barcode = stringr::str_replace(barcode, ".*?(\\d+)$", "\\1")
  ) %>%
  vroom::vroom_write(
    file = arg_from_cmd$csv,
    delim = ",",
    na = ""
  )
