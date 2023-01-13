#' organize_fastp_json
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @export
organize_fastp_json <- function(json,
                                col_split = ".",
                                dump_cols_keyworkds = NULL) {
  requireNamespace("tidyjson", quietly = TRUE)
  requireNamespace("stringr", quietly = TRUE)
  requireNamespace("dplyr", quietly = TRUE)
  requireNamespace("forcats", quietly = TRUE)

  if (is.null(dump_cols_keyworkds)) {
    dump_cols_keyworkds <- paste(
      "histogram",
      "_adapter_counts",
      "quality_curves",
      "content_curves",
      "kmer_count",
      "overrepresented_sequences",
      sep = "|"
    )
  }

  tb_json <-
    tidyjson::read_json(json) %>%
    tidyjson::spread_all(sep = col_split) %>%
    select(!dplyr::matches(dump_cols_keyworkds, ignore.case = TRUE)) %>%
    as_tibble() %>%
    select(-document.id)

  sorted_colnames <-
    tibble(ori = colnames(tb_json)) %>%
    mutate(
      split_col = stringr::str_split(ori, pattern = stringr::fixed(col_split))
    ) %>%
    rowwise() %>%
    mutate(
      x = split_col[1] %>% forcats::fct_inorder(),
      y = split_col[2] %>% forcats::fct_inorder(),
      z = split_col[3] %>% forcats::fct_inorder()
    ) %>%
    arrange(x, y, z) %>%
    pull(ori)
  tb_output <- tb_json %>% select(all_of(sorted_colnames))

  return(tb_output)
}
