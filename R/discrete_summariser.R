table_getter_discrete <- function(.data,
                                  var,
                                  discrete_method,
                                  prop,
                                  n_vars,
                                  min_times,
                                  freq,
                                  ties_method,
                                  na_action) {
  forcats_fun <- switch(discrete_method,
    "prop" = "fct_lump_prop",
    "n" = "fct_lump_n",
    "low_freq" = "fct_lump_lowfreq",
    "min_times" = "fct_lump_min"
  )
  forcats_args <- switch(discrete_method,
    "prop" = list(
      prop,
      NULL,
      "Otherxxx"
    ),
    "n" = list(
      n_vars,
      NULL,
      "Otherxxx",
      ties_method
    ),
    "low_freq" = list(
      NULL,
      "Otherxxx"
    ),
    "min_times" = list(
      min_times,
      NULL,
      "Otherxxx"
    )
  )
  discrete_summariser(.data, var, na_action, forcats_fun, forcats_args)
}



discrete_summariser <- function(.data, var, na_action, forcats_fun, forcats_args, ...) {
  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      forcats_fun = forcats_fun,
      args = list(forcats_args),
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "mode_val_dis" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      "unique_vars" = list(unique(!!var)),
      "variance" = all_var_equal(!!var),
      "outlier_vec" = list(discrete_helper(
        !!var,
        forcats_fun,
        forcats_args
      )),
      "outlier_vec" = purrr::map2(variance, outlier_vec, fix_zero_variance),
      outlier_pct = mean(outlier_vec[[1]][!is.na(.data[[var]])],
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
      "na_vec" = list(is.na(!!var))
    )
  tbl
}
