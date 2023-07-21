discrete_helper <- function(x, fun, args) {
  new <- rlang::exec(fun, x, !!!args)
  lvl <- levels(new)[levels(new) != "Otherxxx"]
  out <- map_lgl(new, ~ .x %in% lvl)
  out
}

factor_methods <- function(.data, var, discrete_method, prop, n, freq, ties_method) {
  tbl <-
    switch(discrete_method,
      "prop" = prop_discrete(.data, var, prop),
      "n" = n_discrete(.data, var, n, ties_method),
      "low_freq" = low_freq_discrete(.data, var),
      "min_times" = min_times_discrete(),
      cli::cli_abort(c("!" = "{discrete_method} is not a valid input"))
    )
  tbl
}



prop_discrete <- function(.data, var, prop) {
  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      prop = prop,
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "mode_val" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      "unique_vars" = list(unique(!!var)),
      "outlier_vec" = list(discrete_helper(!!var, "fct_lump_prop", list(prop, NULL, "Otherxxx"))),
      outlier_pct = mean(outlier_vec[[1]], na.rm = TRUE),
      outlier_exist = outlier_pct > 0,
      non_outlier_vars = list(unique(subset(!!var, outlier_vec[[1]]))),
      outlier_vars = list(setdiff(unique_vars[[1]], non_outlier_vars[[1]])),
      "n_filtred" = length(non_outlier_vars[[1]]),
      n_outliers = length(outlier_vars[[1]]),
      "var_type" = pillar::type_sum(!!var),
    )
  tbl
}


n_discrete <- function(.data, var, n, ties_method) {
  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      n_arg = n,
      ties_method = ties_method,
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "mode_val" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      "unique_vars" = list(unique(!!var)),
      "outlier_vec" = list(discrete_helper(!!var, "fct_lump_n", list(n, NULL, "Otherxxx", ties_method))),
      outlier_pct = mean(outlier_vec[[1]], na.rm = TRUE),
      outlier_exist = outlier_pct > 0,
      non_outlier_vars = list(unique(subset(!!var, outlier_vec[[1]]))),
      outlier_vars = list(setdiff(unique_vars[[1]], non_outlier_vars[[1]])),
      "n_filtred" = length(non_outlier_vars[[1]]),
      n_outliers = length(outlier_vars[[1]]),
      "var_type" = pillar::type_sum(!!var),
    )
  tbl
}

low_freq_discrete <- function(.data, var) {
  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "mode_val" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      "unique_vars" = list(unique(!!var)),
      "outlier_vec" = list(discrete_helper(!!var, "fct_lump_lowfreq", list(NULL, "Otherxxx"))),
      outlier_pct = mean(outlier_vec[[1]], na.rm = TRUE),
      outlier_exist = outlier_pct > 0,
      non_outlier_vars = list(unique(subset(!!var, outlier_vec[[1]]))),
      outlier_vars = list(setdiff(unique_vars[[1]], non_outlier_vars[[1]])),
      "n_filtred" = length(non_outlier_vars[[1]]),
      n_outliers = length(outlier_vars[[1]]),
      "var_type" = pillar::type_sum(!!var),
    )
  tbl
}

min_times_discrete <- function(.data, var, min) {
  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      min = min,
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "mode_val" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      "unique_vars" = list(unique(!!var)),
      "outlier_vec" = list(discrete_helper(!!var, "fct_lump_min", list(min, NULL, "Otherxxx"))),
      outlier_pct = mean(outlier_vec[[1]], na.rm = TRUE),
      outlier_exist = outlier_pct > 0,
      non_outlier_vars = list(unique(subset(!!var, outlier_vec[[1]]))),
      outlier_vars = list(setdiff(unique_vars[[1]], non_outlier_vars[[1]])),
      "n_filtred" = length(non_outlier_vars[[1]]),
      n_outliers = length(outlier_vars[[1]]),
      "var_type" = pillar::type_sum(!!var),
    )
  tbl
}
