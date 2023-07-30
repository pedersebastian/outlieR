plot_multiple.outlier_lglFALSE_dblFALSE_disTRUE_otherFALSE_count <- function(data, ...) {
  summary_tbl <-
    data$summary_tbl

  res_data <-
    data$dat$dis_data |>
    dplyr::count(var, value, outlier_vec) |>
    dplyr::group_by(var) |>
    dplyr::mutate(
      value = forcats::fct_na_value_to_level(value),
      pct = n / sum(n)
    ) |>
    dplyr::ungroup() |>
    dplyr::mutate(
      value = forcats::fct_reorder(value, pct, .na_rm = TRUE),
      variable = var
    ) |>
    tidyr::nest(data = -var) |>
    dplyr::mutate(
      summary_tbl = list(summary_tbl),
      summary_tbl = purrr::map2(summary_tbl, var, ~ filter(.x, var == .y))
    ) |>
    dplyr::mutate(plot = purrr::pmap(list(data, var, summary_tbl), plot_single_discrete_counts))



  p <-
    res_data$plot |>
    patchwork::wrap_plots(ncol = 1)
  p
}




plot_multiple.outlier_lglTRUE_dblTRUE_disFALSE_otherFALSE_count <- function(data, ...) {
  # TRUE TRUE

  summary_tbl <-
    data$summary_tbl
  rows <-
    max(summary_tbl$n)
  data <-
    data$dat |>
    dplyr::bind_rows()


  new_levels <- fix_levels_outlier_var(levels(droplevels(data$outlier_var)))$levels
  pal <- fix_levels_outlier_var(levels(droplevels(data$outlier_var)))$pal

  p <- data |>
    dplyr::select(outlier_var, var, var_type) |>
    dplyr::mutate(
      outlier_var = dplyr::case_when(
        outlier_var %in% c("Outlier (TRUE)", "Outlier (>)") ~ new_levels[3],
        outlier_var %in% c("Outlier (FALSE)", "Outlier (<)") ~ new_levels[1],
        TRUE ~ new_levels[2]
      ),
      outlier_var = factor(outlier_var, levels = new_levels),
      var = glue::glue("{var} ({var_type})")
    ) |>
    dplyr::count(var, var_type, outlier_var) |>
    dplyr::group_by(var) |>
    dplyr::mutate(pct = n / sum(n)) |>
    ggplot2::ggplot(aes(pct,
      var,
      fill = outlier_var
    )) +
    ggplot2::geom_col(
      width = 0.5,
      position = ggplot2::position_fill(reverse = TRUE),
      color = "black",
      linewidth = 0.2
    ) +
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
      panel.grid.major.y = ggplot2::element_blank()
    ) +
    ggplot2::labs(
      title = "Counts for outliers logical and numeric variables ",
      fill = NULL,
      x = "Percent",
      y = NULL
    ) +
    ggplot2::scale_fill_manual(values = pal)

  p
}

################################################################################
#                            #                        #                        #
################################################################################
plot_multiple.outlier_lglTRUE_dblFALSE_disFALSE_otherFALSE_count <- function(data, ...) {
  # KUN LGL

  summary_tbl <- dplyr::filter(data$summary_tbl, var_type == "lgl")
  rows <- max(summary_tbl$n)
  data <- data$dat$lgl_data
  logical_levels <- c(
    "No Outlier (FALSE)",
    "Outlier (FALSE)",
    "No Outlier (TRUE)",
    "Outlier (TRUE)"
  )
  data <-
    data |>
    dplyr::count(var, outlier_var) |>
    dplyr::group_by(var) |>
    dplyr::mutate(
      pct = n / sum(n, na.rm = TRUE),
      outlier_var = factor(outlier_var,
        levels = logical_levels
      )
    )

  pal <- c()

  for (level in logical_levels) {
    if (level %in% levels(droplevels(data$outlier_var))) {
      pal <- switch(level,
        "No Outlier (FALSE)" = append(pal, col_low),
        "Outlier (FALSE)" = append(pal, col_text),
        "No Outlier (TRUE)" = append(pal, col_mid),
        "Outlier (TRUE)" = append(pal, col_high)
      )
    }
  }


  p <- data |>
    ggplot(aes(pct,
      var,
      fill = outlier_var
    )) +
    ggplot2::geom_col(
      width = 0.5,
      position = ggplot2::position_fill(reverse = TRUE),
      color = "black",
      linewidth = 0.2
    ) +
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
      title = "Count for outliers logical variables",
      fill = NULL,
      x = "Percent",
      y = NULL
    ) +
    ggplot2::scale_fill_manual(values = pal)

  p
}
################################################################################
#                            #                        #                        #
################################################################################
plot_multiple.outlier_lglFALSE_dblTRUE_disFALSE_otherFALSE_count <- function(data, ...) {
  # Kun dbl

  summary_tbl <- dplyr::filter(data$summary_tbl, var_type %in% c("dbl", "int"))
  rows <- max(summary_tbl$n)
  data <- data$dat$dbl_data

  # outlier_lglFALSE_dblTRUE_otherFALSE_count
  pal <- c(col_mid)
  if (any(is.finite(summary_tbl$lower_outlier))) pal <- append(pal, col_high)
  if (any(is.finite(summary_tbl$upper_outlier))) pal <- append(pal, col_low, after = 0)


  p <-
    data |>
    dplyr::count(outlier_var, var) |>
    dplyr::group_by(var) |>
    dplyr::mutate(pct = n / sum(n)) |>
    ggplot2::ggplot(aes(pct,
      var,
      fill = outlier_var
    )) +
    ggplot2::geom_col(
      width = 0.5,
      position = ggplot2::position_fill(reverse = TRUE),
      color = "black",
      linewidth = 0.2
    ) +
    ggplot2::scale_x_continuous(
      labels = scales::label_percent(),
      sec.axis = ggplot2::sec_axis(
        trans = ~ .x * rows,
        breaks = round(seq(0, rows,
          length.out = 5
        )),
        name = "Count"
      )
    ) +
    ggplot2::scale_fill_manual(values = pal) +
    ggplot2::labs(
      x = "Percent",
      y = NULL,
      fill = NULL,
      title = "Counts of continuous variables"
    ) +
    theme_outlier() +
    ggplot2::theme(legend.position = "bottom")
  p
}
