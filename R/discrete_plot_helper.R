plot_single_discrete_counts <- function(data,
                                        var_name,
                                        summary_tbl,
                                        title = NULL,
                                        y_text = TRUE) {
  line <- 1 - summary_tbl$outlier_pct
  non_outlier_col <- c("#BC8F1C", "#EFD593")
  outlier_col <- c("#9C3015", "#EC8D75")



  counts <- dplyr::count(data, outlier_vec)

  rows_count <- summary_tbl$n - summary_tbl$na_count


  normal_count <-
    counts$n[counts$outlier_vec == FALSE]
  outlier_count <-
    counts$n[counts$outlier_vec == TRUE]

  palette <- grDevices::colorRampPalette(non_outlier_col)(normal_count)
  outlier_exist <- summary_tbl$outlier_exist

  if (outlier_exist) {
    if (outlier_count > 0) {
      palette <- c(
        palette,
        grDevices::colorRampPalette(outlier_col)(outlier_count)
      )
      palette <- rev(palette)
    }
  }

  p <-
    data |>
    ggplot2::ggplot(ggplot2::aes(pct, variable, fill = value)) +
    ggplot2::scale_x_continuous(
      labels = scales::label_percent(),
      sec.axis = ggplot2::sec_axis(
        trans = ~ .x * rows_count,
        breaks = round(
          seq(0, rows_count,
            length.out = 5
          ),
          digits = 0
        ),
        name = "Counts"
      )
    ) +
    theme_outlier() +
    ggplot2::theme(
      legend.position = "bottom",
      panel.grid.major.y = ggplot2::element_blank()
    ) +
    ggplot2::guides("fill" = ggplot2::guide_legend(reverse = TRUE, nrow = 1)) +
    ggplot2::scale_fill_manual(values = palette) +
    ggplot2::labs(title = title, y = NULL, x = "Percent", fill = NULL)

  if (!y_text) {
    p <- p + ggplot2::theme(axis.text.y = ggplot2::element_blank())
  }

  if (outlier_exist) {
    p <- p +
      ggplot2::geom_vline(xintercept = line, lty = 2, linewidth = 0.5) +
      ggplot2::geom_rect(
        data = summary_tbl,
        ggplot2::aes(
          xmin = 1,
          xmax = 1 - outlier_pct,
          ymin = -Inf,
          ymax = Inf
        ),
        alpha = 0.2,
        fill = "#9C3015",
        inherit.aes = FALSE
      )
  }


  p + ggplot2::geom_col(
    width = 0.5,
    alpha = 0.9,
    color = "#16161D",
    linewidth = 0.2,
    na.rm = TRUE
  )
}
