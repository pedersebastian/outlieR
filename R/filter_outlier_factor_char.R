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
  tbl$outlier_vec <-
    list(!tbl$outlier_vec[[1]])

  if (na_action == "keep") {
    tbl <-
      factor_na(.data, tbl)
  }
  tbl
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
      "variance" = all_var_equal(!!var),
      "outlier_vec" = list(discrete_helper(
        !!var,
        "fct_lump_prop",
        list(prop, NULL, "Otherxxx")
      )),
      "outlier_vec" = purrr::map2(variance, outlier_vec, fix_zero_variance),
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
      "variance" = all_var_equal(!!var),
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
      "outlier_vec" = purrr::map2(variance, outlier_vec, fix_zero_variance),
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
      "variance" = all_var_equal(!!var),
      "outlier_vec" = list(discrete_helper(
        !!var,
        "fct_lump_lowfreq",
        list(
          NULL,
          "Otherxxx"
        )
      )),
      "outlier_vec" = purrr::map2(variance, outlier_vec, fix_zero_variance),
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
      "variance" = all_var_equal(!!var),
      "outlier_vec" = list(discrete_helper(
        !!var,
        "fct_lump_min",
        list(
          min_times,
          NULL,
          "Otherxxx"
        )
      )),
      "outlier_vec" = purrr::map2(variance, outlier_vec, fix_zero_variance),
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
