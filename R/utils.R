
#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

#' @importFrom rlang %||%
#' @export
rlang::`%||%`

#' cnow
#'
#' Wrapper for `lubridate::now()` in timezone of Shanghai.
#' @noRd
#' @export
cnow <- function() lubridate::now(tzone = "Asia/Shanghai")

#' Get full formatted timestamp string
#' @noRd
#' @export
my_stamp <- lubridate::stamp("20200131_235959", quiet = TRUE)
