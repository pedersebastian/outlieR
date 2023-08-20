#' @importFrom ggplot2 autoplot
#' @export
ggplot2::autoplot

#' @param object data
#' @param ... Not Currently used
#' @param type histogram or count
#' @export
autoplot.outlier_identify <- function(object,
                                      ...,
                                      type = "histogram",
                                      return_data = FALSE) {
  if (type == "hist") type <- "histogram"
  type <-
    match.arg(type, c("histogram", "count"))
  if (is.null(type)) {
    cli::cli_abort("Type must be histogram or count")
  }

  data <- prep_data(object, type)
  if (return_data) {
    return(data)
  }
  #
  p <- plot_maker(data, type, ...)
  p
}

col_low <- "#2a9d8f"
col_high <- "#e76f51"
col_mid <- "#e9c46a"
col_text <- "#264653"
# https://coolors.co/palette/264653-2a9d8f-e9c46a-f4a261-e76f51

#' @title Theme for outlier plots
#' @param bg_colour background colour
#' @param ... dots
#'
#' @importFrom ggplot2 %+replace%
#' @export
theme_outlier <- function(bg_colour = "#fafafa", ...) {
  `%+replace%` <- ggplot2::`%+replace%`

  ggplot2::theme_light() %+replace%
    ggplot2::theme(
      plot.title = ggplot2::element_text(
        hjust = 0.5
      ),
      strip.text = ggplot2::element_text(
        hjust = 0.5, size = 12,
        margin = ggplot2::margin(b = 10)
      ),
      strip.background = ggplot2::element_rect(
        fill = "gray90",
        color = "black",
        linewidth = 0.1,
        linetype = NULL
      ),
      plot.background = ggplot2::element_rect(fill = bg_colour),
      panel.background = ggplot2::element_rect(fill = bg_colour),
      ...
    )
}
