plot_maker <- function(data, ...) {
  if (attr(data, "one_variable")) {
    p <- plot_single(data, ...)
  } else {
    p <- plot_multiple(data, ...)
  }
  p
}

plot_single <- function(data, ...) {
  UseMethod("plot_single")
}
plot_single.default <- function(data, ...) {
  rlang::abort(glue::glue("{class(data)[[1]]} is not supported"), .internal = TRUE)
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
    ggplot2::scale_y_continuous(labels = scales::label_percent(),
                                sec.axis = ggplot2::sec_axis(trans = ~ .x * nrow(dat),
                                                             breaks = seq(0, nrow(data$dat),
                                                                          length.out = 5),
                                                             name = "Count")) +

    theme_outlier() +
    ggplot2::theme(legend.position = "bottom",
                   axis.text.y = ggplot2::element_blank(),
                   panel.grid.major.y = ggplot2::element_blank()) +
    ggplot2::labs(title = glue::glue("{round(summary_tbl$outlier_pct * 100,2)} % Outliers for {var_name}"),
                  fill = NULL,
                  y = "Percent",
                  x = NULL) +
    ggplot2::scale_x_continuous(limits = c(-1,1)) +
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
    ggplot2::scale_y_continuous(labels = scales::label_percent(),
                                sec.axis = ggplot2::sec_axis(trans = ~ .x * nrow(dat),
                                                             breaks = seq(0, nrow(data$dat),
                                                                          length.out = 5),
                                                             name = "Count")) +

    theme_outlier() +
    ggplot2::theme(legend.position = "bottom",
                   axis.text.y = ggplot2::element_blank(),
                   panel.grid.major.y = ggplot2::element_blank()) +
    ggplot2::labs(title = glue::glue("{round(summary_tbl$outlier_pct * 100,2)} % Outliers for {var_name}"),
                  fill = NULL,
                  y = "Percent",
                  x = NULL) +
    ggplot2::scale_x_continuous(limits = c(-1,1)) +
    ggplot2::coord_flip()

  pal <- c(col_mid)
  if (any(dat[[var_name]] > summary_tbl$upper)) pal <- append(pal, col_high)

  if (any(dat[[var_name]] < summary_tbl$lower)) pal <- append(pal, col_low, after = 0)

  p + ggplot2::scale_fill_manual(values = pal)
}



plot_single.outlier_lgl_histogram <- function(data, ...) {
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
    ggplot2::ggplot(aes(outlier_var, pct, fill = outlier_var)) +
    ggplot2::geom_col() +
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
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::labs(title = glue::glue("{round(summary_tbl$outlier_pct * 100,2)} % Outliers for {var_name}"), fill = NULL, y = "Percent", x = NULL)

  if (all(dat$value == TRUE, na.rm = TRUE)) {
    pal <- c(col_high)
  } else if (all(dat$value == FALSE, na.rm = TRUE)) {
    pal <- c(col_low)
  } else {
    pal <- c(col_low, col_high)
  }


  p + ggplot2::scale_fill_manual(values = pal)
}

plot_single.outlier_dbl_histogram <- function(data, ...) {
  summary_tbl <- data$summary_tbl
  var_name <- data$var_name
  dat <- data$dat

  breaks <- round(seq(min(summary_tbl$min_var, summary_tbl$lower), max(summary_tbl$max_var, summary_tbl$upper), length.out = 6))

  p <-
    ggplot2::ggplot() +
    ggplot2::geom_histogram(data = dat, ggplot2::aes(.data[[var_name]], fill = outlier_var), position = ggplot2::position_dodge2(preserve = "single", width = NULL, padding = -1), bins = 25) +
    ggplot2::labs(x = paste0("Variable: ", var_name), y = NULL, fill = NULL, title = glue::glue("Outliers of {var_name}")) +
    theme_outlier() +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::scale_x_continuous(breaks = breaks)

  only_outlier <- TRUE
  pal <- c(col_mid)

  if (!dat$outlier_var |>
    unique() |>
    length() == 1) {
    breaks <- round(seq(summary_tbl$min_var, summary_tbl$max_var, length.out = 6))
    only_outlier <- FALSE

    if (any(dat[[var_name]] > summary_tbl$upper)) {
      p <- p +
        ggplot2::geom_vline(data = summary_tbl, ggplot2::aes(xintercept = .data$upper), lty = 2) +
        ggplot2::geom_rect(
          data = summary_tbl,
          ggplot2::aes(
            xmin = Inf,
            xmax = upper,
            ymin = -Inf,
            ymax = Inf
          ),
          alpha = 0.5, fill = col_high
        )

      pal <- append(pal, col_high)
    }
    if (any(dat[[var_name]] < summary_tbl$lower)) {

      p <-
        p +
        ggplot2::geom_vline(data = summary_tbl, ggplot2::aes(xintercept = .data$lower), lty = 2) +

        ggplot2::geom_rect(
          data = summary_tbl,
          ggplot2::aes(
            xmin = -Inf,
            xmax = lower,
            ymin = -Inf,
            ymax = Inf
          ),
          alpha = 0.5, fill = col_low
        )
      pal <- append(pal, col_low, after = 0)
    }
  }
  p + ggplot2::scale_fill_manual(values = pal)
}
