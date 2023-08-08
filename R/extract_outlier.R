#' extract outliers from
#'
#' @param x outlier object
#' @param ... not used
#' @param .ptype type to
#'
#' @return vector or tibble
#' @export
#'
#' @examples
#' print("hello")
extract_outlier <- function(x, ..., .ptype = logical()) {
  UseMethod("extract_outlier")
}
#' @export
extract_outlier.data.frame <- function(x, ...) {
  cli::cli_abort(c(
    "x" = paste(
      "extract_outlier is not available for an object with class '",
      class(x)[[1]], "'"
    ),
    "i" = "Must run filter_outliers first."
  ))
}

#' @export
extract_outlier.outlier <- function(x, ..., .ptype = logical()) {
  out <- switch(class(.ptype),
    "logical" = extract_outlier_logical_impl(x),
    "character" = extract_outlier_character_impl(x),
    cli::cli_abort(c(
      "x" = paste("Not implemented for class", class(.ptype)),
      "i" = "Only logical or character"
    ))
  )
  out
}


extract_outlier_logical_impl <- function(x) {
  out <-
    structure(
      !attr(x, "filter_res"),
      class = c("logical", "extract.logical"),
      outlier_data = attributes(x),
      filtred_data = x
    )
  out
}




extract_outlier_character_impl <- function(x) {
  rlang::abort("not implemented yet character")
}

## other methods

#' @export
print.extract.logical <- function(x, ...) {
  print(as.logical(x))
}
