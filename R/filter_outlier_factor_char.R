#
# https://analyticsindiamag.com/how-to-detect-and-treat-outliers-in-categorical-data/
# ordinale, factor, character
#

#"bruke forcats! fct_lump_...


factor_methods <- function(.data, var,discrete_method,  prop, n, freq, ties_method) {

  tbl <-
    switch (discrete_method,
    "prop" = prop_discrete(.data, var, prop),
    "n" = n_discrete(.data, var, n),
    "low_freq" = low_freq(),
    "min_times" = min_times(),
    cli::cli_abort(c("!" = "{discrete_method} is not a valid input"))
  )
  tbl
}


prop_discrete <- function(.data, var, prop) {

  var <- rlang::enquo(var)

  counts <-
    .data |>
    dplyr::count(!!var) |>
    dplyr::mutate(pct = n / sum(n))


  non_outlier_vars <-
    counts |>
    dplyr::filter(pct >= prop) |>
    dplyr::pull(!!var)

  outlier_vars <-
    counts |>
    dplyr::filter(pct < prop) |>
    dplyr::pull(!!var)

  tbl <-
    dplyr::summarise(.data,
      "var" = rlang::quo_name(var),
      prop = prop,
      "na_count" = sum(is.na(!!var)),
      "n" = dplyr::n(),
      "mode_val" = mode_vec(!!var),
      "uniques" = length(unique(!!var)),
      non_outlier_vars = list(non_outlier_vars),
      outliers_vars = list(outlier_vars),
      "n_filtred" = length(non_outlier_vars),
      n_outliers = length(outlier_vars),
      "var_type" = pillar::type_sum(!!var),
      "outlier_exist" = n_outliers > 0,
      "outlier_test" = list(.data[[var]] %in% outlier_vars),
      "outlier_pct" = mean(.data[[var]] %in% outlier_vars)
    )
  tbl
}





set.seed(123)
mtcars["V1"] <- c(rnorm(29), -100, 100, NA)
set.seed(234)
mtcars["V2"] <- c(-50, 32, rnorm(30))
mtcars["V3"] <- c(rep(TRUE, 31), FALSE)
mtcars["V4"] = c(rep(2, 31), 100)
mtcars["V5"] = c(rep(TRUE, 16), rep(FALSE, 16))
mtcars["V6"] = c(rep(FALSE, 31), TRUE)
mtcars["V7"] = c(rep(2, 31), -100)
mtcars["V8"]  = rep(FALSE, 32)
mtcars["V9"]  = c(rep(FALSE, 15), rep(NA, 16),TRUE)
mtcars["V10"]  = rep(TRUE, 32)
mtcars["V11"] = c(rep("A", 15), rep("B", 15), "B", "C") |> as.factor()


prop_discrete(mtcars, V11, prop = 0.05)


discrete_helper <- function(x, fun, args) {
  old_class = class(x)
  new <- rlang::exec(fun, x, !!!args)
  lvl <- levels(new)[levels(new) != "Otherxxx"]
  out <- map_lgl(new, ~.x %in% lvl)
  out
}

discrete_helper( mtcars$V11, "fct_lump_n", list(1, NULL, "Otherxxx", "min") )




prop_discrete2 <- function(.data, var, prop) {

  var <- rlang::enquo(var)

  tbl <-
    dplyr::summarise(.data,
                     "var" = rlang::quo_name(var),
                     prop = prop,
                     "na_count" = sum(is.na(!!var)),
                     "n" = dplyr::n(),
                     "mode_val" = mode_vec(!!var),
                     "uniques" = length(unique(!!var)),
                     "unique_vars" = list(unique(!!var)),
                     "outlier_vec" = list(discrete_helper(!!var, "fct_lump_min", list(prop, NULL, "Otherxxx"))),
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


prop_discrete2(mtcars, V11, 2) |>
  as_tibble() |> glimpse()





#
#
# tbl <-
#   dplyr::summarise(.data,
#                    "var" = rlang::quo_name(var),
#                    prop = prop,
#                    "na_count" = sum(is.na(!!var)),
#                    "n" = dplyr::n(),
#                    "mode_val" = mode_vec(!!var),
#                    "uniques" = length(unique(!!var)),
#                    non_outlier_vars = list(non_outlier_vars),
#                    outliers_vars = list(outlier_vars),
#                    "n_filtred" = length(non_outlier_vars),
#                    n_outliers = length(outlier_vars),
#                    "var_type" = pillar::type_sum(!!var),
#                    "outlier_exist" = n_outliers > 0,
#                    "outlier_test" = list(.data[[var]] %in% outlier_vars),
#                    "outlier_pct" = mean(.data[[var]] %in% outlier_vars)
#   )
# tbl
# }
