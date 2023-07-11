filter_outlier <- function(.data, var, ..., method = c("mean_sd", "MAD", "IQD", "t_test"), threshold = "default", conf_int = NULL) {
  # if (missing(.data)) {
  #   rlang::abort(".data must be supplied")
  # }
  UseMethod("filter_outlier")
}

# Mean and Standard Deviation Method
#
# Median and Median Absolute Deviation Method (MAD)
#
# Median and Interquartile Deviation Method (IQD)


#*** Noe med z-value eller t-test

filter_outlier.default <- function(.data, var, ..., method, threshold) {
  mes <- paste("filter_outlier does not support data of type", class(.data)[[1]])
  rlang::abort(mes)
}

outlier_threshold <- function(method, threshold) {
  if (threshold == "default") {
    threshold <- switch(method,
      "mean_sd" = 3,
      "MAD" = 3,
      "IQD" = 2.2,
      "t_test" = 3,
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

filter_outlier.data.frame <- function(.data, var, ..., method, threshold = "default", conf_level = NULL) {
  method <- match.arg(method, c("mean_sd", "MAD", "IQD", "t_test"), several.ok = FALSE)

  if (!method %in% c("t_test")) {
    threshold <-
      outlier_threshold(method, threshold)
  } else if (method == "t_test") {
    if (is.null(conf_level)) {
      conf_level <- 0.95
    } else if (!is.numeric(conf_level)) {
      cli::cli_abort("conf_int must be numeric")
    } else if (conf_level >= 1 | conf_level <= 0 | length(conf_level) > 1) {
      cli::cli_abort("'conf_level' must be a single number between 0 and 1")
    }
  }

  var <- rlang::enquo(var)

  filter_outlier.impl(.data, var, method = method, threshold = threshold, conf_level = conf_level)
}

filter_outlier.impl <- function(.data, var, ..., method, threshold, conf_level) {
  tbl <- get_tbl(.data, var, method, threshold, conf_level)
  outlier_return(.data, var, tbl$upper, tbl$lower, tbl)
}


outlier_return <- function(.data, var, upper, lower, tbl, verbose = TRUE) {
  del_rows <-
    rownames(.data)[!mutate(.data, test = !!var < upper & !!var > lower)$test]

  filtred <-
    dplyr::filter(.data, !!var < upper, !!var > lower)

  n_removed <- nrow(.data) - nrow(filtred)
  if (verbose) {
    if (n_removed == 0) {
      cli::cli_inform("No outliers were removed")
    } else {
      cli::cli_inform(
        glue::glue("removed {n_removed} rows")
      )
    }
  }

  filtred
}


# quo_name(quo(heio))

# mtcars$mpg |>


# mtcars["heii"] = c(rnorm(30), -100,100)
#
# x <-
#   mtcars |> as_tibble() |> filter_outlier(var = heii, method = "t_test")
# x

# tibble::rownames_to_column(x)


# rownames(x)[!x$tet]



# mtcars[mtcars$heii < 76, ]
