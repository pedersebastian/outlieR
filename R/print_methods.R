#' @export
print.outlier_identify <- function(x, ...) {
  vec_raw <- x$filter_res
  if (mean(vec_raw, na.rm = TRUE) < 1) {
    # finnes outliers
    first_text <-
      glue::glue("{sum(vec_raw == FALSE, na.rm = TRUE)} Outliers were removed of {length(vec_raw)} rows.")
  } else {
    first_text <-
      "No Outliers were removed"
  }
  cli::cat_rule(first_text)
  cat("\n")
}
