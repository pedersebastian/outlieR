
#' @importFrom ggplot2 autoplot
#' @export

ggplot2::autoplot

#' @param object data
#' @param ... Not Currently used
#' @param type histogram or countplot
#' @export
autoplot.outlier <- function(object, ..., type = c("histogram", "count")) {
  type <-
    match.arg(type)
  if (is.null(type)) {
    cli::cli_abort("type must be histogram or count")
  }

  data <- prep_data(object, type)
  p <- make_plot(data, type, ...)
  p
}
