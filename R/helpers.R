get_tbl <- function(.data, var, method, threshold, conf_level) {
  tbl <- switch(method,
    "mean_sd" = outlier_mean_sd(.data, var, threshold),
    "MAD" = outlier_MAD(.data, var, threshold),
    "IQD" = outlier_IQD(.data, var, threshold),
    "t_test" = outlier_t_test(.data, var, conf_level)
  )
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
      "lower_outlier" = ifelse(any(!!var < lower, na.rm = TRUE), lower, -Inf)
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
      resid_median = median(abs(!!var) - median_var, na.rm = TRUE),
      upper = median_var + resid_median * threshold,
      lower = median_var - resid_median * threshold,
      "var_type" = pillar::type_sum(!!var),
      "outlier_exist" = length(unique(out_help(!!var, upper, lower))) != 1,
      "outlier_pct" = mean(out_help(!!var, upper, lower), na.rm = TRUE),
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "upper_outlier" = ifelse(any(!!var > upper, na.rm = TRUE), upper, Inf),
      "lower_outlier" = ifelse(any(!!var < lower, na.rm = TRUE), lower, -Inf)
    )

  tbl
}
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
      "lower_outlier" = ifelse(any(!!var < lower, na.rm = TRUE), lower, -Inf)
    )

  tbl
}

outlier_t_test <- function(.data, var, conf_level) {
  tbl <-
    dplyr::summarise(.data,
      var = rlang::quo_name(var),
      mean_var = mean(!!var, na.rm = TRUE),
      min_var = min(!!var, na.rm = TRUE),
      max_var = max(!!var, na.rm = TRUE),
      upper = purrr::pluck(t.test(!!var, mu = mean_var, conf.level = conf_level), "conf.int", 2),
      lower = purrr::pluck(t.test(!!var, mu = mean_var, conf.level = conf_level), "conf.int", 1),
      "var_type" = pillar::type_sum(!!var),
      "outlier_exist" = length(unique(out_help(!!var, upper, lower))) != 1,
      "outlier_pct" = mean(out_help(!!var, upper, lower), na.rm = TRUE),
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "upper_outlier" = ifelse(any(!!var > upper, na.rm = TRUE), upper, Inf),
      "lower_outlier" = ifelse(any(!!var < lower, na.rm = TRUE), lower, -Inf)
    )

  tbl
}




#################################################################################

out_help <- function(number, upper, lower) {
  return(number > upper | number < lower)
}

Freedman_Diaconis_binwidth <- function(x) {
  # https://stats.stackexchange.com/questions/798/calculating-optimal-number-of-bins-in-a-histogram
  if (!is.numeric(x) | length(x) < 1) {
    cli::cli_abort(paste0(deparse1(substitute(x)), " must be a numeric vector > 0 "))
  }
  return(2 * stats::IQR(x, na.rm = TRUE) / (length(x)^(1 / 3)))
}



get_errormes <- function(class) {

  x = grepl("TRUE", strsplit(class, "_")[[1]][2:3]) |> as.logical()
  if (all(x)) {
    mes = "Outlierplot for both logical and double variables is not yet supported "
  }
  else {
    if (isTRUE(x[[1]])) {
      mes = "Outlierplot for multiple logical variables is not yet supported. "
    }
    else {
      mes = "Outlierplot for multiple double variables is not yet supported "
    }
  }
  paste0(mes, "for plottype '", strsplit(class, "_")[[1]][[5]], "'")
}

