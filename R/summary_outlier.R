#' @export
summary.outlier <- function(object, ...) {
  vec_raw <- attr(res, "filter_res")
  if (mean(vec_raw, na.rm = TRUE) < 1) {
    #finnes outliers
    first_text <- glue::glue("{sum(vec_raw == FALSE)} Outliers were removed of {length(vec_raw)} rows.")
  }
  else {
    first_text = "No Outliers were removed"
  }

  tbls <- attr(object, "tbls") |> dplyr::bind_rows()
  vars <- tbls$var


  ## Maa fikse navnene slik at det ikke maa vaere n_outliers
  # [1] "var"           "mean_var"      "min_var"       "max_var"       "sd_var"        "upper"
  # [7] "lower"         "var_type"      "outlier_exist" "outlier_pct"   "na_count"      "n"
  # [13] "upper_outlier" "lower_outlier" "mode_val"      "uniques"

  summary_tbl <-
    tbls |>
    dplyr::mutate(outlier_pct = glue::glue("{round(outlier_pct*100, 1)} %"),
                  outlier_exist = ifelse(outlier_exist, "Yes", "No")) |>
    dplyr::select("Variable" = var,
                  "Variable Type" = var_type,
                  "Outlier Exist?" = outlier_exist,
                  "N Outliers" = n_outliers,
                  "% Outlier" = outlier_pct,
                  "N of NAs" = na_count) |>
#Bytte til names paa kable
    knitr::kable()
  cli::cat_boxx(first_text)
  cat("\n")
  cli::cat_rule("Summary Table of outliers")
  print(summary_tbl)
  return(invisible(object))
}
