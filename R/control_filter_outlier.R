#' Control_object
#'
#' @param numeric_method dd
#' @param discrete_method m
#' @param threshold for some numeric methods
#' @param conf_int conf int for t-test
#' @param prop propotion of factors/char (0 - 1)
#' @param ties_method factors
#' @param na_action "keep" NA is the default
#'
#' @return control_object
#' @export
#'
#' @examples
#' control_filter_outlier()
control_filter_outlier <- function(numeric_method = "mean_sd",
                                   discrete_method = "prop",
                                   threshold = NULL,
                                   conf_int = NULL,
                                   prop = NULL,
                                   n = NULL,
                                   freq = NULL,
                                   min_times = NULL,
                                   ties_method = "min",
                                   na_action = "keep") {
  ## fix args
  if (is.null(numeric_method)) {
    numeric_method <- "mean_sd"
  }
  if (is.null(discrete_method)) {
    discrete_method <- "prop"
  }
  if (is.null(ties_method)) {
    ties_method <- "min"
  }
  if (is.null(na_action)) {
    na_action <- "keep"
  }


  num_method <- match.arg(numeric_method, c("mean_sd", "MAD", "IQD", "t_test"), several.ok = FALSE)
  na_action <- match.arg(na_action, c("keep", "omit"), several.ok = FALSE)
  discrete_method <- match.arg(discrete_method, c("prop", "n", "low_freq", "min_times"))

  ties_method <- match.arg(ties_method, c(
    "min",
    "average", "first", "last", "random", "max"
  ))

  #### NUM
  numeric_or_null(threshold)
  numeric_or_null(conf_int)
  numeric_or_null(prop)
  numeric_or_null(n)
  numeric_or_null(freq)
  ######





  if (!num_method %in% c("t_test")) {
    threshold <-
      outlier_threshold(num_method, threshold)
  } else if (num_method == "t_test" & !is.numeric(conf_int)) {
    conf_int <- 0.95
  }

  if (num_method == "t_test") {
    conf_int_check(conf_int)
  }

  if (is.null(prop)) prop <- 0.05
  if (is.null(conf_int)) conf_int <- 0.95

  if (prop <= 0 | prop > 1) {
    cli::cli_abort(c("x" = "prop for factors must be betweeen 0 and 1"))
  } else if (prop > 0.5) {
    rlang::warn(glue::glue("{prop} is filtering over 50 % of data.. you sure?"))
  }


  if (is.null(n) & discrete_method == "n") {
    cli::cli_abort(c("!" = "{.arg n} must be specified when {.arg discrete_method} is 'n'. "))
  }
  if (is.null(freq) & discrete_method == "freq") {
    cli::cli_abort(c("!" = "{.arg freq} must be specified when {.arg discrete_method} is 'freq'. "))
  }


  out <- structure(
    list(
      numeric_method = numeric_method,
      discrete_method = discrete_method,
      threshold = threshold,
      conf_int = conf_int,
      prop = prop,
      n = n,
      freq = freq,
      ties_method = ties_method,
      na_action = na_action
    ),
    class = c("control_filter_outlier", "list")
  )
  out
}

numeric_or_null <- function(x) {
  name <- deparse1(substitute(x))
  if (!is.null(x) & !is.numeric(x)) {
    cli::cli_abort(c("!" = "{name} must be numeric or NULL"))
  }
}
