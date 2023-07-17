plot_multiple.outlier_lglTRUE_dblTRUE_otherFALSE_count <- function(data, ...) {
  mes <- get_errormes(class(data)[[2]])
  cli::cli_abort(c(
    "x" = mes,
    "i" = "Try a single plot"
  ))
}
plot_multiple.outlier_lglTRUE_dblFALSE_otherFALSE_count <- function(data, ...) {
  mes <- get_errormes(class(data)[[2]])
  cli::cli_abort(c(
    "x" = mes,
    "i" = "Try a single plot"
  ))
}
plot_multiple.outlier_lglFALSE_dblTRUE_otherFALSE_count <- function(data, ...) {
  mes <- get_errormes(class(data)[[2]])
  cli::cli_abort(c(
    "x" = mes,
    "i" = "Try a single plot"
  ))
}
