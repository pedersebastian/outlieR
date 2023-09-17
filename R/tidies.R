#tidymethods
#' @importFrom generics glance augment
#' @export
generics::glance
#' @export
generics::augment

#' @export
glance.outlier_identify <- function(x, whole_tbl = FALSE, ...) {
  cols <-
    c("var","var_type", "n", "outlier_pct", "outlier_exist", "n_outliers", "na_count")

  tbls <- x$tbls |> bind_rows()
  if (!whole_tbl) {
    #cols <- colnames(tbls)[colnames(tbls) %in% cols]
    tbls <- dplyr::select(tbls, all_of(new))
    # colnames(tbls) <- c("variable",
    #                     "variable_type",
    #                     "n",
    #                     "outlier_percent",
    #                     "outlier_exist",
    #                     "n_outliers",
    #                     "n_na")

  }
  return(tbls)
}


#' @export
augment.outlier_identify <- function(x, ...) {
  x
}
