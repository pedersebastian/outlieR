get_outliers <- function(x, ... ) {
  UseMethod("get_outliers")
}

get_outliers.outlier <- function(x, ... ) {
 #TRUE FALSE
  #eller som character

  rlang::abort("not implemented. ")
}
get_outliers.default <- function(x, ... ) {
  cli::cli_abort(c(
    "x" = paste("get_outliers is not available for an object with class '", class(x)[[1]], "'"),
    "i" = "Must run filter_outliers first."
  ))
}
