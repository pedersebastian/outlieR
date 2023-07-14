
#' @importFrom ggplot2 autoplot
#' @export

ggplot2::autoplot

#' @param object data
#' @param ... d
#'
#' @export
autoplot.outlier <- function(object, ..., type = c("histogram", "count")) {
  type <-
    match.arg(type)
  print(type)

  data <- prep_data(object, ...)
  p <- make_plot(data, type)
  p
}



##.  DATA PREP

prep_data  <- function(object, ...) {
 if (length(attributes(object)$tbls) >1) {
   data <- prep_data_many(object, ...)
 }
  else if (length(attributes(object)$tbls) == 1) {
    data <- prep_data_one(object, ...)
  }
  else {
    cli::cli_abort("noe feil as")
  }
  data

}

prep_data_one <- function(object, ...) {

  summary_tbl <- attr(object, "tbl")[[1]]
  var_name <- summary_tbl$var
  dat <- attr(object, "old_df")



  dat["out_textlll"] <- ifelse(dat[[var_name]] > summary_tbl$upper, "Outlier (>)", ifelse(dat[[var_name]] < summary_tbl$lower, "Outlier (<)", "No Outlier"))


  dat <- dat |>
    dplyr::mutate(out_textlll = factor(out_textlll, levels = c("Outlier (<)","No Outlier",  "Outlier (>)"))) |>
    dplyr::filter(!is.na(out_textlll))


  out <- structure(
    list(old_obj = object,
         summary_tbl = summary_tbl,
         var_name = var_name,
         dat = dat
         ),
    one_variable = TRUE
  )
  out
}

prep_data_many <- function(object, ...) {
  out <- object
  attributes(out) <- c("one_variable" = FALSE, attributes(out))
}






#$

# xxx <- prep_data_one(filtred)
#
# make_single_histogram(xxx)
