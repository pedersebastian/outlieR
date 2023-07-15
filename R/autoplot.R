#' @importFrom ggplot2 autoplot
#' @export

ggplot2::autoplot

#' @param object data
#' @param ... Not Currently used
#' @param type histogram or count
#' @export
autoplot.outlier <- function(object, ..., type = "histogram") {
  if (type == "hist") type <- "histogram"
  type <-
    match.arg(type, c("histogram", "count"))
  if (is.null(type)) {
    cli::cli_abort("Type must be histogram or count")
  }

  data <- prep_data(object, type)
  p <- make_plot(data, type, ...)
  p
}
