
make_multiple_count <- function(data) {
  if (attr(data,"lgl") == 1) {
    p <- lgl_plot <-
      make_one_lgl(data) + labs(title = glue::glue("Countplot of {data$var[[1]]}!"))
  }
  else if (attr(data,"lgl") > 1) {
    p <- lgl_plot <-
      make_one_lgl(data) + ggplot2::facet_wrap(ggplot2::vars(var), scales = "free") + ggplot2::guide_legend(reverse = TRUE)
  }

  if (attr(data,"dbl") == 1) {
    p <- dbl_plot <-
      make_one_lgl(data)
  }
  else if (attr(data,"dbl") > 1) {
    p <- dbl_plot <-
      make_more_lgl(data)
  }


  if (attr(data,"lgl") != 0 & attr(data,"dbl") != 0) {
    p <- patchwork::wrap_plots(lgl_plot,  dbl_plot, ncol = 2)
  }

  p
}

make_one_lgl <- function(data) {
  col_low <- "#2a9d8f"
  col_high <- "#e76f51"
  col_mid <- "#e9c46a"
  col_text <- "#264653"
  if (length(unique(data$var)) == 1) {
    if (data$mean_var[[1]]<0.5) {
      pal = c(col_mid, col_high)
      print("HEI")
    }
    else {
      pal = c(col_low, col_mid)
      print("HADE")
    }
  }
  else {
    if (nlevels(data$outlier_var)) {
      pal = c(col_mid, col_high, col_low, col_mid)
    }
  }


  p <-
    ggplot2::ggplot(data, ggplot2::aes(y = 0, fill = outlier_var)) +
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
    ggplot2::scale_fill_manual(values = pal) +
    ggplot2::labs(fill = NULL, y = NULL, x = "Percent", title = NULL) +
    ggplot2::coord_cartesian(ylim = c(-1.6, -0.6))
  p
}


# x$dat$lgl_data |>
#   #dplyr::filter(var == "V3")  |>
#   make_one_lgl() + facet_wrap(vars(var), scales = "free")
#
#
# x$dat$lgl_data


# make_multiple_count <- function(data) {
#   col_low <- "#2a9d8f"
#   col_high <- "#e76f51"
#   col_mid <- "#e9c46a"
#   col_text <- "#264653"
#   # https://coolors.co/palette/264653-2a9d8f-e9c46a-f4a261-e76f51
#
#   dat <- data$dat
#
#   p <- dat |>
#     ggplot2::ggplot(aes(y = 0, fill = outlier_var)) +
#     ggplot2::geom_bar(
#       position = ggplot2::position_fill(reverse = TRUE),
#       just = 2,
#       linewidth = .3,
#       color = "black"
#     ) +
#     theme_outlier() +
#     ggplot2::theme(
#       legend.position = "bottom",
#       panel.grid = ggplot2::element_blank(),
#       axis.text.y = ggplot2::element_blank(),
#       plot.title = ggplot2::element_text(
#         vjust = -20, hjust = 0.5
#       )
#     ) +
#     ggplot2::scale_x_continuous(labels = scales::label_percent(), n.breaks = 5) +
#     ggplot2::scale_fill_manual(values = c(col_low, col_mid, col_high)) +
#     ggplot2::labs(fill = NULL, y = NULL, x = "Percent", title = "") +
#     ggplot2::facet_grid(rows = ggplot2::vars(var), scales = "fixed")
#
#   p
# }
#
# make_multiple_histogram <- function(data) {
#   col_low <- "#2a9d8f"
#   col_high <- "#e76f51"
#   col_mid <- "#e9c46a"
#   col_text <- "#264653"
#   # https://coolors.co/palette/264653-2a9d8f-e9c46a-f4a261-e76f51
#
#   dat <- data$dat
#   summary_tbl <- data$summary_tbl
#   bw <- Freedman_Diaconis_binwidth(dplyr::filter(dat, var == dat$var[[1]]) |> dplyr::pull(value))
#
#   p <-
#     ggplot2::ggplot(dat, aes(value, fill = outlier_var)) +
#     geom_histogram(binwidth = bw) +
#     ggplot2::facet_wrap(vars(var), nrow = length(unique(dat$var)), scales = "free") +
#     ggplot2::scale_fill_manual(values = c(col_low, col_mid, col_high)) +
#     ggplot2::labs(fill = NULL, y = "Count", x = "", title = "Histograms of outliers") +
#     theme_outlier() +
#     ggplot2::theme(
#       legend.position = "bottom",
#       axis.text.y = ggplot2::element_blank(),
#       plot.title = ggplot2::element_text(
#         hjust = 0.5
#       )
#     ) +
#     ggplot2::geom_vline(data = summary_tbl, ggplot2::aes(xintercept = .data$lower), lty = 2) +
#     ggplot2::geom_vline(data = summary_tbl, ggplot2::aes(xintercept = .data$upper), lty = 2) +
#     ggplot2::geom_rect(
#       data = summary_tbl,
#       ggplot2::aes(
#         xmin = -Inf,
#         xmax = lower,
#         ymin = -Inf,
#         ymax = Inf
#       ),
#       alpha = 0.5,
#       fill = col_low,
#       inherit.aes = FALSE
#     ) +
#     ggplot2::geom_rect(
#       data = summary_tbl,
#       ggplot2::aes(
#         xmin = Inf,
#         xmax = upper,
#         ymin = -Inf,
#         ymax = Inf
#       ),
#       alpha = 0.5,
#       fill = col_high,
#       inherit.aes = FALSE
#     )
# }
