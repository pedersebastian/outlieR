check_outlier <- function(.data, ..., method = c("mean_sd", "MAD", "IQD", "t_test"), threshold = "default", conf_int = NULL) {
  dots_n <- function(...) nargs()
  if (dots_n(...) == 0) {
    cli::cli_abort("Variables to be filtred must be ")
  }
  validate_cols(.data, ...)
}

# check_outlier("HEI")


###sjekke vectype med pillar???


ok_types = c("dbl", "int", "lgl")

validate_cols <- function(.data, ...) {
  var_names <- rlang::names2(select_loc(..., .data = .data))
  r = purrr::map(var_names, ~pillar::type_sum(.data[[.x]]))
  names(r) = var_names


  for (variable in var_names) {
    if (!r[[variable]] %in% ok_types) {
      cli::cli_abort(
        glue::glue(
          "Variable '{variable}' with datatype '{r[[variable]]}' is not a supported type for outlier detection yet. "
        )
      )
    }
  }
}
