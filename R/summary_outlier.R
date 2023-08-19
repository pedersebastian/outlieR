#' @export
summary.outlier <- function(object, ...) {


  tbls <- object$tbls |> dplyr::bind_rows()

  col_names <-
    c("Variable", "Variable Type", "Outlier Exist?", "N Outliers", "% Outlier", "N of NAs")

  summary_tbl <-
    tbls |>
    dplyr::mutate(
      outlier_pct = ifelse(outlier_pct == 0, "", glue::glue(" {round(outlier_pct*100, 1)} %")),
      outlier_exist = ifelse(outlier_exist, "Yes", "No")
    ) |>
    dplyr::select(all_of(c("var", "var_type", "outlier_exist", "n_outliers", "outlier_pct", "na_count"))) |>
    knitr::kable(col.names = col_names)

  print(object, ...)
  cat("\n")
  cli::cat_rule("Summary Table of outliers")
  print(summary_tbl)

  return(invisible(object))
}
