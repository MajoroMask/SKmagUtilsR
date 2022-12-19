#' getcmd_merge_fq
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
#' @export
getcmd_merge_fq <- function(tb,
                            dir_fq,
                            dir_out) {
  tb_out <-
    tb %>%
    tidyr::fill(RUN, .direction = "down") %>%
    transmute(
      run = RUN,
      sample_id = `样本编号`,
      barcode = stringr::str_replace(`Barcode.2.ID`, ".*?(\\d+)$", "\\1")
    ) %>%
    rowwise() %>%
    mutate(
      .fq1_in =
        fs::dir_ls(
          path = fs::path(dir_fq, run),
          recurse = TRUE,
          regexp = glue::glue("{run}_.*_{barcode}_1.fq.gz")
        ) %>%
        list(),
      .fq1_out =
        fs::path(
          a$dir_out,
          glue::glue("{run}_{sample_id}_1.fq.gz")
        ),
      .fq2_in =
        fs::dir_ls(
          path = fs::path(dir_fq, run),
          recurse = TRUE,
          regexp = glue::glue("{run}_.*_{barcode}_2.fq.gz")
        ) %>%
        list(),
      .fq2_out =
        fs::path(
          dir_out,
          glue::glue("{run}_{sample_id}_2.fq.gz")
        )
    ) %>%
    mutate(
      .cmd_merge_fq1 = paste(
        "cat", stringr::str_c(.fq1_in, collapse = " "),
        "1>", .fq1_out
      ),
      .cmd_merge_fq2 = paste(
        "cat", stringr::str_c(.fq2_in, collapse = " "),
        "1>", .fq2_out
      )
    ) %>%
    ungroup()
  return(tb_out)
}
