#' Display outliers
#'
#' @param object object created by identify_outlier()
#' @param ... not used
#'
#' @return plot
#' @export
#'
#' @examples
#' print("kommer")
#'
display_outlier <- function(object, ...) {
  UseMethod("display_outlier")
}
#' @export
display_outlier.default <- function(object, ...) {
  cli::cli_abort(c(
    "x" = paste(
      "display_outlier is not available for an object with class '",
      class(object)[[1]], "'"
    ),
    "i" = "Must run identify_outliers first."
  ))
}
#' @export
display_outlier.outlier_identify <- function(object, ...) {
  data <- make_data_display(object)
  plot <- make_plot_display(data)
  plot
}

make_data_display <- function(object, ...) {
  data <-
    object$tbls |>
    dplyr::bind_rows()

  na_df <-
    object$old_df |>
    dplyr::select(all_of(data$var)) |>
    dplyr::mutate(dplyr::across(everything(), is.na)) |>
    tidyr::pivot_longer(everything(), names_to = "variable") |>
    dplyr::group_by(variable) |>
    dplyr::mutate(
      id = dplyr::row_number(),
      .before = "variable"
    ) |>
    dplyr::ungroup()

  out <-
    data |>
    dplyr::select(variable = var, var_type, outlier_vec) |>
    tidyr::unnest(outlier_vec) |>
    dplyr::group_by(variable) |>
    dplyr::mutate(
      id = dplyr::row_number(),
      .before = "variable"
    ) |>
    dplyr::ungroup() |>
    dplyr::left_join(na_df, by = dplyr::join_by(id, variable)) |>
    dplyr::mutate(
      outlier_vec = ifelse(value, NA, outlier_vec),
      variable = glue::glue("{variable} ({var_type})"),
      value = ifelse(outlier_vec, "Outlier", "No Outlier"),
      value = factor(value)
    )
  out
}

make_plot_display <- function(data, ...) {

  if (any(data$outlier_vec, na.rm = TRUE)) {
    pal <- c(col_mid, col_high)
    limits = c("No Outlier", "Outlier")
  }
  else {
    pal <- col_mid
    limits = "No Outlier"
  }

  row_count <- max(data$id)

  p <-
    ggplot2::ggplot() +
    ggplot2::geom_tile(data = data, ggplot2::aes(variable, id, fill = value), na.rm = FALSE, width = 0.94) +
    theme_outlier() +
    ggplot2::theme(
      legend.position = "top",
      axis.text.y = ggplot2::element_text(size = structure(0.8, class = "rel")),
      axis.text.x = ggplot2::element_text(
        size = structure(0.8, class = "rel"),
        angle = 40,
        vjust = structure(0.7, class = "rel")
      ),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    ) +
    ggplot2::labs(
      title = "Display of Outliers",
      fill = NULL,
      y = "Row",
      x = NULL
    ) +
    ggplot2::scale_fill_manual(values = pal, na.value = NA, limits = limits) +
    scale_y_continuous(breaks = round(seq(0, row_count, length.out = 6), 0))

  p
}
