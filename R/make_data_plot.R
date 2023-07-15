
## .  DATA PREP

prep_data <- function(object, type, ...) {
  if (length(attr(object, "tbls")) > 1) {
    data <- prep_data_many(object, ...)
    if (attr(object, "tbls")$var_type == "lgl" & type == "histogram") {
      cli::cli_abort("Not supported, use count!")
    }
  } else if (length(attr(object, "tbls")) == 1) {
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

  dat["outlier_var"] <- ifelse(dat[[var_name]] > summary_tbl$upper, "Outlier (>)", ifelse(dat[[var_name]] < summary_tbl$lower, "Outlier (<)", "No Outlier"))



  if (summary_tbl$var_type == "lgl") {
    if (summary_tbl["outlier_exist"] & summary_tbl["mean_var"]>0.5) {
      #mest True
      dat <- dat |>
        mutate(outlier_var = ifelse(outlier_var == "No Outlier", "No Outlier (TRUE)", "Outlier (FALSE)"),
               outlier_var = factor(outlier_var, levels = c("Outlier (FALSE)", "No Outlier (TRUE)")))
    }
    else if (summary_tbl["outlier_exist"] & summary_tbl["mean_var"]<0.5) {
      ##mest false
      dat <- dat |>
        mutate(outlier_var = ifelse(outlier_var == "No Outlier", "No Outlier (FALSE)", "Outlier (TRUE)"),
               outlier_var = factor(outlier_var, levels = c("No Outlier (FALSE)", "Outlier (TRUE)")))
    }
    ##Hvis det ikke finnes outlier er data ok som det er.


  }
  else if (summary_tbl$var_type %in% c("dbl")) {
    dat <- dat |>
      dplyr::mutate(outlier_var = factor(outlier_var, levels = c("Outlier (<)", "No Outlier", "Outlier (>)"))) |>
      dplyr::filter(!is.na(outlier_var))
  }



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
    dplyr::left_join(summary_tbl, by = dplyr::join_by("var")) |>
    dplyr::mutate(outlier_var = dplyr::case_when(
      value > upper ~ "Outlier (>)",
      value < lower ~ "Outlier (<)",

      TRUE ~ "No Outlier"
    ),
    outlier_var = factor(outlier_var, levels = c("Outlier (<)", "No Outlier", "Outlier (>)")))


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
