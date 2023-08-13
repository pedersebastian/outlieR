#' Filter a data frame/ tibble of outliers
#'
#' @param object an object created by identify_outlier
#' @param ... not currently fused
#'
#' @return a tbl/dataframe
#' @export
#'
#' @examples
#' print("hei")
filter_outlier  <- function(object, ...) {
  UseMethod("filter_outlier")
}
#' @export
filter_outlier.default <- function(object, ...) {
  cli::cli_abort(c("x" = "filter_outlier is not supported for an object with class {.class {class(object)}}",
                   "i" = "Did you forget to use {.fun identify_outlier} first? "))
}
#' @export
filter_outlier.outlier_identify <- function(object, ...) {

  out <-
    structure(object$filtred_data,
              old_df = object$old_df,
              tbls = object$tbls,
              vecs = object$vecs,
              filter_res = object$filter_res,
              na_action = object$na_action,
              control = object$control,
              class = c("outlier_filter",
                        "outlier",
                        class(object$filtred_data)))

  out
}
