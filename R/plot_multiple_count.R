plot_multiple.outlier_lglTRUE_dblTRUE_otherFALSE_count <- function(data, ...) {
  #TRUE TRUE
  mes <- get_errormes(class(data)[[2]])
  cli::cli_abort(c(
    "x" = mes,
    "i" = "Try a single plot"
  ))
}
################################################################################
#                            #                        #                        #
################################################################################
plot_multiple.outlier_lglTRUE_dblFALSE_otherFALSE_count <- function(data, ...) {
  #KUN LGL


  summary_tbl <- dplyr::filter(data$summary_tbl, var_type == "lgl")
  rows <- max(summary_tbl$n)
  data <- data$dat$lgl_data

  #outlier_lglFALSE_dblTRUE_otherFALSE_count



  data <-
    data |>
    count(var, outlier_var) |>
    group_by(var) |>
    mutate(pct = n/sum(n, na.rm = TRUE),
           outlier_var = factor(outlier_var,
                                levels = c("No Outlier (FALSE)", "Outlier (FALSE)", "No Outlier (TRUE)", "Outlier (TRUE)")
           ))

  pal = c()

  for (level in c("No Outlier (FALSE)", "Outlier (FALSE)", "No Outlier (TRUE)", "Outlier (TRUE)")) {
    if (level %in% levels(droplevels(d$outlier_var))) {
      pal <- switch (level,
                     "No Outlier (FALSE)" = append(pal, col_low),
                     "Outlier (FALSE)" = append(pal, col_text),
                     "No Outlier (TRUE)" = append(pal, col_mid),
                     "Outlier (TRUE)" = append(pal, col_high)
      )

    }
  }


  p <- data |>
    ggplot(aes(pct, var, fill = outlier_var)) +
    ggplot2::geom_col(width = 0.5, position = ggplot2::position_fill(reverse = TRUE), color = "black", linewidth = 0.2) +
    ggplot2::scale_x_continuous(
      labels = scales::label_percent(),
      sec.axis = ggplot2::sec_axis(
        trans = ~ .x * rows,
        breaks = seq(0, rows,
                     length.out = 5
        ),
        name = "Count"
      )
    ) +
    theme_outlier() +
    ggplot2::theme(
      legend.position = "bottom",
      axis.text.y = ggplot2::element_blank(),
      panel.grid.major.y = ggplot2::element_blank()
    ) +
    ggplot2::labs(
      title = NULL,
      fill = NULL,
      y = "Percent",
      x = NULL
    ) +
    scale_fill_manual(values = pal)

  p
}
################################################################################
#                            #                        #                        #
################################################################################
plot_multiple.outlier_lglFALSE_dblTRUE_otherFALSE_count <- function(data, ...) {
  #Kun dbl

  summary_tbl <- dplyr::filter(data$summary_tbl, var_type == "dbl")
  rows <- max(summary_tbl$n)
  data <- data$dat$dbl_data

  #outlier_lglFALSE_dblTRUE_otherFALSE_count
  pal <- c(col_mid)
  if (any(is.finite(summary_tbl$lower_outlier))) pal <- append(pal, col_high)
  if (any(is.finite(summary_tbl$upper_outlier))) pal <- append(pal, col_low, after = 0)


  p <-
    data |>
    dplyr::count(outlier_var, var) |>
    dplyr::group_by(var) |>
    dplyr::mutate(pct = n/sum(n)) |>
    ggplot(aes(pct, var, fill = outlier_var)) +
    ggplot2::geom_col(width = 0.5, position = ggplot2::position_fill(reverse = TRUE), color = "black", linewidth = 0.2) +
    ggplot2::scale_x_continuous(
      labels = scales::label_percent(),
      sec.axis = ggplot2::sec_axis(
        trans = ~ .x * rows,
        breaks = seq(0, rows,
                     length.out = 5
        ),
        name = "Count"
      )
    ) +
    ggplot2::scale_fill_manual(values = pal) +
    ggplot2::labs(x = "Percent", y = NULL, fill = NULL, title ="") +
    theme_outlier() +
    ggplot2::theme(legend.position = "bottom")
  p

}
