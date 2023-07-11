check_outlier <- function(.data, ..., method = c("mean_sd", "MAD", "IQD", "t_test"), threshold = "default", conf_int = NULL) {
  dots_n <- function(...) nargs()
  if (dots_n(...) == 0) {
    cli::cli_abort("Variables to be filtred must be ")
  }
}

# check_outlier("HEI")
