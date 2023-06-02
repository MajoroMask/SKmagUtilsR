
#' Download virus genome from NCBI API
#'
#' @param tax_id The taxonomy ID of target virus.
#' @param max_errors Max try repeats.
#'
#' @return invisible(NULL)
#' @export
download_ncbi_genome <- function(tax_id, max_errors = 5L) {
  requireNamespace("rentrez", quietly = TRUE)
  requireNamespace("dplyr", quietly = TRUE)

  # method 1: nuccore ----
  # targets <- rentrez::entrez_search(
  #   db = "nuccore",
  #   term = glue::glue("txid{arg_from_cmd$tax_id}[Organism:exp]")
  # )
  # if (targets$count == 0L) {
  #   rlang::abort("Xit happens: `entrez_search()` find nothing.")
  # }
  # target_sum <- rentrez::entrez_summary(db = "nuccore", id = targets$ids[1])
  # target_seq <- rentrez::entrez_fetch(
  #   db = "nuccore",
  #   id = target_sum$accessionversion,
  #   rettype = "fasta"
  # )
  # write(target_seq, file = path)

  # method 2: assembly -> ftp ----

  # magic
  enlist_cols <- c(
    "uid",
    "assemblyaccession",
    "lastmajorreleaseaccession",
    "latestaccession",
    "assemblyname",
    "taxid",
    "organism",
    "assemblytype",
    "assemblystatus",
    "asmupdatedate",
    "seqreleasedate",
    "lastupdatedate",
    "releaselevel",
    "releasetype",
    "property",
    "contign50",
    "scaffoldn50",
    "ftppath_genbank",
    "ftppath_refseq"
  )

  assemblies <- retry(
    rentrez::entrez_search(
      db = "assembly",
      term = glue::glue("txid{arg_from_cmd$tax_id}[Organism:exp]")
    ),
    max_errors = max_errors
  )
  if (assemblies$count == 0L) {
    rlang::abort("Xit happens: `entrez_search()` find nothing.")
  }
  assemblies_summary <- retry(
    rentrez::entrez_summary(
      "assembly",
      assemblies$ids,
      always_return_list = TRUE
    ),
    max_errors = max_errors
  )
  tb_assemblies <-
    purrr::map_dfr(
      .x = assemblies_summary,
      .f = function(l) {
        l$property <-
          l$propertylist %>%
          sort() %>%
          stringr::str_c(collapse = ";")
        tb_out <- tibble::as_tibble(l[enlist_cols])
        return(tb_out)
      }
    ) %>%
    mutate(
      is_viral_proj = case_when(
        stringr::str_detect(assemblyname, "ViralProj") ~ 1,
        TRUE ~ 99
      ),
      is_complete = case_when(
        assemblystatus == "Complete Genome" ~ 1,
        TRUE ~ 99
      ),
      across(
        .cols = c(asmupdatedate, seqreleasedate, lastupdatedate),
        .fns = lubridate::ymd_hm
      )
    ) %>%
    arrange(
      is_viral_proj,
      is_complete,
      desc(lastupdatedate),
      desc(asmupdatedate)
    )

  # download genome.fna.gz from NCBI ftp
  ftp_url <- stringr::str_c(tb_assemblies$ftppath_refseq[1], "/")
  ftp_contents <- retry(
    RCurl::getURL(
      url = ftp_url,
      crlf = TRUE,
      ftp.use.epsv = FALSE,
      dirlistonly = TRUE
    ),
    max_errors = max_errors
  )
  genome_filename <-
    ftp_contents %>%
    stringr::str_split(pattern = "\\n", simplify = TRUE) %>%
    as.vector() %>%
    stringr::str_subset("_genomic.fna.gz") %>%
    stringr::str_subset("_cds_from_|_rna_from_", negate = TRUE)
  retry(
    download.file(
      url = stringr::str_c(ftp_url, genome_filename),
      destfile = genome_filename,
      quiet = TRUE
    ),
    max_errors = max_errors
  )
  return(genome_filename)
}
