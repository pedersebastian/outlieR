#' Outlier filter
#'
#' @param .data  data.frame or tibble
#' @param ...  variable(s) to filter outlier
#' @param num_method num_method of filter outlier.
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
filter_outlier <- function(.data, ..., control = control_filter_outlier()) {
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
filter_outlier.data.frame <- function(.data, ..., control = control_filter_outlier()) {

  if (!inherits(control, "control_filter_outlier")) {
    cli::cli_abort()
  }
  else {
    num_method = control$numeric_method
    discrete_method = control$discrete_method
    threshold = control$threshold
    conf_int = control$conf_int
    prop = control$prop
    n = control$n
    freq = control$freq
    ties_method = control$ties_method
    na_action = control$na_action
    min_times = control$min_times
  }


  #fortsatt med 'alle' fordi skal sjekke med om det er greit å bruke 'n' og 'sånn'
  check_outlier(.data, ..., discrete_method = discrete_method, prop = prop, n = n, freq = freq, min_times = min_times)


  vars <- rlang::names2(select_loc(..., .data = .data)) |>
    rlang::syms() |>
    rlang::as_quosures(env = rlang::current_env())


  filter_outlier.impl(.data,
                      vars,
                      num_method = num_method,
                      threshold = threshold,
                      conf_int = conf_int,
                      na_action = na_action,
                      prop = prop,
                      n = n,
                      freq = freq,
                      ties_method = ties_method,
                      min_times = min_times)
}


filter_outlier.impl <- function(.data, vars, num_method, threshold, conf_int, na_action, prop, n, freq, ties_method, min_times) {
  tbls <- purrr::map(vars, ~ get_tbl(.data, .x, num_method = num_method, threshold = threshold, conf_int = conf_int, prop = prop, n = n, freq = freq, ties_method = ties_method, min_times = min_times))
  vecs <- list()
  for (i in seq_along(vars)) {
    if (tbls[[i]]$var_type %in% c("lgl", "dbl", "int")) {
      vec <- purrr::map_lgl(.data[[tbls[[i]]$var]], ~ out_help(.x, tbls[[i]]$upper, tbls[[i]]$lower))
    }
    else if (tbls[[i]]$var_type %in% c("fct", "chr")) {
      vec = tbls[[i]]$outlier_test[[1]]
    }

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

  names(vecs) <- map(vars, quo_name)
  filter_res <- res
  res <- subset(.data, res)


  class(res) <- c("outlier", class(res))
  attributes(res) <- c(attributes(res), list(
    old_df = .data,
    tbls = tbls,
    vecs = vecs,
    filter_res = filter_res,
    na_action = na_action
  ))

  return(res)
}
