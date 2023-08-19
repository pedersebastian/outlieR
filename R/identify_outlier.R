#' Identity  filter
#'
#' @param .data  data.frame or tibble
#' @param ...  variable(s) to identify outlier
#' @param control control_obj

#' @export
#' @return data.frame or tibble
#' @examples
#'
#' mtcars["var_1"] <- c(rnorm(30), -100, 100)
#' mtcars["var_2"] <- c(-50, 32, rnorm(30))
#' filtred <-
#'   mtcars |> identify_outlier(var_1, var_2)
#'
#' print(filtred)
#' # ── 4 Outliers were removed of 32 rows. ──────────────────────────────────────────────────
identify_outlier <- function(.data,
                             ...,
                             control = control_outlier()) {
  if (missing(.data)) {
    rlang::abort(".data must be supplied")
  }
  UseMethod("identify_outlier")
}
#' @export
identify_outlier.default <- function(.data, ...) {
  mes <- paste(
    "filter_outlier does not support data of type",
    class(.data)[[1]]
  )
  rlang::abort(mes)
}
#' @export
identify_outlier.data.frame <- function(.data, ...,
                                        control = control_outlier()) {
  if (!inherits(control, "control_outlier")) {
    cli::cli_abort(c(
      "x" = "{.arg control} is of class {.cls {class(control)[[1]]}}.",
      "!" = "Use {.fun control_outlier} to create a control_object."
    ))
  } else {
    num_method <- control$numeric_method
    discrete_method <- control$discrete_method
    threshold <- control$threshold
    conf_int <- control$conf_int
    prop <- control$prop
    n_vars <- control$n_vars
    freq <- control$freq
    ties_method <- control$ties_method
    na_action <- control$na_action
    min_times <- control$min_times
  }



  check_outlier(.data,
    ...,
    discrete_method = discrete_method,
    prop = prop,
    n_vars = n_vars,
    freq = freq,
    min_times = min_times
  )


  vars <- rlang::names2(select_loc(...,
    .data = .data
  )) |>
    rlang::syms() |>
    rlang::as_quosures(env = rlang::current_env())


  identify_outlier.impl(.data,
    vars = vars,
    num_method = num_method,
    discrete_method = discrete_method,
    threshold = threshold,
    conf_int = conf_int,
    na_action = na_action,
    prop = prop,
    n_vars = n_vars,
    freq = freq,
    ties_method = ties_method,
    min_times = min_times,
    control = control
  )
}


identify_outlier.impl <- function(.data,
                                  vars,
                                  num_method,
                                  discrete_method,
                                  threshold,
                                  conf_int,
                                  na_action,
                                  prop,
                                  n_vars,
                                  freq,
                                  ties_method,
                                  min_times,
                                  control) {
  tbls <- purrr::map(vars, ~ get_tbl(
    .data,
    .x,
    num_method = num_method,
    discrete_method = discrete_method,
    threshold = threshold,
    conf_int = conf_int,
    prop = prop,
    n_vars = n_vars,
    freq = freq,
    ties_method = ties_method,
    min_times = min_times,
    na_action = na_action
  ))

  factor_variables <- vector("character")

  vecs <- list()
  for (i in seq_along(vars)) {
    if (tbls[[i]]$var_type %in% c("lgl", "dbl", "int")) {
      vec <- purrr::map_lgl(
        .data[[tbls[[i]]$var]],
        ~ out_help(
          .x, tbls[[i]]$upper,
          tbls[[i]]$lower
        )
      )
    } else if (tbls[[i]]$var_type %in% c("fct", "chr")) {
      vec <- tbls[[i]]$outlier_vec[[1]]
      if (tbls[[i]]$var_type == "fct") {
        factor_variables <- append(factor_variables, tbls[[i]]$var)
      }
    }

    vecs[[i]] <- vec
  }


  y <- unlist(vecs)
  y <- ifelse(is.na(y), na_action == "omit", y)
  y <- matrix(y, ncol = length(vecs))

  filter_res <- vector()
  for (row in seq_len(nrow(y))) {
    filter_res[row] <- sum(y[row, ]) == 0
  }

  names(vecs) <- purrr::map(vars, quo_name)
  filtred_data <- subset(.data, filter_res)

  if (length(factor_variables) > 0) {
    filtred_data <- filtred_data |>
      dplyr::mutate(dplyr::across(all_of(factor_variables), forcats::fct_drop))
  }

  out <- list(
    filtred_data = filtred_data,
    old_df = .data,
    tbls = tbls,
    vecs = vecs,
    filter_res = filter_res,
    na_action = na_action,
    control = control
  )
  out <- structure(
    out,
    class = c("outlier_identify", "outlier", "list")
  )
  return(out)
}
