get_tbl <- function(.data, var, num_method, discrete_method,  threshold, conf_int, prop, n, freq, ties_method, min_times) {
  var_type <- pillar::type_sum(.data[[rlang::quo_name(var)]])
  if (var_type %in% c("lgl", "dbl", "int")) {
    tbl <- switch(num_method,
      "mean_sd" = outlier_mean_sd(.data, var, threshold),
      "MAD" = outlier_MAD(.data, var, threshold),
      "IQD" = outlier_IQD(.data, var, threshold),
      "t_test" = outlier_t_test(.data, var, conf_int)
    )
  } else if (var_type %in% c("fct", "chr")) {
    tbl <- factor_methods(.data, var = var, discrete_method = discrete_method, prop = prop, n = n, freq = freq, ties_method = ties_method)
  }

  tbl
}

outlier_mean_sd <- function(.data, var, threshold) {
  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      "mean_var" = mean(!!var, na.rm = TRUE),
      "min_var" = min(!!var, na.rm = TRUE),
      "max_var" = max(!!var, na.rm = TRUE),
      "sd_var" = stats::sd(!!var, na.rm = TRUE),
      "upper" = mean_var + sd_var * threshold,
      "lower" = mean_var - sd_var * threshold,
      "var_type" = pillar::type_sum(!!var),
      "outlier_exist" = length(unique(out_help(!!var, upper, lower))) != 1,
      "outlier_pct" = mean(out_help(!!var, upper, lower), na.rm = TRUE),
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "upper_outlier" = ifelse(any(!!var > upper, na.rm = TRUE), upper, Inf),
      "lower_outlier" = ifelse(any(!!var < lower, na.rm = TRUE), lower, -Inf),
      "mode_val" = mode_vec(!!var),
      "uniques" = length(unique(!!var))
    )
  tbl
}





outlier_MAD <- function(.data, var, threshold) {
  tbl <-
    dplyr::summarise(.data,
      var = rlang::quo_name(var),
      median_var = stats::median(!!var, na.rm = TRUE),
      min_var = min(!!var, na.rm = TRUE),
      max_var = max(!!var, na.rm = TRUE),
      resid_median = median(abs(!!var - median_var), na.rm = TRUE),
      upper = median_var + (resid_median * threshold),
      lower = median_var - (resid_median * threshold),
      "var_type" = pillar::type_sum(!!var),
      "outlier_exist" = length(unique(out_help(!!var, upper, lower))) != 1,
      "outlier_pct" = mean(out_help(!!var, upper, lower), na.rm = TRUE),
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "upper_outlier" = ifelse(any(!!var > upper, na.rm = TRUE), upper, Inf),
      "lower_outlier" = ifelse(any(!!var < lower, na.rm = TRUE), lower, -Inf),
      "mode_val" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      threshold = threshold
    )

  tbl
}
#
# Interquartile range method
#
# Sort your data from low to high
# Identify the first quartile (Q1), the median, and the third quartile (Q3).
# Calculate your IQR = Q3 – Q1
# Calculate your upper fence = Q3 + (1.5 * IQR)
# Calculate your lower fence = Q1 – (1.5 * IQR)
# Use your fences to highlight any outliers, all values that fall outside your fences.

# ENDRE threshold til threshold/2???


outlier_IQD <- function(.data, var, threshold) {
  tbl <-
    dplyr::summarise(.data,
      var = rlang::quo_name(var),
      median_var = stats::median(!!var, na.rm = TRUE),
      min_var = min(!!var, na.rm = TRUE),
      max_var = max(!!var, na.rm = TRUE),
      q_25 = stats::quantile(!!var, 0.25, na.rm = TRUE, names = FALSE),
      q_75 = stats::quantile(!!var, 0.75, na.rm = TRUE, names = FALSE),
      interquartile_deviation = q_75 - q_25,
      upper = median_var + interquartile_deviation * threshold,
      lower = median_var - interquartile_deviation * threshold,
      "var_type" = pillar::type_sum(!!var),
      "outlier_exist" = length(unique(out_help(!!var, upper, lower))) != 1,
      "outlier_pct" = mean(out_help(!!var, upper, lower), na.rm = TRUE),
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "upper_outlier" = ifelse(any(!!var > upper, na.rm = TRUE), upper, Inf),
      "lower_outlier" = ifelse(any(!!var < lower, na.rm = TRUE), lower, -Inf),
      "mode_val" = mode_vec(!!var),
      "uniques" = length(unique(!!var))
    )

  tbl
}

outlier_t_test <- function(.data, var, conf_int) {
  if (dplyr::summarise(.data, "sd" = sd(!!var, na.rm = TRUE))[["sd"]] == 0) {
    ## using sd to avoid confusions with variable,
    tbl <-
      dplyr::summarise(.data,
        var = rlang::quo_name(var),
        mean_var = mean(!!var, na.rm = TRUE),
        min_var = min(!!var, na.rm = TRUE),
        max_var = max(!!var, na.rm = TRUE),
        upper = NA_integer_,
        lower = NA_integer_,
        "var_type" = pillar::type_sum(!!var),
        "outlier_exist" = FALSE,
        "outlier_pct" = 0,
        "na_count" = sum(is.na(!!var)),
        "n" = dplyr::n(),
        "upper_outlier" = Inf,
        "lower_outlier" = -Inf,
        "mode_val" = mode_vec(!!var),
        "uniques" = 1
      )
  } else {
    tbl <-
      dplyr::summarise(.data,
        var = rlang::quo_name(var),
        mean_var = mean(!!var, na.rm = TRUE),
        min_var = min(!!var, na.rm = TRUE),
        max_var = max(!!var, na.rm = TRUE),
        upper = purrr::pluck(t.test(!!var, mu = mean_var, conf.level = conf_int), "conf.int", 2),
        lower = purrr::pluck(t.test(!!var, mu = mean_var, conf.level = conf_int), "conf.int", 1),
        "var_type" = pillar::type_sum(!!var),
        "outlier_exist" = length(unique(out_help(!!var, upper, lower))) != 1,
        "outlier_pct" = mean(out_help(!!var, upper, lower), na.rm = TRUE),
        "na_count" = sum(is.na(!!var)),
        "n" = dplyr::n(),
        "upper_outlier" = ifelse(any(!!var > upper, na.rm = TRUE), upper, Inf),
        "lower_outlier" = ifelse(any(!!var < lower, na.rm = TRUE), lower, -Inf),
        "mode_val" = mode_vec(!!var),
        "uniques" = length(unique(!!var))
      )
  }
  variable_name <- tbl$var
  if (tbl$uniques < 4) {
    cli::cli_abort(c(
      "x" = "The Variable {variable_name} have less than 4 unique values, witch is not allowed. ",
      "i" = "use another method"
    ))
  }

  tbl
}




#################################################################################

out_help <- function(number, upper, lower) {
  return(number > upper | number < lower)
}


# factor_helper <- function(x, outlier_vars) {
#   unlist(map(x, ~ .x %in% outlier_vars))
# }
