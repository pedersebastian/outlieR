discrete_helper <- function(x, fun, args) {
  new <- rlang::exec(fun, x, !!!args)
  lvl <- levels(new)
  lvl <- lvl[lvl != "Otherxxx"]
  out <- purrr::map_lgl(new, ~ .x %in% lvl)
  out
}

factor_methods <- function(.data,
                           var,
                           discrete_method,
                           prop,
                           n_vars,
                           min_times,
                           freq,
                           ties_method,
                           na_action) {
  tbl <-
    switch(discrete_method,
      "prop" = prop_discrete(.data, var, prop),
      "n" = n_discrete(.data, var, n_vars, ties_method),
      "low_freq" = low_freq_discrete(.data, var),
      "min_times" = min_times_discrete(.data, var, min_times),
      rlang::abort(c("!" = "{discrete_method} is not a valid input"),
        .internal = TRUE
      )
    )
  validate_factor_tbl(
    .data,
    var,
    discrete_method,
    prop,
    n_vars,
    min_times,
    freq,
    ties_method,
    tbl
  )
  if (na_action == "keep") {
    tbl <-
      factor_na(.data, tbl)
  }
  tbl
}


factor_na <- function(.data, tbl) {
  vec <-
    purrr::map2_lgl(.data[[tbl$var]], tbl$outlier_vec[[1]], ~ is.na(.x) + .y)
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


prop_discrete <- function(.data,
                          var,
                          prop) {
  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      prop = prop,
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "mode_val_dis" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      "unique_vars" = list(unique(!!var)),
      "outlier_vec" = list(discrete_helper(
        !!var,
        "fct_lump_prop",
        list(prop, NULL, "Otherxxx")
      )),
      outlier_pct = mean(!outlier_vec[[1]][!is.na(.data[[var]])],
        na.rm = TRUE
      ),
      outlier_exist = outlier_pct > 0,
      non_outlier_vars = list(unique(subset(
        !!var,
        outlier_vec[[1]]
      ))),
      outlier_vars = list(setdiff(
        unique_vars[[1]],
        non_outlier_vars[[1]]
      )),
      "n_filtred" = length(non_outlier_vars[[1]]),
      n_outliers = length(outlier_vars[[1]]),
      "var_type" = pillar::type_sum(!!var),
    )
  tbl
}


n_discrete <- function(.data,
                       var,
                       n_vars,
                       ties_method) {
  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      n_vars = n_vars,
      ties_method = ties_method,
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "mode_val_dis" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      "unique_vars" = list(unique(!!var)),
      "outlier_vec" = list(discrete_helper(
        !!var,
        "fct_lump_n",
        list(
          n_vars,
          NULL,
          "Otherxxx",
          ties_method
        )
      )),
      outlier_pct = mean(!outlier_vec[[1]][!is.na(.data[[var]])],
        na.rm = TRUE
      ),
      outlier_exist = outlier_pct > 0,
      non_outlier_vars = list(unique(subset(
        !!var,
        outlier_vec[[1]]
      ))),
      outlier_vars = list(setdiff(
        unique_vars[[1]],
        non_outlier_vars[[1]]
      )),
      "n_filtred" = length(non_outlier_vars[[1]]),
      n_outliers = length(outlier_vars[[1]]),
      "var_type" = pillar::type_sum(!!var),
    )
  tbl
}

low_freq_discrete <- function(.data,
                              var) {
  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "mode_val_dis" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      "unique_vars" = list(unique(!!var)),
      "outlier_vec" = list(discrete_helper(
        !!var,
        "fct_lump_lowfreq",
        list(
          NULL,
          "Otherxxx"
        )
      )),
      outlier_pct = mean(!outlier_vec[[1]][!is.na(.data[[var]])],
        na.rm = TRUE
      ),
      outlier_exist = outlier_pct > 0,
      non_outlier_vars = list(unique(subset(
        !!var,
        outlier_vec[[1]]
      ))),
      outlier_vars = list(setdiff(
        unique_vars[[1]],
        non_outlier_vars[[1]]
      )),
      "n_filtred" = length(non_outlier_vars[[1]]),
      n_outliers = length(outlier_vars[[1]]),
      "var_type" = pillar::type_sum(!!var),
    )
  tbl
}

min_times_discrete <- function(.data,
                               var,
                               min_times) {
  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      min_times = min_times,
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "mode_val_dis" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      "unique_vars" = list(unique(!!var)),
      "outlier_vec" = list(discrete_helper(
        !!var,
        "fct_lump_min",
        list(
          min_times,
          NULL,
          "Otherxxx"
        )
      )),
      outlier_pct = mean(!outlier_vec[[1]][!is.na(.data[[var]])],
        na.rm = TRUE
      ),
      outlier_exist = outlier_pct > 0,
      non_outlier_vars = list(unique(subset(
        !!var,
        outlier_vec[[1]]
      ))),
      outlier_vars = list(setdiff(
        unique_vars[[1]],
        non_outlier_vars[[1]]
      )),
      "n_filtred" = length(non_outlier_vars[[1]]),
      n_outliers = length(outlier_vars[[1]]),
      "var_type" = pillar::type_sum(!!var),
    )
  tbl
}
