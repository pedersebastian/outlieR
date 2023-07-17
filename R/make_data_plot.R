## .  DATA PREP



prep_data <- function(object, type, ...) {
  if (length(attr(object, "tbls")) > 1) {
    data <- prep_data_many(object, type, ...)
  } else if (length(attr(object, "tbls")) == 1) {
    data <- prep_data_one(object, type, ...)
  } else {
    cli::cli_abort("noe feil as")
  }
  data
}

prep_data_one <- function(object, type, ...) {
  summary_tbl <- attr(object, "tbl")[[1]]
  var_name <- summary_tbl$var
  dat <- attr(object, "old_df")


  if (summary_tbl$var_type == "lgl") {
    # dat <- prep_logical_data(dat, summary_tbl["outlier_exist"], summary_tbl["mean_var"])
    dat <- prep_data_many_logical(data = dat, var_name, summary_tbl)


    ## Hvis det ikke finnes outlier er data ok som det er.
  } else if (summary_tbl$var_type %in% c("dbl")) {
    dat["outlier_var"] <- ifelse(dat[[var_name]] > summary_tbl$upper, "Outlier (>)", ifelse(dat[[var_name]] < summary_tbl$lower, "Outlier (<)", "No Outlier"))
    dat <- dat |>
      dplyr::mutate(outlier_var = factor(outlier_var, levels = c("Outlier (<)", "No Outlier", "Outlier (>)"))) |>
      dplyr::filter(!is.na(outlier_var))
  }
  class_var <- c("outlier_data", glue::glue("outlier_{summary_tbl$var_type}_{type}"), "list")



  out <- structure(
    list(
      summary_tbl = summary_tbl,
      var_name = var_name,
      dat = dat
    ),
    one_variable = TRUE,
    variable_type = summary_tbl$var_type,
    class = class_var
  )
  out
}

prep_data_many <- function(object, type, ...) {
  summary_tbl <- attr(object, "tbls") |> dplyr::bind_rows()
  vars_name <- summary_tbl$var

  lgl_names <- summary_tbl["var"][summary_tbl["var_type"] == "lgl"]
  dbl_names <- summary_tbl["var"][summary_tbl["var_type"] == "dbl"]

  lgl <- length(lgl_names)
  dbl <- length(dbl_names)
  other <- length(vars_name) - lgl - dbl




  dbl_data <-
    prep_data_many_numeric(attr(object, "old_df"), dbl_names, summary_tbl)
  lgl_data <-
    prep_data_many_logical(attr(object, "old_df"), lgl_names, summary_tbl)

  class_var <- c("outlier_data", glue::glue("outlier_lgl{lgl>1}_dbl{dbl>0}_other{other>1}_{type}"), "list")

  out <- structure(
    list(
      summary_tbl = summary_tbl,
      vars_name = vars_name,
      dat = list(
        dbl_data = dbl_data,
        lgl_data = lgl_data
      )
    ),
    "one_variable" = FALSE,
    "lgl" = lgl,
    "dbl" = dbl,
    "other" = other,
    "total_count" = length(vars_name),
    class = class_var
  )
  print(class_var)
  out
}



prep_data_many_logical <- function(data, variable_names, summary_tbl) {
  if (length(variable_names) < 1) {
    return(NULL)
  }
  data <-
    data |>
    dplyr::select(all_of(variable_names)) |>
    tidyr::pivot_longer(everything(), names_to = "var") |>
    dplyr::filter(!is.na(value)) |>
    dplyr::left_join(summary_tbl, by = dplyr::join_by("var")) |>
    dplyr::group_by(var) |>
    tidyr::nest(datafr = c(everything(), -var)) |>
    mutate(
      datafr = purrr::map(datafr, logical_helper_many),
      count_var = dplyr::n()
    ) |>
    tidyr::unnest(datafr) |>
    dplyr::ungroup()
  data
}



prep_data_many_numeric <- function(data, variable_names, summary_tbl) {
  if (length(variable_names) < 1) {
    return(NULL)
  }


  data <-
    data |>
    dplyr::select(all_of(variable_names)) |>
    tidyr::pivot_longer(everything(), names_to = "var") |>
    dplyr::filter(!is.na(value)) |>
    dplyr::left_join(summary_tbl, by = dplyr::join_by("var")) |>
    dplyr::mutate(
      outlier_var = dplyr::case_when(
        value > upper ~ "Outlier (>)",
        value < lower ~ "Outlier (<)",
        TRUE ~ "No Outlier"
      ),
      outlier_var = factor(outlier_var, levels = c("Outlier (<)", "No Outlier", "Outlier (>)")),
      count_var = length(variable_names)
    )
  data
}

logical_helper_many <- function(data) {
  data <- data |>
    dplyr::mutate(outlier_var = purrr::pmap(list(value, upper, lower), out_help))



  if (!data$outlier_exist[[1]]) {
    data <- dplyr::mutate(data,
      outlier_var = ifelse(value, "No Outlier (TRUE)", "No Outlier (FALSE)"),
      outlier_var = factor(outlier_var, levels = c("No Outlier (FALSE)", "No Outlier (TRUE)"))
    )
  } else if (data$mean_var[[1]] < 0.5) {
    normal_name <- "No Outlier (FALSE)"
    outlier_name <- "Outlier (TRUE)"

    data <- dplyr::mutate(data,
      outlier_var = ifelse(outlier_var, outlier_name, normal_name),
      outlier_var = factor(outlier_var, levels = c(normal_name, outlier_name))
    )
  } else {
    normal_name <- "No Outlier (TRUE)"
    outlier_name <- "Outlier (FALSE)"
    data <- dplyr::mutate(data,
      outlier_var = ifelse(outlier_var, outlier_name, normal_name),
      outlier_var = factor(outlier_var, levels = c(outlier_name, normal_name))
    )
  }
  print(data |> dplyr::count(outlier_var))
  data
}




# ?????????????????????
# prep_logical_data <- function(data, outlier_exist, mean_var) {
#   if (outlier_exist & mean_var > 0.5) {
#     # mest True
#     data <- data |>
#       dplyr::mutate(
#         outlier_var = ifelse(outlier_var == "No Outlier", "No Outlier (TRUE)", "Outlier (FALSE)"),
#         outlier_var = factor(outlier_var, levels = c("Outlier (FALSE)", "No Outlier (TRUE)"))
#       )
#   } else if (outlier_exist & mean_var < 0.5) {
#     ## mest false
#     data <- data |>
#       dplyr::mutate(
#         outlier_var = ifelse(outlier_var == "No Outlier", "No Outlier (FALSE)", "Outlier (TRUE)"),
#         outlier_var = factor(outlier_var, levels = c("No Outlier (FALSE)", "Outlier (TRUE)"))
#       )
#   }
#   data
# }
