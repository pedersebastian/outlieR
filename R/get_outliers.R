#' Title
#'
#' @param x outlier object
#' @param ... not used
#' @param .ptype description
#'
#' @return
#' @export
#'
#' @examples
get_outliers <- function(x, ..., .ptype = logical()) {
  UseMethod("get_outliers")
}
#' @export
get_outliers.outlier <- function(x, ... ) {
 #TRUE FALSE
  #eller som character

  rlang::abort("not implemented. ")
}
#' @export
get_outliers.default <- function(x, ..., .ptype = logical()) {
  cli::cli_abort(c(
    "x" = paste("get_outliers is not available for an object with class '", class(x)[[1]], "'"),
    "i" = "Must run filter_outliers first."
  ))
}
