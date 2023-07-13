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
      var = rlang::quo_name(var),
      mean_var = mean(!!var, na.rm = TRUE),
      sd_var = sd(!!var, na.rm = TRUE),
      upper = mean_var + sd_var * threshold,
      lower = mean_var - sd_var * threshold
    )

  tbl
}





outlier_MAD <- function(.data, var, threshold) {
  tbl <-
    dplyr::summarise(.data,
      var = rlang::quo_name(var),
      median_var = median(!!var, na.rm = TRUE),
      resid_median = median(abs(!!var) - median_var, na.rm = TRUE),
      upper = median_var + resid_median * threshold,
      lower = median_var - resid_median * threshold
    )

  tbl
}
outlier_IQD <- function(.data, var, threshold) {
  tbl <-
    dplyr::summarise(.data,
      var = rlang::quo_name(var),
      median_var = median(!!var, na.rm = TRUE),
      q_25 = quantile(!!var, 0.25, na.rm = TRUE, names = FALSE),
      q_75 = quantile(!!var, 0.75, na.rm = TRUE, names = FALSE),
      interquartile_deviation = q_75 - q_25,
      # diff = !!var - median_var,
      upper = median_var + interquartile_deviation * threshold,
      lower = median_var - interquartile_deviation * threshold
    )

  tbl
}

outlier_t_test <- function(.data, var, conf_level) {
  tbl <-
    dplyr::summarise(.data,
      var = rlang::quo_name(var),
      mean_var = mean(!!var, na.rm = TRUE),
      upper = purrr::pluck(t.test(!!var, mu = mean_var, conf.level = conf_level), "conf.int", 2),
      lower = purrr::pluck(t.test(!!var, mu = mean_var, conf.level = conf_level), "conf.int", 1)
    )

  tbl
}






out_help <- function(number, upper, lower) {
  return(number > upper | number < lower)
}
