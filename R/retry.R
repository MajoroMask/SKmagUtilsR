#' Retry a function call
#'
#' @param expr The expression that may need retry.
#' @param is_error Function used to decide if the expr is errored.
#' @param max_errors Max try repeats.
#' @param sleep Time interval between retries.
#'
#' @return The value of expression if without error.
#' @export
#'
retry <- function(expr,
                  is_error = function(x) "try-error" %in% class(x),
                  max_errors = 5L,
                  sleep = 0) {
  attempts <- 0
  try_result <- try(eval(expr))
  while (is_error(try_result)) {
    attempts <- attempts + 1
    if (attempts >= max_errors) {
      msg <- sprintf(
        "Retry: too many retries [[%s]]",
        utils::capture.output(str(try_result))
      )
      rlang::abort(msg)
    } else {
      msg <- sprintf(
        "Retry: error in attempt %i/%i [[%s]]",
        attempts,
        max_errors,
        capture.output(str(try_result))
      )
      rlang::warn(msg)
    }
    if (sleep > 0) Sys.sleep(sleep)
    try_result <- try(eval(expr))
  }
  return(try_result)
}
