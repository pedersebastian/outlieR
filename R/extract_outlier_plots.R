
#'@export
autoplot.extract.logical <- function(object, ...) {
  atri <-
    attr(object, "outlier_data")

  new_vec <-
    atri$vecs |>
    purrr::map(~tidyr::replace_na(.x, if(atri$na_action == "keep") FALSE else TRUE))


  data <-
    dplyr::as_tibble(new_vec) |>
    dplyr::mutate(idxx = dplyr::row_number()) |>
    tidyr::pivot_longer( -idxx)



  if (sum(data$value)==0) pal = col_mid else pal = c(col_mid, col_high)

  p <-
    data |>
    dplyr::mutate(value = ifelse(value, "Outlier", "No Outlier"),
           value = factor(value)) |>
    ggplot2::ggplot(aes(name, idxx, fill = value)) +
    ggplot2::geom_tile(na.rm = TRUE, width = 0.96) +
    theme_outlier() +
    ggplot2::theme(
      legend.position = "bottom",
      axis.text.y = ggplot2::element_text(size = structure(0.8, class = "rel")),
      # panel.grid.major.y = ggplot2::element_blank()
      axis.text.x = ggplot2::element_text(size = structure(1.5, class = "rel"))
    ) +
    ggplot2::labs(
      title = NULL,
      fill = NULL,
      y = "Row",
      x = NULL
    ) +
    ggplot2::scale_fill_manual(values = pal) +
    ggplot2::scale_y_continuous(breaks = round(seq(0, length(atri$vecs[[1]]), length.out = 5)))

  p

}

