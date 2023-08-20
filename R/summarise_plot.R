#' Summary of Outliers
#'
#' @param object object created by ´identify_outlier()´
#' @param ... not used
#'
#' @return ggplot
#' @export
#'
#' @examples
#' identify_outlier(tibble::as_tibble(ggplot2::txhousing), everything()) |>
#' summarise_outlier()
summarise_outlier <- function(object, ...) {
  UseMethod("summarise_outlier")
}

#' @export
summarise_outlier.default <- function(object, ...) {
  cli::cli_abort(c(
    "x" = paste(
      "summarise_outlier is not available for an object with class '",
      class(object)[[1]], "'"
    ),
    "i" = "Must run identify_outliers first."
  ))
}

#' @export
summarise_outlier.outlier_identify <- function(object, ...) {
  data <- make_data_display(object)
  plot <- make_plot_summariser(data)
  plot
}

make_plot_summariser <- function(data) {

  data <-
    data |>
    dplyr::group_by(var_type) |>
    dplyr::count(value) |>
    dplyr::mutate(pct = n/sum(n))


  if (any(data$value == "Outlier", na.rm = TRUE)) pal <- c(col_mid, col_high) else pal <- col_mid


 p <-  data |>
    ggplot2::ggplot(aes(pct,
                        var_type,
                        fill = value)) +
    ggplot2::geom_col(position = "fill",
                      width = 0.8,
                      color = "#16161D",
                      linewidth = 0.1) +
    theme_outlier() +
    ggplot2::theme(
      legend.position = "top",
      axis.text.y = ggplot2::element_text(size = structure(1.1, class = "rel")),
      axis.text.x = ggplot2::element_text(
        size = structure(1.1, class = "rel"),
      ),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    ) +
    ggplot2::labs(
      title = "Summary of Outliers",
      fill = NULL,
      y = "Variable type",
      x = NULL
    ) +
    ggplot2::scale_fill_manual(values = pal, na.value = "gray80") +
   ggplot2::scale_x_continuous(labels = scales::label_percent())
 p
}
