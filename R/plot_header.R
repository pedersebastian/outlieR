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
    dplyr::mutate(
      value = fct_reorder(value, n),
      pct = n / sum(n)
    )
  title <- glue::glue("Outliers for {var_name} \n
                      with {round(summary_tbl$outlier_pct*100)} % Outliers")

  p <- plot_single_discrete_counts(
    data = new_data,
    var_name = var_name,
    summary_tbl = summary_tbl,
    title = title,
    y_text = FALSE
  )
  p
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
        levels = c(
          "No Outlier (FALSE)",
          "Outlier (FALSE)",
          "No Outlier (TRUE)",
          "Outlier (TRUE)"
        )
      )
    ) |>
    ggplot2::ggplot(aes(0, pct, fill = outlier_var)) +
    ggplot2::geom_col(
      width = 0.5,
      position = ggplot2::position_fill(reverse = TRUE)
    ) +
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
      title = glue::glue("{round(summary_tbl$outlier_pct * 100,2)}
                         % Outliers for {var_name}"),
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
    ggplot2::geom_col(
      width = 0.5,
      position = ggplot2::position_fill(reverse = TRUE)
    ) +
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
      title = glue::glue("{round(summary_tbl$outlier_pct * 100,2)} %
                         Outliers for {var_name}"),
      fill = NULL,
      y = "Percent",
      x = NULL
    ) +
    ggplot2::scale_x_continuous(limits = c(-1, 1)) +
    ggplot2::coord_flip()

  pal <- c(col_mid)
  if (any(dat[[var_name]] > summary_tbl$upper)) pal <- append(pal, col_high)

  if (any(dat[[var_name]] < summary_tbl$lower)) {
    pal <- append(pal, col_low, after = 0)
  }
  p + ggplot2::scale_fill_manual(values = pal)
}
