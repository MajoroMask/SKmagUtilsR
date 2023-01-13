#' organize_fastqc_zip
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @export
organize_fastqc_zip <- function(sample, reads, type, path) {
  requireNamespace("dplyr", quietly = TRUE)

  suffix <- dplyr::if_else(type == "trimmed", ".trimmed", "")
  dir_in_zip <-
    stringr::str_glue("{sample}{suffix}_{reads}_fastqc")
  # raw: "L01_1_fastqc"
  # trimmed: "L01.trimmed_1_fastqc"

  path_in_zip <-
    c(
      stringr::str_glue("{dir_in_zip}/fastqc_data.txt"),
      stringr::str_glue("{dir_in_zip}/summary.txt")
    )
  path_output <- stringr::str_glue("{sample}_{reads}_{type}") %>% fs::path()

  utils::unzip(
    zipfile = path,
    files = path_in_zip,
    exdir = path_output,
    junkpaths = TRUE
  )
  tb_basic_stat <-
    fs::path(path_output, "fastqc_data.txt") %>%
    read_fastqc_basic_stat()
  tb_summary <-
    fs::path(path_output, "summary.txt") %>%
    read_fastqc_summary()

  tb_out <- dplyr::bind_cols(tb_basic_stat, tb_summary)
  return(tb_out)
}

# utils ----

read_fastqc_summary <- function(file) {
  tb_out <-
    file %>%
    readr::read_lines() %>%
    stringr::str_split(pattern = "\\t", simplify = TRUE) %>%
    as.data.frame() %>%
    mutate(
      V2 =
        V2 %>%
        stringr::str_to_lower() %>%
        stringr::str_replace_all(pattern = " ", replacement = "_"),
      V3 = NULL
    ) %>%
    tibble::column_to_rownames(var = "V2") %>%
    as.matrix() %>%
    t() %>%
    tibble::as_tibble()
  return(tb_out)
}

read_fastqc_basic_stat <- function(file) {
  tb_out <-
    file %>%
    readr::read_lines() %>%
    `[`(
      (which(stringr::str_detect(., "^>>Basic Statistics")) + 3):
        (min(which(stringr::str_detect(., "^>>END_MODULE$"))) - 1)
    ) %>%
    stringr::str_split(pattern = "\\t", simplify = TRUE) %>%
    as.data.frame() %>%
    mutate(
      V1 =
        V1 %>%
        stringr::str_to_lower() %>%
        stringr::str_replace_all(pattern = " ", replacement = "_")
    ) %>%
    tibble::column_to_rownames(var = "V1") %>%
    as.matrix() %>%
    t() %>%
    tibble::as_tibble()
  return(tb_out)
}
