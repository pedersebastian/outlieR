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
  if (is.null(conf_int)) {
    return(invisible(NULL))
  }

  if (is.numeric(conf_int)) {
    if (conf_int >= 1 | conf_int <= 0 | length(conf_int) > 1) {
      cli::cli_abort("conf_int must be a singel number between 0 and 1 or NULL")
    } else {
      return(invisible(NULL))
    }
  }
  cli::cli_abort("conf_int must be NULL or numeric")
}


validate_cols <- function(.data, ...) {
  ok_types <- c("dbl", "int", "lgl")
  var_names <- rlang::names2(select_loc(..., .data = .data))
  r <- purrr::map(var_names, ~ pillar::type_sum(.data[[.x]]))
  names(r) <- var_names


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


outlier_threshold <- function(method, threshold) {
  if (threshold == "default") {
    threshold <- switch(method,
      "mean_sd" = 3,
      "MAD" = 3,
      "IQD" = 2.2,
      "t_test" = NULL,
      rlang::abort(paste(method, "is not valid method"))
    )
  } else if (!is.numeric(threshold)) {
    rlang::abort("if threshold is not default it must be numeric", )
  } else if (length(threshold) != 1) {
    rlang::abort("threshold must be of length 1")
  }
  if (threshold < 0) {
    rlang::warn("threshold must be positive - using absolute value")
    threshold <- abs(threshold)
  }

  if (threshold > 5 | threshold < 1) {
    rlang::warn("Extreme value of threshold")
  }
  threshold
}
