#' @export
autoplot.extract.logical <- function(object, ...) {
  atri <-
    attr(object, "outlier_data")

  new_vec <-
    atri$vecs |>
    purrr::map(~ tidyr::replace_na(
      .x,
      if (atri$na_action == "keep") TRUE else FALSE
    ))


  data <-
    dplyr::as_tibble(new_vec) |>
    dplyr::mutate(idxx = dplyr::row_number()) |>
    tidyr::pivot_longer(-idxx)



  if (sum(data$value) == 0) pal <- col_mid else pal <- c(col_mid, col_high)

  p <-
    data |>
    dplyr::mutate(
      value = ifelse(value, "Outlier", "No Outlier"),
      value = factor(value)
    ) |>
    ggplot2::ggplot(aes(name, idxx, fill = value)) +
    ggplot2::geom_tile(na.rm = TRUE, width = 0.96) +
    theme_outlier() +
    ggplot2::theme(
      legend.position = "top",
      axis.text.y = ggplot2::element_text(size = structure(0.8, class = "rel")),
      axis.text.x = ggplot2::element_text(
        size = structure(0.6, class = "rel"),
        angle = 90
      ),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank()
    ) +
    ggplot2::labs(
      title = NULL,
      fill = NULL,
      y = "Row",
      x = NULL
    ) +
    ggplot2::scale_fill_manual(values = pal) +
    ggplot2::scale_y_continuous(
      breaks = round(
        seq(0,
          length(atri$vecs[[1]]),
          length.out = 5
        )
      )
    )

  p
}
