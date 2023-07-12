check_outlier <- function(.data, ..., method, threshold, conf_int) {
  dots_n <- function(...) nargs()
  if (dots_n(...) == 0) {
    cli::cli_abort("Variables to be filtred must be ")
  }
  validate_cols(.data, ...)
  if (method == "t_test") {
    conf_int_check(conf_int)
  }

}




conf_int_check <- function(conf_int) {
  if (is.null(conf_int)) return(invisible(NULL))

  if (is.numeric(conf_int)) {
    if (conf_int >= 1 | conf_int <= 0 | length(conf_int) > 1) {
      cli::cli_abort("conf_int must be a singel number between 0 and 1 or NULL")
    }
    else {
      return(invisible(NULL))
    }
  }
  cli::cli_abort("conf_int must be NULL or numeric")



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
