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



## .  DATA PREP

prep_data <- function(object, ...) {
  if (length(attributes(object)$tbls) > 1) {
    data <- prep_data_many(object, ...)
  } else if (length(attributes(object)$tbls) == 1) {
    data <- prep_data_one(object, ...)
  } else {
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
    dplyr::mutate(out_textlll = factor(out_textlll, levels = c("Outlier (<)", "No Outlier", "Outlier (>)"))) |>
    dplyr::filter(!is.na(out_textlll))


  out <- structure(
    list(
      summary_tbl = summary_tbl,
      var_name = var_name,
      dat = dat
    ),
    one_variable = TRUE
  )
  out
}

prep_data_many <- function(object, ...) {
  summary_tbl <- attr(object, "tbls") |> dplyr::bind_rows()
  vars_name <- summary_tbl$var

  dat <-
    attr(object, "old_df") |>
    dplyr::select(all_of(vars_name)) |>
    tidyr::pivot_longer(everything(), names_to = "var") |>
    dplyr::filter(!is.na(value)) |>
    dplyr::left_join(sum_tbl, by = dplyr::join_by("var")) |>
    dplyr::mutate(test = dplyr::case_when(
      value > upper ~ "Outlier (>)",
      value < lower ~ "Outlier (<)",
      TRUE ~ "No Outlier"
    ))


  out <- structure(
    list(
      summary_tbl = summary_tbl,
      vars_name = vars_name,
      dat = dat
    ),
    one_variable = FALSE
  )

  out
}

fu



# $

# xxx <- prep_data_one(filtred)
#
# make_single_histogram(xxx)
