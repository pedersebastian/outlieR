plot_maker <- function(data, ...) {
  if (attr(data, "one_variable")) {
    p <- plot_single(data, ...)
  } else {
    p <- plot_multiple(data, ...)
  }
  ## bytte en gang slik at det kun er én S3 på plot.
  p
}

plot_single <- function(data, ...) {
  UseMethod("plot_single")
}
plot_single.default <- function(data, ...) {
  rlang::abort(glue::glue("{class(data)[[1]]} is not supported"),
    .internal = TRUE
  )
}


plot_single.outlier_fct_count <- function(data, ...) {

  summary_tbl <- data$summary_tbl
  var_name <- data$var_name
  data <- data$dat


  new_data <- data |>
    dplyr::count(var, value, outlier_vec) |>
    dplyr::mutate(value = fct_reorder(value, n),
           pct = n/sum(n))

  line <- 1 - summary_tbl$outlier_pct

  title <- glue::glue("Outliers for {var_name} \nwith {round(summary_tbl$outlier_pct*100)} % Outliers")

  non_outlier_col <- c("#BC8F1C", "#EFD593")
  outlier_col <- c("#9C3015", "#EC8D75")


  n_dis <- nrow(new_data)
  counts <- dplyr::count(new_data, outlier_vec)


  normal_count <-
    counts$n[counts$outlier_vec == FALSE]
  outlier_count <-
    counts$n[counts$outlier_vec == TRUE]

  palette <- grDevices::colorRampPalette(non_outlier_col)(normal_count)
  outlier_exist <- summary_tbl$outlier_exist

  if (outlier_exist) {
    if (outlier_count > 0 ) {
      palette <- c(palette, grDevices::colorRampPalette(outlier_col)(outlier_count))
      palette <- rev(palette)
    }
  }

  print(new_data)


  p <-
    new_data |>
    ggplot2::ggplot(ggplot2::aes(pct, var, fill = value)) +

    ggplot2::scale_x_continuous(
      labels = scales::label_percent(),
      sec.axis = ggplot2::sec_axis(
        trans = ~ .x * nrow(data),
        breaks = seq(0, nrow(data),
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
    ggplot2::guides("fill" = ggplot2::guide_legend(reverse = TRUE, nrow = 1)) +
    ggplot2::scale_fill_manual(values = palette) +
    ggplot2::labs(title = title, y = NULL, x = "Percent", fill = NULL)

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


  p + ggplot2::geom_col(width = 0.5)


}










plot_single.outlier_lgl_count <- function(data, ...) {
  dat <- data$dat
  summary_tbl <- data$summary_tbl
  var_name <- data$var_name

  p <-
    dplyr::count(dat, outlier_var) |>
    dplyr::mutate(
      pct = n / sum(n),
      outlier_var = factor(outlier_var,
        levels = c("No Outlier (FALSE)", "Outlier (FALSE)", "No Outlier (TRUE)", "Outlier (TRUE)")
      )
    ) |>
    ggplot2::ggplot(aes(0, pct, fill = outlier_var)) +
    ggplot2::geom_col(width = 0.5, position = ggplot2::position_fill(reverse = TRUE)) +
    ggplot2::scale_y_continuous(
      labels = scales::label_percent(),
      sec.axis = ggplot2::sec_axis(
        trans = ~ .x * nrow(dat),
        breaks = seq(0, nrow(data$dat),
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
      title = glue::glue("{round(summary_tbl$outlier_pct * 100,2)} % Outliers for {var_name}"),
      fill = NULL,
      y = "Percent",
      x = NULL
    ) +
    ggplot2::scale_x_continuous(limits = c(-1, 1)) +
    ggplot2::coord_flip()

  if (all(dat$value == TRUE, na.rm = TRUE)) {
    pal <- c(col_high)
  } else if (all(dat$value == FALSE, na.rm = TRUE)) {
    pal <- c(col_low)
  } else {
    pal <- c(col_low, col_high)
  }


  p + ggplot2::scale_fill_manual(values = pal)
}

plot_single.outlier_dbl_count <- function(data, ...) {
  dat <- data$dat
  var_name <- data$var_name
  summary_tbl <- data$summary_tbl

  p <-
    dplyr::count(dat, outlier_var) |>
    dplyr::mutate(
      pct = n / sum(n)
    ) |>
    ggplot2::ggplot(aes(0, pct, fill = outlier_var)) +
    ggplot2::geom_col(width = 0.5, position = ggplot2::position_fill(reverse = TRUE)) +
    ggplot2::scale_y_continuous(
      labels = scales::label_percent(),
      sec.axis = ggplot2::sec_axis(
        trans = ~ .x * nrow(dat),
        breaks = seq(0, nrow(data$dat),
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
      title = glue::glue("{round(summary_tbl$outlier_pct * 100,2)} % Outliers for {var_name}"),
      fill = NULL,
      y = "Percent",
      x = NULL
    ) +
    ggplot2::scale_x_continuous(limits = c(-1, 1)) +
    ggplot2::coord_flip()

  pal <- c(col_mid)
  if (any(dat[[var_name]] > summary_tbl$upper)) pal <- append(pal, col_high)

  if (any(dat[[var_name]] < summary_tbl$lower)) pal <- append(pal, col_low, after = 0)

  p + ggplot2::scale_fill_manual(values = pal)
}


