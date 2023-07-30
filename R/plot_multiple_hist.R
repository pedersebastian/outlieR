plot_multiple <- function(data, ...) {
  UseMethod("plot_multiple")
}
plot_multiple.default <- function(data, ...) {
  rlang::abort(glue::glue("{class(data)[[1]]} is not supported"),
    .internal = TRUE
  )
}


plot_multiple.outlier_lglFALSE_dblFALSE_disTRUE_otherFALSE_histogram <- function(data, ...) {
  test_data <-
    data$dat$dis_data |>
    dplyr::count(var, value, outlier_vec)

  palette <- col_mid
  if (sum(test_data$outlier_vec, na.rm = TRUE) > 0) {
    palette <- c(col_high, palette)
  }


  p <-
    test_data |>
    dplyr::mutate(
      value = forcats::fct_reorder(value, n),
      outlier_vec = ifelse(outlier_vec,
        "Outlier", "No outlier"
      ),
      outlier_vec = factor(outlier_vec,
        levels = c("Outlier", "No outlier")
      )
    ) |>
    ggplot2::ggplot(ggplot2::aes(n,
      value,
      fill = outlier_vec
    )) +
    ggplot2::geom_col() +
    ggplot2::facet_wrap(ggplot2::vars(var),
      scales = "free_y",
      ncol = 1
    ) +
    theme_outlier() +
    ggplot2::theme(
      legend.position = "bottom",
      panel.grid.major.y = ggplot2::element_blank()
    ) +
    ggplot2::guides("fill" = ggplot2::guide_legend(reverse = FALSE, nrow = 1)) +
    ggplot2::scale_fill_manual(values = palette) +
    ggplot2::labs(
      title = NULL,
      y = NULL,
      x = "Counts",
      fill = NULL
    ) +
    ggplot2::scale_x_continuous(breaks = seq(0, max(test_data$n, na.rm = TRUE)))
  p
}



################################################################################
#                            #                        #                        #
################################################################################
plot_multiple.outlier_lglTRUE_dblTRUE_disFALSE_otherFALSE_histogram <- function(data, ...) {
  # begge
  if (attr(data, "total_count") > 8) {
    rlang::warn("May be ugly due to many plots")
  }


  p1 <-
    plot_multiple.outlier_lglTRUE_dblFALSE_disFALSE_otherFALSE_histogram(data)
  p2 <-
    plot_multiple.outlier_lglFALSE_dblTRUE_disFALSE_otherFALSE_histogram(data)

  p <- patchwork::wrap_plots(
    p1, p2,
    nrow = 2
  )
  p
}
################################################################################
#                            #                        #                        #
################################################################################
plot_multiple.outlier_lglTRUE_dblFALSE_disFALSE_otherFALSE_histogram <- function(data, ...) {
  # kun lgl

  summary_tbl <-
    data$summary_tbl
  data <-
    data$dat$lgl_data
  rows <- max(summary_tbl$n, na.rm = TRUE)

  logical_levels <- c(
    "No Outlier (FALSE)",
    "Outlier (FALSE)",
    "No Outlier (TRUE)",
    "Outlier (TRUE)"
  )
  data <-
    data |>
    dplyr::count(var, outlier_var) |>
    dplyr::mutate(var_two = var) |>
    dplyr::group_by(var_two) |>
    tidyr::nest(data = -var_two) |>
    dplyr::mutate(data = purrr::map(data, complete_helper)) |>
    tidyr::unnest(data) |>
    dplyr::mutate(
      pct = n / sum(n),
      outlier_var = factor(outlier_var,
        levels = logical_levels
      )
    )


  pal <- c()

  for (level in logical_levels) {
    if (level %in% levels(droplevels(data$outlier_var))) {
      pal <- switch(level,
        "No Outlier (FALSE)" = append(pal, col_low),
        "Outlier (FALSE)" = append(pal, col_low),
        "No Outlier (TRUE)" = append(pal, col_high),
        "Outlier (TRUE)" = append(pal, col_high)
      )
    }
  }


  p <- data |>
    ggplot2::ggplot(ggplot2::aes(outlier_var,
      pct,
      fill = outlier_var
    )) +
    ggplot2::geom_col(
      width = 0.5,
      color = "black",
      linewidth = if (any(data$n == 0, na.rm = TRUE)) 0 else 0.2,
      na.rm = TRUE
    ) +
    ggplot2::scale_y_continuous(
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
      panel.grid.major.y = ggplot2::element_blank(),
      axis.text.x = ggplot2::element_text(size = structure(0.8, class = "rel"))
    ) +
    ggplot2::labs(
      title = NULL,
      fill = NULL,
      x = "Percent",
      y = NULL
    ) +
    ggplot2::scale_fill_manual(values = pal) +
    ggplot2::facet_wrap(ggplot2::vars(var), scales = "free_x")
  p
}
################################################################################
#                            #                        #                        #
################################################################################
plot_multiple.outlier_lglFALSE_dblTRUE_disFALSE_otherFALSE_histogram <- function(data, ...) {
  rows <- attr(data, "dbl")
  summary_tbl <- dplyr::filter(data$summary_tbl, var_type %in% c("dbl", "int"))
  data <- data$dat$dbl_data

  p <- ggplot2::ggplot(data = data) +
    ggplot2::geom_histogram(
      ggplot2::aes(value,
        fill = outlier_var
      ),
      bins = 50,
      boundary = 0,
      na.rm = TRUE,
      color = "black",
      linewidth = .2
    ) +
    ggplot2::facet_wrap(ggplot2::vars(var),
      scales = "free",
      nrow = if (rows < 4) rows else NULL
    ) +
    ggplot2::labs(
      x = NULL,
      y = NULL,
      fill = NULL,
      title = glue::glue("Histogram of continuous outliers")
    ) +
    theme_outlier() +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::geom_rect(
      data = summary_tbl, ggplot2::aes(
        xmin = Inf,
        xmax = upper_outlier,
        ymin = -Inf,
        ymax = Inf,
        group = var
      ),
      alpha = 0.5,
      fill = col_high
    ) +
    ggplot2::geom_vline(
      data = summary_tbl,
      ggplot2::aes(xintercept = .data$lower_outlier),
      lty = 2
    ) +
    ggplot2::geom_vline(
      data = summary_tbl,
      ggplot2::aes(xintercept = .data$upper_outlier),
      lty = 2
    ) +
    ggplot2::geom_rect(
      data = summary_tbl,
      ggplot2::aes(
        xmin = -Inf,
        xmax = lower_outlier,
        ymin = -Inf,
        ymax = Inf
      ),
      alpha = 0.5,
      fill = col_low
    ) +
    ggplot2::theme(plot.title = ggplot2::element_text(size = 15, vjust = 2))


  pal <- c(col_mid)
  if (any(is.finite(summary_tbl$upper_outlier))) pal <- append(pal, col_high)
  if (any(is.finite(summary_tbl$lower_outlier))) {
    pal <- append(pal, col_low, after = 0)
  }
  p <-
    p + ggplot2::scale_fill_manual(values = pal)
  p
}
