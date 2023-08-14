#' Display outliers of an
#'
#' @param object object created by identify_outlier()
#' @param ... not used
#'
#' @return plot
#' @export
#'
#' @examples
#'
#'

display_outlier <- function(object, ...) {
  UseMethod("display_outlier")
}
display_outlier <- function(object, ...) {
  cli::cli_abort(c(
    "x" = paste(
      "extract_outlier is not available for an object with class '",
      class(object)[[1]], "'"
    ),
    "i" = "Must run identify_outliers first."
  ))
}

display_outlier.outlier_identify <- function(object, ...) {
  data <- make_data_display(object)
  plot <- make_plot_display(data)
  plot
}


make_data_display <- function(object, ...) {

}

make_plot_display <- function(data, ...) {

}
