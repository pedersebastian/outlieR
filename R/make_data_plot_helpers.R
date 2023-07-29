prep_data_many_discrete <- function(data, dis_name, summary_tbl, na_action) {
  if (length(dis_name) < 1) {
    return(NULL)
  }

  fakevar <- sample(c(LETTERS,
                      letters,
                      1:10, c("!", "?", "&", "$", "#")),
                    size = 20) |>
    paste0(collapse = "")
  out <-
    data |>
    dplyr::select(all_of(dis_name)) |>
    tidyr::pivot_longer(everything(),
      names_to = "var"
    )

  if (any(is.na(out$value))) {
    if (na_action == "keep") {
      ## NA becomes its own factor level
      out <- dplyr::mutate(out, value = ifelse(is.na(value), "NA", value))
    } else {
      out <-
        dplyr::mutate(out, value = ifelse(is.na(value), fakevar, value))
    }
  }

  out <-
    out |>
    tidyr::nest(data = -var) |>
    dplyr::left_join(summary_tbl, dplyr::join_by(var)) |>
    dplyr::select(var, data, outlier_vec) |>
    tidyr::unnest(c(data, outlier_vec)) |>
    filter(value != fakevar) |>
    dplyr::mutate(outlier_vec = !outlier_vec)

  out
}
#######


########################################################################
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
      outlier_var = factor(outlier_var, levels = c("Outlier (<)",
                                                   "No Outlier",
                                                   "Outlier (>)")),
      count_var = length(variable_names)
    )
  data
}

logical_helper_many <- function(data) {
  data <- data |>
    dplyr::mutate(outlier_var = purrr::pmap(list(value, upper, lower), out_help))


  if (!data$outlier_exist[[1]]) {
    data <- dplyr::mutate(data,
      outlier_var = ifelse(value,
                           "No Outlier (TRUE)",
                           "No Outlier (FALSE)"),
      outlier_var = factor(outlier_var,
                           levels = c("No Outlier (FALSE)",
                                      "No Outlier (TRUE)"))
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
  data
}
