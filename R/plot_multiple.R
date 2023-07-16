plot_multiple <- function(data, ...) {
  UseMethod("plot_multiple")
}
plot_multiple.default <- function(data, ...) {
  rlang::abort(glue::glue("{class(data)[[1]]} is not supported"), .internal = TRUE)
}


plot_multiple.outlier_lglTRUE_dblTRUE_otherFALSE_histogram <- function(data, ...) {
  mes = get_errormes(class(data)[[2]])
  cli::cli_abort(c("x" = mes,
                   "i" = "Try a single plot"))
}
plot_multiple.outlier_lglTRUE_dblFALSE_otherFALSE_histogram <- function(data, ...) {
  mes = get_errormes(class(data)[[2]])
  cli::cli_abort(c("x" = mes,
                   "i" = "Try a single plot"))
}
plot_multiple.outlier_lglFALSE_dblTRUE_otherFALSE_histogram <- function(data, ...) {
  rows <- attr(data ,"dbl")
  summary_tbl <- data$summary_tbl
  data <- data$dat$dbl_data




  p <-  ggplot(data = data) +
    geom_histogram(aes(value, fill = outlier_var), binwidth = 2, boundary=0, na.rm = TRUE, color = "black", linewidth = .2) +
    facet_wrap(vars(var),
               scales = "free",
               nrow = rows) +
    ggplot2::labs(x = NULL, y = NULL, fill = NULL, title = glue::glue("Histogram")) +
    theme_outlier() +
    ggplot2::theme(legend.position = "bottom")  +
    geom_rect(data = summary_tbl, aes(
      xmin = Inf,
      xmax = upper_outlier,
      ymin = -Inf,
      ymax = Inf,
      group = var
    ),
    alpha = 0.5, fill = col_high) +
    ggplot2::geom_vline(data = summary_tbl, ggplot2::aes(xintercept = .data$lower_outlier), lty = 2) +
    ggplot2::geom_vline(data = summary_tbl, ggplot2::aes(xintercept = .data$upper_outlier), lty = 2) +
    ggplot2::geom_rect(
      data = summary_tbl,
      ggplot2::aes(
        xmin = -Inf,
        xmax = lower_outlier,
        ymin = -Inf,
        ymax = Inf
      ),
      alpha = 0.5, fill = col_low
    ) +
    theme(plot.title = element_text(size = 15, vjust = 2))
  pal <- c(col_mid)
  if (any(is.finite(summary_tbl$lower_outlier))) {
    pal <- append(pal, col_high)
  }
  if (any(is.finite(summary_tbl$upper_outlier))) {
    pal <- append(pal, col_low, after = 0)
  }

  p <- p + ggplot2::scale_fill_manual(values = pal)
  p
}
plot_multiple.outlier_lglTRUE_dblTRUE_otherFALSE_count <- function(data, ...) {
  mes = get_errormes(class(data)[[2]])
  cli::cli_abort(c("x" = mes,
                   "i" = "Try a single plot"))
}
plot_multiple.outlier_lglTRUE_dblFALSE_otherFALSE_count <- function(data, ...) {
  mes = get_errormes(class(data)[[2]])
  cli::cli_abort(c("x" = mes,
                   "i" = "Try a single plot"))
}
plot_multiple.outlier_lglFALSE_dblTRUE_otherFALSE_count <- function(data, ...) {
  mes = get_errormes(class(data)[[2]])
  cli::cli_abort(c("x" = mes,
                   "i" = "Try a single plot"))
}




get_errormes <- function(class) {

  x = grepl("TRUE", strsplit(class, "_")[[1]][2:3]) |> as.logical()
  if (all(x)) {
    mes = "Outlierplot for both logical and double variables is not yet supported "
  }
  else {
    if (isTRUE(x[[1]])) {
      mes = "Outlierplot for multiple logical variables is not yet supported. "
    }
    else {
      mes = "Outlierplot for multiple double variables is not yet supported "
    }
  }
  paste0(mes, "for plottype '", strsplit(class, "_")[[1]][[5]], "'")
}


