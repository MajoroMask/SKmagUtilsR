#' organize_fastp_json
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @export
organize_fastp_json <- function(json) {
                                # col_split = ".",
                                # dump_cols_keyworkds = NULL) {
  requireNamespace("tidyjson", quietly = TRUE)
  requireNamespace("stringr", quietly = TRUE)
  requireNamespace("dplyr", quietly = TRUE)
  requireNamespace("forcats", quietly = TRUE)

  # if (is.null(dump_cols_keyworkds)) {
  #   dump_cols_keyworkds <- paste(
  #     "histogram",
  #     "_adapter_counts",
  #     "quality_curves",
  #     "content_curves",
  #     "kmer_count",
  #     "overrepresented_sequences",
  #     sep = "|"
  #   )
  # }

  # tb_json <-
  #   tidyjson::read_json(json) %>%
  #   tidyjson::spread_all(sep = col_split) %>%
  #   select(!dplyr::matches(dump_cols_keyworkds, ignore.case = TRUE)) %>%
  #   as_tibble() %>%
  #   select(-document.id)
  # sorted_colnames <-
  #   tibble(ori = colnames(tb_json)) %>%
  #   mutate(
  #     split_col = stringr::str_split(ori, pattern = stringr::fixed(col_split))
  #   ) %>%
  #   rowwise() %>%
  #   mutate(
  #     x = split_col[1] %>% forcats::fct_inorder(),
  #     y = split_col[2] %>% forcats::fct_inorder(),
  #     z = split_col[3] %>% forcats::fct_inorder()
  #   ) %>%
  #   arrange(x, y, z) %>%
  #   pull(ori)
  # tb_output <- tb_json %>% select(all_of(sorted_colnames))

  tb_output <-
    tidyjson::read_json(json) %>%
    tidyjson::spread_values(
      "command" =
        tidyjson::jstring("command"),
      "summary--fastp_version" =
        tidyjson::jstring("summary", "fastp_version"),
      "summary--sequencing" =
        tidyjson::jstring("summary", "sequencing"),
      "summary--before_filtering.total_reads" =
        tidyjson::jnumber("summary", "before_filtering", "total_reads"),
      "summary--before_filtering.total_bases" =
        tidyjson::jnumber("summary", "before_filtering", "total_bases"),
      "summary--before_filtering.q20_bases" =
        tidyjson::jnumber("summary", "before_filtering", "q20_bases"),
      "summary--before_filtering.q30_bases" =
        tidyjson::jnumber("summary", "before_filtering", "q30_bases"),
      "summary--before_filtering.q20_rate" =
        tidyjson::jnumber("summary", "before_filtering", "q20_rate"),
      "summary--before_filtering.q30_rate" =
        tidyjson::jnumber("summary", "before_filtering", "q30_rate"),
      "summary--before_filtering.read1_mean_length" =
        tidyjson::jnumber("summary", "before_filtering", "read1_mean_length"),
      "summary--before_filtering.read2_mean_length" =
        tidyjson::jnumber("summary", "before_filtering", "read2_mean_length"),
      "summary--before_filtering.gc_content" =
        tidyjson::jnumber("summary", "before_filtering", "gc_content"),
      "summary--after_filtering.total_reads" =
        tidyjson::jnumber("summary", "after_filtering", "total_reads"),
      "summary--after_filtering.total_bases" =
        tidyjson::jnumber("summary", "after_filtering", "total_bases"),
      "summary--after_filtering.q20_bases" =
        tidyjson::jnumber("summary", "after_filtering", "q20_bases"),
      "summary--after_filtering.q30_bases" =
        tidyjson::jnumber("summary", "after_filtering", "q30_bases"),
      "summary--after_filtering.q20_rate" =
        tidyjson::jnumber("summary", "after_filtering", "q20_rate"),
      "summary--after_filtering.q30_rate" =
        tidyjson::jnumber("summary", "after_filtering", "q30_rate"),
      "summary--after_filtering.read1_mean_length" =
        tidyjson::jnumber("summary", "after_filtering", "read1_mean_length"),
      "summary--after_filtering.read2_mean_length" =
        tidyjson::jnumber("summary", "after_filtering", "read2_mean_length"),
      "summary--after_filtering.gc_content" =
        tidyjson::jnumber("summary", "after_filtering", "gc_content"),
      "filtering_result--passed_filter_reads" =
        tidyjson::jnumber("filtering_result", "passed_filter_reads"),
      "filtering_result--low_quality_reads" =
        tidyjson::jnumber("filtering_result", "low_quality_reads"),
      "filtering_result--too_many_N_reads" =
        tidyjson::jnumber("filtering_result", "too_many_N_reads"),
      "filtering_result--too_short_reads" =
        tidyjson::jnumber("filtering_result", "too_short_reads"),
      "filtering_result--too_long_reads" =
        tidyjson::jnumber("filtering_result", "too_long_reads"),
      "duplication--rate" =
        tidyjson::jnumber("duplication", "rate"),
      "insert_size--peak" =
        tidyjson::jnumber("insert_size", "peak"),
      "insert_size--unknown" =
        tidyjson::jnumber("insert_size", "unknown"),
      "adapter_cutting--adapter_trimmed_reads" =
        tidyjson::jnumber("adapter_cutting", "adapter_trimmed_reads"),
      "adapter_cutting--adapter_trimmed_bases" =
        tidyjson::jnumber("adapter_cutting", "adapter_trimmed_bases"),
      "adapter_cutting--read1_adapter_sequence" =
        tidyjson::jstring("adapter_cutting", "read1_adapter_sequence"),
      "adapter_cutting--read2_adapter_sequence" =
        tidyjson::jstring("adapter_cutting", "read2_adapter_sequence"),
      "read1_before_filtering--total_reads" =
        tidyjson::jnumber("read1_before_filtering", "total_reads"),
      "read1_before_filtering--total_bases" =
        tidyjson::jnumber("read1_before_filtering", "total_bases"),
      "read1_before_filtering--q20_bases" =
        tidyjson::jnumber("read1_before_filtering", "q20_bases"),
      "read1_before_filtering--q30_bases" =
        tidyjson::jnumber("read1_before_filtering", "q30_bases"),
      "read1_before_filtering--total_cycles" =
        tidyjson::jnumber("read1_before_filtering", "total_cycles"),
      "read2_before_filtering--total_reads" =
        tidyjson::jnumber("read2_before_filtering", "total_reads"),
      "read2_before_filtering--total_bases" =
        tidyjson::jnumber("read2_before_filtering", "total_bases"),
      "read2_before_filtering--q20_bases" =
        tidyjson::jnumber("read2_before_filtering", "q20_bases"),
      "read2_before_filtering--q30_bases" =
        tidyjson::jnumber("read2_before_filtering", "q30_bases"),
      "read2_before_filtering--total_cycles" =
        tidyjson::jnumber("read2_before_filtering", "total_cycles"),
      "read1_after_filtering--total_reads" =
        tidyjson::jnumber("read1_after_filtering", "total_reads"),
      "read1_after_filtering--total_bases" =
        tidyjson::jnumber("read1_after_filtering", "total_bases"),
      "read1_after_filtering--q20_bases" =
        tidyjson::jnumber("read1_after_filtering", "q20_bases"),
      "read1_after_filtering--q30_bases" =
        tidyjson::jnumber("read1_after_filtering", "q30_bases"),
      "read1_after_filtering--total_cycles" =
        tidyjson::jnumber("read1_after_filtering", "total_cycles"),
      "read2_after_filtering--total_reads" =
        tidyjson::jnumber("read2_after_filtering", "total_reads"),
      "read2_after_filtering--total_bases" =
        tidyjson::jnumber("read2_after_filtering", "total_bases"),
      "read2_after_filtering--q20_bases" =
        tidyjson::jnumber("read2_after_filtering", "q20_bases"),
      "read2_after_filtering--q30_bases" =
        tidyjson::jnumber("read2_after_filtering", "q30_bases"),
      "read2_after_filtering--total_cycles" =
        tidyjson::jnumber("read2_after_filtering", "total_cycles")
    ) %>%
    tibble::as_tibble() %>%
    select(-document.id)
  return(tb_output)
}
