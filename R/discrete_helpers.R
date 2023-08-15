discrete_helper <- function(x, fun, args) {
  withr::with_package("forcats", {
    new <- rlang::exec(fun, x, !!!args)
  })

  lvl <- levels(new)
  lvl <- lvl[lvl != "Otherxxx"]
  out <- purrr::map_lgl(new, ~ .x %in% lvl)
  out
}
all_var_equal <- function(x) {
  # returns true if all variables has the same counts
  length(unique(table(x))) == 1
}

fix_zero_variance <- function(variance, outlier_vec) {
  outlier_vec <- if (variance) !outlier_vec else outlier_vec
  return(outlier_vec)
}


factor_na <- function(.data, tbl) {
  vec <-
    purrr::map2_lgl(.data[[tbl$var]], tbl$outlier_vec[[1]], ~ if (is.na(.x)) FALSE else .y)
  tbl$outlier_vec <- list(vec)
  tbl
}

validate_factor_tbl <- function(.data,
                                var,
                                discrete_method,
                                prop,
                                n_vars,
                                min_times,
                                freq,
                                ties_method,
                                tbl) {
  if (discrete_method == "min_times") {
    if (min_times > tbl$n) {
      mes <-
        c("x" = "{.arg min_times} must be less than number of rows in data. ")
      cli::cli_abort(mes)
    } else if (min_times < 0) {
      mes <-
        c("i" = "Negative numbers for {.arg min_times} is not recommend. \n
                      Because it is doing the opposite of finding outliers.")
      cli::cli_warn(mes,
        .frequency = "regularly", .frequency_id = "min_times_negative"
      )
    } else if (min_times > tbl$n / 2) {
      mes <-
        c("i" = "{.arg min_time} is greater than half of the rows in data.
          \n It is recommend to use a less number")
      cli::cli_warn(mes,
        .frequency = "regularly", .frequency_id = "min_times0.5"
      )
    }
  }

  if (discrete_method == "n") {
    if (n_vars > tbl$uniques) {
      mes <-
        c("x" = "{.arg n_vars} must be less
          than number of unique levels ({tbl$uniques})")
      cli::cli_abort(mes)
    } else if (n_vars == tbl$uniques) {
      mes <-
        c("i" = "{.arg n_vars} is equal to number of unique levels,
          so no outliers will be filtered/ identified.")
      cli::cli_warn(mes)
    }
  }

  return(invisible(NULL))
}
