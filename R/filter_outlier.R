#' Outlier filter
#'
#' @param .data  data.frame or tibble
#' @param ...  variable(s) to filter outlier
#' @param method method of filter outlier.
#' @param threshold 'NULL' for the other methods than t-test. Default is 3 for mean and sd method and MAD method, IQD uses 2.2.
#' @param conf_int confidence interval if method is t-test
#' @param na_action to also filter NA´s for the spesific variable(s)
#' @export
#' @return data.frame or tibble
#' @examples
#'
#' mtcars["V1"] <- c(rnorm(30), -100, 100)
#' mtcars["V2"] <- c(-50, 32, rnorm(30))
#' filtred <-
#'   mtcars |> filter_outlier(V1, V2)
#'
#' paste(nrow(mtcars), "rows before filtered and", nrow(filtred), "rows after")
#' # "32 rows before filtered and 28 rows after"
filter_outlier <- function(.data, ..., method = "mean_sd", threshold = "default", conf_int = NULL, na_action = "keep") {
  if (missing(.data)) {
    rlang::abort(".data must be supplied")
  }
  UseMethod("filter_outlier")
}
#' @export
filter_outlier.default <- function(.data, ...) {
  mes <- paste("filter_outlier does not support data of type", class(.data)[[1]])
  rlang::abort(mes)
}
#' @export
filter_outlier.data.frame <- function(.data, ..., method = "mean_sd", threshold = NULL, conf_int = NULL, na_action = "keep") {
  method <- match.arg(method, c("mean_sd", "MAD", "IQD", "t_test"), several.ok = FALSE)
  na_action <- match.arg(na_action, c("keep", "omit"), several.ok = FALSE)

  if (!method %in% c("t_test")) {
    threshold <-
      outlier_threshold(method, threshold)
  } else if (method == "t_test" & !is.numeric(conf_int)) {
    conf_int <- 0.95
  }
  else if (method == "t_test" & !is.numeric(conf_int)) {
    conf_int <- 0.95
  }


  check_outlier(.data, ..., method = method, threshold = threshold, conf_int = conf_int)
  if (is.null(conf_int)) {
    conf_int <- 0.95
  }

  vars <- rlang::names2(select_loc(..., .data = .data)) |>
    rlang::syms() |>
    rlang::as_quosures(env = rlang::current_env())

  filter_outlier.impl(.data, vars, method = method, threshold = threshold, conf_int = conf_int, na_action = na_action)
}


filter_outlier.impl <- function(.data, vars, method, threshold, conf_int, na_action) {
  tbls <- purrr::map(vars, ~ get_tbl(.data, .x, method = method, threshold = threshold, conf_int = conf_int))
  vecs <- list()
  for (i in seq_along(vars)) {
    vec <- purrr::map_lgl(.data[[tbls[[i]]$var]], ~ out_help(.x, tbls[[i]]$upper, tbls[[i]]$lower))
    vecs[[i]] <- vec
  }

  y <- unlist(vecs)

  if (na_action == "keep") {
    y <- ifelse(is.na(y), FALSE, y)
  }
  y <- matrix(y, ncol = length(vecs))


  res <- vector()
  for (row in seq(nrow(y))) {
    res[row] <- y[row, ] |> sum() == 0
  }

  res <- subset(.data, res)
  class(res) <- c("outlier", class(res))
  attributes(res) <- c(attributes(res), list(old_df = .data, tbls = tbls))

  return(res)
}
