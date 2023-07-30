plot_single.outlier_lgl_histogram <- function(data, ...) {
  dat <- data$dat
  summary_tbl <- data$summary_tbl
  var_name <- data$var_name

  title <- glue::glue("{round(summary_tbl$outlier_pct * 100,2)} % Outliers for {var_name}")

  p <-
    dplyr::count(
      dat,
      outlier_var
    ) |>
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
    ggplot2::ggplot(aes(outlier_var,
      pct,
      fill = outlier_var
    )) +
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
    ggplot2::labs(
      title = title,
      fill = NULL,
      y = "Percent",
      x = NULL
    )

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

  breaks <- round(seq(
    min(
      summary_tbl$min_var,
      summary_tbl$lower
    ),
    max(
      summary_tbl$max_var,
      summary_tbl$upper
    ),
    length.out = 6
  ))

  p <-
    ggplot2::ggplot() +
    ggplot2::geom_histogram(
      data = dat,
      ggplot2::aes(.data[[var_name]],
        fill = outlier_var
      ),
      position = ggplot2::position_dodge2(
        preserve = "single",
        width = NULL,
        padding = -1
      ),
      bins = 25
    ) +
    ggplot2::labs(
      x = paste0("Variable: ", var_name),
      y = NULL,
      fill = NULL,
      title = glue::glue("Outliers of {var_name}")
    ) +
    theme_outlier() +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::scale_x_continuous(breaks = breaks)

  pal <- c(col_mid)

  if (!length(unique(dat$outlier_var)) == 1) {
    breaks <- round(seq(summary_tbl$min_var,
      summary_tbl$max_var,
      length.out = 6
    ))

    if (any(dat[[var_name]] > summary_tbl$upper)) {
      p <- p +
        ggplot2::geom_vline(
          data = summary_tbl,
          ggplot2::aes(xintercept = .data$upper),
          lty = 2
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

      pal <- append(pal, col_high)
    }
    if (any(dat[[var_name]] < summary_tbl$lower)) {
      p <-
        p +
        ggplot2::geom_vline(
          data = summary_tbl,
          ggplot2::aes(xintercept = .data$lower),
          lty = 2
        ) +

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



plot_single.outlier_fct_histogram <- function(data, ...) {
  summary_tbl <- data$summary_tbl
  var_name <- data$var_name
  data <- data$dat

  new_data <- data |>
    dplyr::count(var, value, outlier_vec) |>
    dplyr::mutate(
      value = glue::glue("{value} \n({n})"),
      value = fct_reorder(value, n),
      pct = n / sum(n),
      outlier_vec = ifelse(outlier_vec, "Outlier", "No Outlier")
    )

  p <-
    new_data |>
    ggplot2::ggplot(aes(n,
      value,
      fill = outlier_vec
    )) +
    ggplot2::geom_col(
      width = 0.8,
      alpha = 0.9,
      color = "#16161D",
      linewidth = 0.2
    ) +
    ggplot2::scale_x_continuous(
      sec.axis = ggplot2::sec_axis(
        trans = ~ (.x / nrow(data)),
        labels = scales::label_percent(),
        name = "Percent"
      ),
      n.breaks = 5
    ) +
    theme_outlier() +
    ggplot2::guides("fill" = ggplot2::guide_legend(
      reverse = TRUE,
      nrow = 1
    )) +
    ggplot2::scale_fill_manual(values = c(col_mid, col_high))

  p
  if (summary_tbl$outlier_exist) {
    p <- p + ggplot2::theme(
      legend.position = "bottom",
      panel.grid.major.y = ggplot2::element_blank()
    )


    title <- glue::glue("Outliers for {var_name}
                      with {round(summary_tbl$outlier_pct*100)} % Outliers")
  } else {
    p <- p + ggplot2::theme(
      legend.position = "none",
      panel.grid.major.y = ggplot2::element_blank()
    )
    title <- glue::glue("{var_name} does not have any Outliers.")
  }
  p +
    ggplot2::labs(
      title = title,
      y = NULL,
      x = "Count",
      fill = NULL
    )
}
