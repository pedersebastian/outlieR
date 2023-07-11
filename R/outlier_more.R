#' Outlier filter
#'
#' @param .data  data.frame or tibble
#' @param ...  variables to filter outlier
#' @param method method of filter outlier.
#' @param threshold threshold for the other methods than t-test. Default is 3 for mean and sd method and MAD method, IQD uses 2.2.
#' @param conf_int confidence interval if method is t-test
#' @export
#' @return data.frame or tibble
#' @examples
#'
#' mtcars["V1"] <- c(rnorm(30), -100, 100)
#' mtcars["V2"] <- c(-50, 32, rnorm(30))
#' filtred <-
#'   mtcars |> outlier_flere(V1, V2)
#'
#' paste(nrow(mtcars), "rows before filtered and", nrow(filtred), "rows after")
#'  #"32 rows before filtered and 28 rows after"
outlier_flere <- function(.data, ..., method = c("mean_sd", "MAD", "IQD", "t_test"), threshold = "default", conf_int = NULL) {
  if (missing(.data)) {
    rlang::abort(".data must be supplied")
  }
  UseMethod("outlier_flere")
}
#' @export
outlier_flere.default <- function(.data, ..., method = c("mean_sd", "MAD", "IQD", "t_test"), threshold = "default", conf_int = NULL) {
  mes <- paste("filter_outlier does not support data of type", class(.data)[[1]])
  rlang::abort(mes)
}
#' @export
outlier_flere.data.frame <- function(.data, ..., method = c("mean_sd", "MAD", "IQD", "t_test"), threshold = "default", conf_int = NULL) {
  method <- match.arg(method, c("mean_sd", "MAD", "IQD", "t_test"), several.ok = FALSE)


  check_outlier(.data, ..., method = method, threshold = threshold, conf_int = conf_int)

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
  # vars <- rlang::as_quosures(names())
  # print(names(select_loc(.data, ...)))
  # print(vars)

  vars <- rlang::names2(select_loc(..., .data = .data)) |>
    rlang::syms() |>
    as_quosures(env = current_env())

  # return(vars)
  outlier_flere.impl(.data, vars, method = method, threshold = threshold, conf_level = conf_level)
}


outlier_flere.impl <- function(.data, vars, method, threshold, conf_level) {
  tbls <- purrr::map(vars, ~ get_tbl(.data, .x, method = method, threshold = threshold, conf_level = conf_level))
  vecs <- list()
  for (i in seq_along(vars)) {
    vec <- purrr::map_lgl(.data[[tbls[[i]]$var]], ~ out_help(.x, tbls[[i]]$upper, tbls[[i]]$lower))
    vecs[[i]] <- vec
  }

  y <- unlist(vecs) |>
    matrix(ncol = length(vecs))
  res <- vector()
  for (row in seq(nrow(y))) {
    res[row] <- y[row, ] |> sum() == 0
  }


  return(subset(.data, res))
}
