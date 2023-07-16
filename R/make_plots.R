######################### . MAKE PLOT

make_plot <- function(data, type, ...) {
  if (attr(data, "one_variable")) {
    if (data$summary_tbl$var_type == "lgl") {
      switch(type,
        "histogram" = make_hist_logical_singel(data),
        "count" = make_one_lgl(data$dat),
        cli::cli_abort("fe")
      )
    } else {
      switch(type,
        "histogram" = make_single_histogram(data),
        "count" = make_single_count(data),
        cli::cli_abort(glue::glue("{type} is not supported"))
      )
    }
  } else if (!attr(data, "one_variable")) {
    switch(type,
      "histogram" = make_multiple_histogram(data),
      "count" = make_multiple_count(data),
      cli::cli_abort(glue::glue("{type} is not supported"))
    )
  } else {
    cli::cli_abort("Flow control out of hand")
  }
}



make_single_histogram <- function(data) {
  summary_tbl <- data$summary_tbl
  var_name <- data$var_name
  dat <- data$dat


  col_low <- "#2a9d8f"
  col_high <- "#e76f51"
  col_mid <- "#e9c46a"
  col_text <- "#264653"
  # https://coolors.co/palette/264653-2a9d8f-e9c46a-f4a261-e76f51

  breaks <- round(seq(min(summary_tbl$min_var, summary_tbl$lower), max(summary_tbl$max_var, summary_tbl$upper), length.out = 6))

  p <-
    ggplot2::ggplot() +
    ggplot2::geom_histogram(data = dat, ggplot2::aes(.data[[var_name]], fill = outlier_var), position = ggplot2::position_dodge2(preserve = "single", width = NULL, padding = -1), bins = 25) +
    ggplot2::labs(x = paste0("Variable: ", var_name), y = NULL, fill = NULL, title = "Tittel") +
    ggplot2::scale_fill_manual(values = c(col_low, col_mid, col_high)) +
    theme_outlier() +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::scale_x_continuous(breaks = breaks)


  if (!dat$outlier_var |>
    unique() |>
    length() == 1) {
    breaks <- round(seq(summary_tbl$min_var, summary_tbl$max_var, length.out = 6))
    p <-
      p +
      ggplot2::geom_vline(data = summary_tbl, ggplot2::aes(xintercept = .data$lower), lty = 2) +
      ggplot2::geom_vline(data = summary_tbl, ggplot2::aes(xintercept = .data$upper), lty = 2) +
      ggplot2::geom_rect(
        data = summary_tbl,
        ggplot2::aes(
          xmin = -Inf,
          xmax = lower,
          ymin = -Inf,
          ymax = Inf
        ),
        alpha = 0.5, fill = col_low
      ) +
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
  }

  p
}

make_single_count <- function(data) {
  col_low <- "#2a9d8f"
  col_high <- "#e76f51"
  col_mid <- "#e9c46a"
  col_text <- "#264653"
  # https://coolors.co/palette/264653-2a9d8f-e9c46a-f4a261-e76f51

  plot_title <- glue::glue("Count of outliers of {data$var_name}")

  dat <- data$dat

  p <-
    ggplot2::ggplot(dat, ggplot2::aes(y = 0, fill = outlier_var)) +
    ggplot2::geom_bar(
      position = ggplot2::position_fill(reverse = TRUE),
      just = 2,
      linewidth = .3,
      color = "black"
    ) +
    theme_outlier() +
    ggplot2::theme(
      legend.position = "bottom",
      panel.grid = ggplot2::element_blank(),
      axis.text.y = ggplot2::element_blank(),
      plot.title = ggplot2::element_text(
        vjust = -20, hjust = 0.5
      )
    ) +
    ggplot2::scale_x_continuous(labels = scales::label_percent(), n.breaks = 5) +
    ggplot2::scale_fill_manual(values = c(col_low, col_mid, col_high)) +
    ggplot2::labs(fill = NULL, y = NULL, x = "Percent", title = plot_title) +
    ggplot2::coord_cartesian(ylim = c(-1.6, -0.6))
  p
}



make_hist_logical_singel <- function(data) {
  print(data)
  col_low <- "#2a9d8f"
  col_high <- "#e76f51"
  col_mid <- "#e9c46a"
  col_text <- "#264653"
  # https://coolors.co/palette/264653-2a9d8f-e9c46a-f4a261-e76f51

  dat <- data$dat
  summary_tbl <- data$summary_tbl
  p <-
    dplyr::count(dat, outlier_var) |>
    dplyr::mutate(
      pct = n / sum(n),
      outlier_var = factor(outlier_var,
        levels = c("No Outlier (TRUE)", "No Outlier (FALSE)", "Outlier (FALSE)", "Outlier (TRUE)")
      )
    ) |>
    ggplot2::ggplot(aes(outlier_var, pct, fill = outlier_var)) +
    ggplot2::geom_col() +
    ggplot2::scale_y_continuous(labels = scales::label_percent(), sec.axis = ggplot2::sec_axis(trans = ~ .x * nrow(dat), breaks = seq(0, nrow(data$dat), length.out = 5), name = "Count")) +
    ggplot2::scale_fill_manual(values = c(col_mid, col_high)) +
    theme_outlier() +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::labs(title = glue::glue("Counts of outliers {round(summary_tbl$outlier_pct * 100,2)} % Outliers"), fill = NULL, y = "Percent", x = NULL)

  return(p)
}
