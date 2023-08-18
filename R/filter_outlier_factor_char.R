factor_methods <- function(.data,
                           var,
                           discrete_method,
                           prop,
                           n_vars,
                           min_times,
                           freq,
                           ties_method,
                           na_action) {
  tbl <- table_getter_discrete(
    .data,
    var,
    discrete_method,
    prop,
    n_vars,
    min_times,
    freq,
    ties_method,
    na_action
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
