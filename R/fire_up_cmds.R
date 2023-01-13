#' fire_up_cmds
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @export
fire_up_cmds <- function(cmds, nthreads = NULL) {
  requireNamespace("future", quietly = TRUE)
  requireNamespace("furrr", quietly = TRUE)

  # threads limits
  max_threads <- future::availableCores()
  if(is.null(nthreads)) nthreads <- round(max_threads * 0.3)
  nthreads <- min(nthreads, length(cmds))
  if(max_threads < nthreads) nthreads <- round(max_threads * 0.3)

  if (nthreads == 1L) {
    exit_codes <- purrr::map_int(
      .x = cmds,
      .f = ~ system(.x)
    )
  } else {
    my_plan <- list(future::tweak(future::multicore, workers = nthreads))
    future::plan(my_plan)
    exit_codes <- furrr::future_map_int(
      .x = cmds,
      .f = ~ system(.x),
      .options = furrr::furrr_options()
    )
  }
  return(exit_codes)
}
