
#' Download virus genome from NCBI API
#'
#' @param tax_id The taxonomy ID of target virus.
#' @param path Where to save the fasta file.
#'
#' @return invisible(NULL)
#' @export
download_ncbi_genome <- function(tax_id, path) {
  requireNamespace("rentrez", quietly = TRUE)

  targets <- rentrez::entrez_search(
    db = "nuccore",
    term = glue::glue("txid{arg_from_cmd$tax_id}[Organism:exp]")
  )
  if (targets$count == 0L) {
    rlang::abort("Xit happens: `entrez_search()` find nothing.")
  }
  target_sum <- rentrez::entrez_summary(db = "nuccore", id = targets$ids[1])
  target_seq <- rentrez::entrez_fetch(
    db = "nuccore",
    id = target_sum$accessionversion,
    rettype = "fasta"
  )
  write(target_seq, file = path)
  return(invisible(NULL))
}
